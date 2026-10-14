# ==============================================================================
# COURSE: Introduction to Statistics for Social Sciences using R
# MODULE 4: Bivariate Analysis & Correlation Matrix
#
# OBJECTIVE: Calculate Pearson correlation coefficients (r) and test 
#            statistical significance across key social indicators.
# ==============================================================================

# ------------------------------------------------------------------------------
# STEP 1: Load Required Packages & Prepare Multi-Variable Data
# ------------------------------------------------------------------------------
library(tidyverse)

# Read primary life expectancy data
life_df <- read_csv("/Users/yawdgyal/Desktop/R for github/Introduction-to-Statistics-for-Social-Sciences-using-R/data/life_expectancy_data.csv")

social_df <- life_df %>% 
  select(Entity, Code, Year, `Life expectancy`) %>% 
  rename(
    country  = Entity,
    code     = Code,
    year     = Year,
    life_exp = `Life expectancy`
  ) %>% 
  filter(
    country %in% c("Canada", "United States", "Spain", "Jamaica", 
                   "Brazil", "India", "Nigeria", "South Africa") & 
      year >= 1950
  )


# ------------------------------------------------------------------------------
# STEP 2: Compute Bivariate Correlation (Year vs. Life Expectancy)
# ------------------------------------------------------------------------------
# We calculate Pearson's r between time (year) and life expectancy for the pooled sample
cor_test_global <- cor.test(social_df$year, social_df$life_exp, method = "pearson")

# Print complete correlation hypothesis test result
print(cor_test_global)


# ------------------------------------------------------------------------------
# STEP 3: Country-Specific Bivariate Correlations
# ------------------------------------------------------------------------------
# Compute correlation between year and life expectancy within each country
country_cors <- social_df %>% 
  group_by(country) %>% 
  summarize(
    r_value = cor(year, life_exp, use = "complete.obs"),
    p_value = cor.test(year, life_exp)$p.value,
    n_obs   = n()
  ) %>% 
  arrange(desc(r_value))

print(country_cors)


# ------------------------------------------------------------------------------
# STEP 4: Bivariate Visualization (Scatter Plot with Regression Line)
# ------------------------------------------------------------------------------
p_bivariate <- ggplot(data = social_df, aes(x = year, y = life_exp)) +
  geom_point(aes(color = country), alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", color = "black", linewidth = 1) +
  annotate("text", x = 1960, y = 80, 
           label = paste0("Global r = ", round(cor_test_global$estimate, 3), 
                          "\np < 0.001"), 
           hjust = 0, size = 4.5, fontface = "bold") +
  labs(
    title = "Module 4: Bivariate Linear Association",
    subtitle = "Scatter plot of year vs. life expectancy with fitted OLS line",
    x = "Year",
    y = "Life Expectancy (Years)",
    color = "Country"
  ) +
  theme_minimal()

print(p_bivariate)