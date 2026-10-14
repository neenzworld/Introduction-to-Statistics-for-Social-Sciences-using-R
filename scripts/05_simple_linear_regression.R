# ==============================================================================
# COURSE: Introduction to Statistics for Social Sciences using R
# MODULE 5: Simple Linear Regression Models
#
# OBJECTIVE: Estimate OLS parameters (Intercept & Slope), evaluate goodness 
#            of fit (R-squared), and interpret regression summaries.
# ==============================================================================

# ------------------------------------------------------------------------------
# STEP 1: Load Libraries & Prepare Data with Centered Predictor
# ------------------------------------------------------------------------------
library(tidyverse)

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
  # Center year at 1950 so intercept represents baseline year 1950
  mutate(year_1950 = year - 1950)


# ------------------------------------------------------------------------------
# STEP 2: Estimate Pooled OLS Regression Model using lm()
# ------------------------------------------------------------------------------
# Formula syntax: Y ~ X
model_pooled <- lm(life_exp ~ year_1950, data = social_df)

# Print regression summary output
summary(model_pooled)


# ------------------------------------------------------------------------------
# STEP 3: Extract & Store Fitted Coefficients
# ------------------------------------------------------------------------------
b0 <- coef(model_pooled)[1] # Intercept
b1 <- coef(model_pooled)[2] # Slope coefficient

cat("Estimated Intercept (b0 - 1950 baseline):", round(b0, 2), "years\n")
cat("Estimated Slope (b1 - annual change):    ", round(b1, 3), "years per year\n")


# ------------------------------------------------------------------------------
# STEP 4: Country-Specific OLS Regression Models
# ------------------------------------------------------------------------------
# Estimate separate linear regression models for each country using group_split / map
country_models <- social_df %>% 
  group_by(country) %>% 
  summarize(
    intercept_1950 = round(coef(lm(life_exp ~ year_1950))[1], 2),
    annual_gain    = round(coef(lm(life_exp ~ year_1950))[2], 3),
    r_squared      = round(summary(lm(life_exp ~ year_1950))$r.squared, 3)
  ) %>% 
  arrange(desc(annual_gain))

print(country_models)


# ------------------------------------------------------------------------------
# STEP 5: Visualize Regression Model with Fitted Lines and Prediction Interval
# ------------------------------------------------------------------------------
p_reg <- ggplot(data = social_df, aes(x = year, y = life_exp)) +
  geom_point(aes(color = country), alpha = 0.5, size = 2) +
  geom_smooth(method = "lm", color = "black", linewidth = 1.2, se = TRUE) +
  annotate("label", x = 1955, y = 80, 
           label = paste0("OLS Model:\nLife Exp = ", round(b0, 1), " + ", round(b1, 3), "(Year - 1950)\n",
                          "R² = ", round(summary(model_pooled)$r.squared, 3)),
           hjust = 0, fill = "white", size = 4) +
  labs(
    title = "Module 5: Ordinary Least Squares (OLS) Regression Model",
    subtitle = "Predicting Life Expectancy as a linear function of time",
    x = "Year",
    y = "Life Expectancy at Birth (Years)",
    color = "Country"
  ) +
  theme_minimal()

print(p_reg)