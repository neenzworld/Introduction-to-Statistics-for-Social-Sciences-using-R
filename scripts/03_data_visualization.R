# ==============================================================================
# COURSE: Introduction to Statistics for Social Sciences using R
# MODULE 3: The Social Scientist's Visual Workshop (ggplot2 Gallery)
#
# OBJECTIVE: Master 8 fundamental visual geometries to explore distributions,
#            longitudinal trends, group differences, and bivariate fits.
# ==============================================================================

# ------------------------------------------------------------------------------
# STEP 0: Ingest & Clean Data
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
  )


# ==============================================================================
# FIGURE 1: Single-Line Chart (Focusing on a Single Case Study)
# ==============================================================================
# Goal: Isolate one trajectory to analyze localized historical shifts.

india_df <- social_df %>% filter(country == "India")

p1 <- ggplot(data = india_df, aes(x = year, y = life_exp)) +
  geom_line(color = "firebrick", linewidth = 1.2) +
  geom_point(color = "darkred", size = 1.8) +
  labs(
    title = "Figure 1: Life Expectancy Trajectory in India (1950–Present)",
    subtitle = "Single-nation time series tracking post-independence progress",
    x = "Year",
    y = "Life Expectancy at Birth (Years)",
    caption = "Source: Our World in Data"
  ) +
  theme_minimal()

print(p1)


# ==============================================================================
# FIGURE 2: Multi-Line Overlay (Comparative Longitudinal Trends)
# ==============================================================================
# Goal: Overlay time series to identify global convergence or persistent gaps.

p2 <- ggplot(data = social_df, aes(x = year, y = life_exp, color = country)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Figure 2: Comparative Life Expectancy Across 8 Nations",
    subtitle = "Evaluating global health convergence across regions",
    x = "Year",
    y = "Life Expectancy at Birth (Years)",
    color = "Nation"
  ) +
  theme_minimal()

print(p2)


# ==============================================================================
# FIGURE 3: Histogram (Frequency Distribution & Modality)
# ==============================================================================
# Goal: Inspect the overall distribution shape of pooled data across all years.

p3 <- ggplot(data = social_df, aes(x = life_exp)) +
  geom_histogram(binwidth = 2, fill = "steelblue", color = "white") +
  geom_vline(aes(xintercept = mean(life_exp)), color = "red", linetype = "dashed", linewidth = 1) +
  labs(
    title = "Figure 3: Distribution of Pooled Life Expectancy (1950–Present)",
    subtitle = "Bin width = 2 years. Red dashed line indicates sample mean.",
    x = "Life Expectancy at Birth (Years)",
    y = "Count of Country-Year Observations"
  ) +
  theme_minimal()

print(p3)


# ==============================================================================
# FIGURE 4: Density Curve (Smoothed Distribution by Region)
# ==============================================================================
# Goal: Compare continuous probability distributions across groups.

# Adding a region factor for demonstration
social_df <- social_df %>% 
  mutate(region = if_else(country %in% c("Canada", "United States", "Spain"), 
                          "High Income", "Global South"))

p4 <- ggplot(data = social_df, aes(x = life_exp, fill = region)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Figure 4: Kernel Density Estimates of Life Expectancy by Region",
    subtitle = "Comparing smoothed probability distributions",
    x = "Life Expectancy (Years)",
    y = "Density",
    fill = "Regional Group"
  ) +
  theme_minimal()

print(p4)


# ==============================================================================
# FIGURE 5: Comparative Boxplot (5-Number Summary & Outlier Detection)
# ==============================================================================
# Goal: Compare medians, interquartile ranges (IQR), and spread across countries.

p5 <- ggplot(data = social_df, aes(x = reorder(country, life_exp, FUN = median), 
                                   y = life_exp, fill = country)) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  coord_flip() + # Flip axes to make country labels horizontal and readable
  labs(
    title = "Figure 5: Life Expectancy Distributions Ranked by Country Median",
    subtitle = "Box bounds represent 25th-75th percentiles (IQR); center line is Median.",
    x = "Country (Ranked)",
    y = "Life Expectancy at Birth (Years)"
  ) +
  theme_bw()

print(p5)


# ==============================================================================
# FIGURE 6: Bar Chart of Means (Categorical Aggregate Comparisons)
# ==============================================================================
# Goal: Compare single summary metrics (means) across entities.

country_means <- social_df %>% 
  group_by(country) %>% 
  summarize(mean_exp = mean(life_exp, na.rm = TRUE))

p6 <- ggplot(data = country_means, aes(x = reorder(country, mean_exp), y = mean_exp)) +
  geom_col(fill = "darkslategray", width = 0.65) +
  geom_text(aes(label = round(mean_exp, 1)), hjust = -0.2, size = 3.5) +
  coord_flip() +
  ylim(0, 90) +
  labs(
    title = "Figure 6: Average Historical Life Expectancy (1950–Present)",
    subtitle = "Overall sample mean per nation",
    x = "Nation",
    y = "Mean Life Expectancy (Years)"
  ) +
  theme_classic()

print(p6)


# ==============================================================================
# FIGURE 7: Bivariate Scatter Plot with Linear Trendline (OLS Fit)
# ==============================================================================
# Goal: Test the strength and direction of association between time and health.

p7 <- ggplot(data = social_df, aes(x = year, y = life_exp)) +
  geom_point(aes(color = country), alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed", se = TRUE) +
  labs(
    title = "Figure 7: Bivariate Scatter Plot & OLS Linear Fit",
    subtitle = "Black line = Ordinary Least Squares fit; shaded area = 95% CI",
    x = "Year",
    y = "Life Expectancy (Years)",
    color = "Country"
  ) +
  theme_minimal()

print(p7)


# ==============================================================================
# FIGURE 8: Faceted Panel View (Small Multiples)
# ==============================================================================
# Goal: Unclutter multi-country data into individual side-by-side subplots.

p8 <- ggplot(data = social_df, aes(x = year, y = life_exp)) +
  geom_area(fill = "lightblue", alpha = 0.4) +
  geom_line(color = "navy", linewidth = 1) +
  facet_wrap(~ country, ncol = 4) +
  labs(
    title = "Figure 8: Faceted Country Profiles (1950–Present)",
    subtitle = "Faceted layout with shaded area plots for isolated panel analysis",
    x = "Year",
    y = "Life Expectancy (Years)"
  ) +
  theme_bw()

print(p8)