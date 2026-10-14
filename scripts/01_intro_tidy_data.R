# ==============================================================================
# COURSE: Introduction to Statistics for Social Sciences using R
# MODULE 1: Workspace Setup, Data Import, Hygiene & Filtering
# 
# OBJECTIVE: Load raw Our World in Data health indicators, select relevant 
#            variables, rename columns for clean coding, and filter for 
#            our 8 comparative case-study nations from 1950 to the present.
# ==============================================================================

# ------------------------------------------------------------------------------
# STEP 1: Load Required Packages
# ------------------------------------------------------------------------------
# We load the 'tidyverse' library, which contains key data science packages:
#   - readr   : for reading CSV files into R
#   - dplyr   : for selecting, renaming, and filtering data
#   - ggplot2 : for plotting and visualization
library(tidyverse)


# ------------------------------------------------------------------------------
# STEP 2: Import Raw Data
# ------------------------------------------------------------------------------
# We use read_csv() to read the raw data file from your computer.
# The arrow operator (<-) stores the imported data into an object named 'life_df'.
life_df <- read_csv("/Users/yawdgyal/Desktop/R for github/Introduction-to-Statistics-for-Social-Sciences-using-R/data/life_expectancy_data.csv")


# ------------------------------------------------------------------------------
# STEP 3: Clean & Standardize Variable Names
# ------------------------------------------------------------------------------
# The raw dataset has headers with spaces and capital letters.
# We use:
#   - %>% (the pipe operator) to chain steps together ("and then...")
#   - select() to keep only the four columns we need
#   - rename() to convert headers into clean, lowercase names (new_name = old_name)
clean_life <- life_df %>% 
  select(Entity, Code, Year, `Life expectancy`) %>% 
  rename(
    country  = Entity,          # Rename 'Entity' to 'country'
    code     = Code,            # Rename 'Code' to 'code'
    year     = Year,            # Rename 'Year' to 'year'
    life_exp = `Life expectancy` # Rename 'Life expectancy' to 'life_exp'
  )


# ------------------------------------------------------------------------------
# STEP 4: Filter Rows for Case-Study Nations (Post-1950)
# ------------------------------------------------------------------------------
# We filter the dataset to keep observations that satisfy TWO conditions:
#   1. The country is inside our list of 8 comparative case study nations.
#   2. The year is 1950 or later (post-WWII global health era).
social_df <- clean_life %>% 
  filter(
    country %in% c("Canada", "United States", "Spain", "Jamaica", 
                   "Brazil", "India", "Nigeria", "South Africa") & 
      year >= 1950
  )


# ------------------------------------------------------------------------------
# STEP 5: Verify & Inspect Clean Data
# ------------------------------------------------------------------------------
# Print the first 6 rows of our cleaned dataset to verify the transformations.
head(social_df)