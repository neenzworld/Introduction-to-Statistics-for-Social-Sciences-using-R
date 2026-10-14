# ==============================================================================
# COURSE: Introduction to Statistics for Social Sciences using R
# MODULE 7: Categorical Predictors, Dummy Variables & Interaction Terms
#
# OBJECTIVE: Incorporate categorical dummy variables and interaction terms to
#            evaluate regional differences in baseline health and annual growth rates.
# ==============================================================================

# ------------------------------------------------------------------------------
# STEP 1: Load Packages & Recode Regional Categorical Dummy
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
  mutate(
    year_1950 = year - 1950,
    # Create categorical region indicator
    region = if_else(country %in% c("Canada", "United States", "Spain"), 
                     "High_Income", "Global_South"),
    # Convert to factor with 'Global_South' as the baseline reference category
    region = factor(region, levels = c("Global_South", "High_Income"))
  )


# ------------------------------------------------------------------------------
# STEP 2: Estimate Model 1 (Main Effects with Dummy Variable)
# ------------------------------------------------------------------------------
# Model with time (year_1950) and a dummy variable for region
m1_dummy <- lm(life_exp ~ year_1950 + region, data = social_df)

summary(m1_dummy)


# ------------------------------------------------------------------------------
# STEP 3: Estimate Model 2 (Interaction Term: Time x Region)
# ------------------------------------------------------------------------------
# R syntax for interaction: year_1950 * region (includes main effects + interaction)
m2_interaction <- lm(life_exp ~ year_1950 * region, data = social_df)

summary(m2_interaction)


# ------------------------------------------------------------------------------
# STEP 4: Visualize Group Slopes via Interaction Plot
# ------------------------------------------------------------------------------
p_interact <- ggplot(data = social_df, aes(x = year, y = life_exp, color = region)) +
  geom_point(alpha = 0.4, size = 1.8) +
  geom_smooth(method = "lm", linewidth = 1.2, se = TRUE) +
  scale_color_manual(values = c("Global_South" = "darkorange", "High_Income" = "navy")) +
  labs(
    title = "Module 7: Interaction Model (Regional Trajectories)",
    subtitle = "Comparing annual life expectancy growth slopes across regional groups",
    x = "Year",
    y = "Life Expectancy at Birth (Years)",
    color = "Region"
  ) +
  theme_minimal()

print(p_interact)