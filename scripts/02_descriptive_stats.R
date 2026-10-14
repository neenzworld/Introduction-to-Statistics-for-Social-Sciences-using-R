# ==============================================================================
# COURSE: Introduction to Statistics for Social Sciences using R
# MODULE 2: Descriptive Statistics (Central Tendency & Dispersion)
# 
# OBJECTIVE: Compute global summary metrics and country-level summary statistics
#            (mean, median, standard deviation, IQR, min, max) for life 
#            expectancy across our 8 case-study nations (1950–present).
# ==============================================================================

# ------------------------------------------------------------------------------
# STEP 1: Load Required Packages & Ensure Data is Ready
# ------------------------------------------------------------------------------
library(tidyverse)

# If 'social_df' is not already in your environment, run Module 1 first or load it:
# source("/Users/yawdgyal/Desktop/R for github/Introduction-to-Statistics-for-Social-Sciences-using-R/scripts/01_intro_tidy_data.R")


# ------------------------------------------------------------------------------
# STEP 2: Overall Sample Summary Statistics (Entire Dataset)
# ------------------------------------------------------------------------------
# We use summarize() to calculate single global summary metrics across ALL rows.
overall_stats <- social_df %>% 
  summarize(
    total_obs = n(),
    mean_exp  = mean(life_exp, na.rm = TRUE),
    median_exp= median(life_exp, na.rm = TRUE),
    sd_exp    = sd(life_exp, na.rm = TRUE),
    iqr_exp   = IQR(life_exp, na.rm = TRUE),
    min_exp   = min(life_exp, na.rm = TRUE),
    max_exp   = max(life_exp, na.rm = TRUE)
  )

# Print overall metrics
print(overall_stats)


# ------------------------------------------------------------------------------
# STEP 3: Grouped Summary Statistics (By Country)
# ------------------------------------------------------------------------------
# In comparative social science, we group by country to see regional variations.
# We use group_by(country) before summarize().
country_stats <- social_df %>% 
  group_by(country) %>% 
  summarize(
    years_tracked = n(),
    mean_exp      = round(mean(life_exp, na.rm = TRUE), 1),
    median_exp    = round(median(life_exp, na.rm = TRUE), 1),
    sd_exp        = round(sd(life_exp, na.rm = TRUE), 1),
    iqr_exp       = round(IQR(life_exp, na.rm = TRUE), 1),
    min_exp       = round(min(life_exp, na.rm = TRUE), 1),
    max_exp       = round(max(life_exp, na.rm = TRUE), 1)
  ) %>% 
  arrange(desc(mean_exp)) # Rank countries from highest to lowest average life expectancy

# Print country-level comparative table
print(country_stats)