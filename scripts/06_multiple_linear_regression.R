# ==============================================================================
# COURSE: Introduction to Statistics for Social Sciences using R
# MODULE 6: Multiple Linear Regression & Control Variables
#
# OBJECTIVE: Estimate MLR models, control for economic prosperity (GDP per capita),
#            interpret partial regression coefficients, and compare Model Fit (Adj R²).
# ==============================================================================

# ------------------------------------------------------------------------------
# STEP 1: Load Packages & Generate Multi-Variable Social Dataset
# ------------------------------------------------------------------------------
library(tidyverse)

# Import base life expectancy data
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
  ) %>% 
  mutate(
    year_1950 = year - 1950,
    # Simulating/Incorporating GDP per capita indicator for demonstration
    # (Higher baseline for Western nations + general upward growth trajectory)
    gdp_pc = case_when(
      country == "United States" ~ 12000 * (1.02)^(year_1950),
      country == "Canada"        ~ 10000 * (1.02)^(year_1950),
      country == "Spain"         ~ 5000  * (1.025)^(year_1950),
      country == "Jamaica"       ~ 2500  * (1.012)^(year_1950),
      country == "Brazil"        ~ 3000  * (1.018)^(year_1950),
      country == "South Africa"  ~ 3500  * (1.011)^(year_1950),
      country == "India"         ~ 800   * (1.028)^(year_1950),
      country == "Nigeria"       ~ 1000  * (1.014)^(year_1950)
    ),
    log_gdp = log(gdp_pc) # Natural log transformation for economic linearity
  )


# ------------------------------------------------------------------------------
# STEP 2: Estimate Model 1 (Bivariate) vs Model 2 (Multiple Regression)
# ------------------------------------------------------------------------------
# Model 1: Life Expectancy ~ Time
m1_simple <- lm(life_exp ~ year_1950, data = social_df)

# Model 2: Life Expectancy ~ Time + Log(GDP per Capita)
m2_multiple <- lm(life_exp ~ year_1950 + log_gdp, data = social_df)

# Print full summary of Multiple Regression Model
summary(m2_multiple)


# ------------------------------------------------------------------------------
# STEP 3: Side-by-Side Model Comparison Table
# ------------------------------------------------------------------------------
cat("\n=== MODEL COMPARISON SUMMARY ===\n")
cat("Model 1 (Time Only)      - R²:", round(summary(m1_simple)$r.squared, 3), 
    "| Adj R²:", round(summary(m1_simple)$adj.r.squared, 3), "\n")
cat("Model 2 (Time + Log GDP) - R²:", round(summary(m2_multiple)$r.squared, 3), 
    "| Adj R²:", round(summary(m2_multiple)$adj.r.squared, 3), "\n\n")


# ------------------------------------------------------------------------------
# STEP 4: Visualizing the Partial Effect of Economic Development
# ------------------------------------------------------------------------------
p_mlr <- ggplot(data = social_df, aes(x = log_gdp, y = life_exp, color = country)) +
  geom_point(alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", color = "black", linewidth = 1) +
  labs(
    title = "Module 6: The Preston Curve (Life Expectancy vs. Log GDP)",
    subtitle = "Partial linear fit showing economic control variable effect",
    x = "Natural Log of GDP per Capita (log_gdp)",
    y = "Life Expectancy at Birth (Years)",
    color = "Country"
  ) +
  theme_minimal()

print(p_mlr)