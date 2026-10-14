Introduction to Statistics for Social Sciences using R

Welcome to the official repository for Introduction to Statistics for Social Sciences using R, an applied, undergraduate/graduate-level introductory curriculum. This course bridges quantitative social methodology, reproducible data wrangling with the tidyverse, publication-ready visualizations with ggplot2, and parametric econometric/statistical modeling using R and Quarto (.qmd).
🎯 Course Overview & Pedagogical Philosophy

Many social science students encounter statistics as abstract mathematics divorced from substantive policy and historical questions. This curriculum takes a data-first, computational approach:

    Reproducibility First: All workflows utilize standard directory paths, explicit data hygiene pipelines, and self-contained Quarto documents that compile to production-ready HTML reports and slide decks.

    Substantive Context: Rather than synthetic toy datasets, students work with longitudinal international development indicators to explore post-WWII public health gains, structural global inequalities, and exogenous shocks (e.g., epidemics, economic crises).

    Step-by-Step Scaffolding: Concepts progress logically from data ingestion → descriptive summaries → visual exploration → bivariate correlation → simple linear regression → multiple regression controls → dummy interaction models.

📁 Repository Directory Structure
text

Introduction-to-Statistics-for-Social-Sciences-using-R/
├── .gitignore                            # Excludes R history and workspace state
├── README.md                             # Comprehensive course & repository documentation
├── data/
│   └── life_expectancy_data.csv          # Raw Our World in Data (OWID) health metrics
├── scripts/
│   ├── 01_intro_tidy_data.R              # Module 1: Workspace setup & data hygiene
│   ├── 02_descriptive_stats.R            # Module 2: Central tendency & dispersion
│   ├── 03_data_visualization.R           # Module 3: Visual workshop (8-chart gallery)
│   ├── 04_bivariate_analysis.R           # Module 4: Pearson correlation & hypothesis tests
│   ├── 05_simple_linear_regression.R     # Module 5: OLS regression models
│   ├── 06_multiple_linear_regression.R   # Module 6: Control variables & economic metrics
│   └── 07_interaction_terms.R            # Module 7: Dummy variables & interaction models
├── reports/
│   ├── lab-1-intro.qmd                   # Module 1 Quarto lab report
│   ├── lab-2-descriptive-stats.qmd       # Module 2 Quarto lab report
│   ├── lab-3-data-visualization.qmd      # Module 3 Quarto lab report
│   ├── lab-4-bivariate-analysis.qmd      # Module 4 Quarto lab report
│   ├── lab-5-linear-regression.qmd       # Module 5 Quarto lab report
│   ├── lab-6-multiple-regression.qmd     # Module 6 Quarto lab report
│   └── lab-7-interaction-terms.qmd       # Module 7 Quarto lab report
└── slides/
    └── course_presentation.qmd           # Reveal.js HTML slide deck (Modules 1–5)

📊 Dataset & Case Study Panel

The core empirical dataset is sourced from Our World in Data (OWID), tracking life expectancy at birth across global entities from 1950 to the present.

Standardized Variable Schema:
Variable	Type	Description
country	chr	Country or entity name
code	chr	ISO 3-letter country code
year	dbl	Observation year (1950–present)
life_exp	dbl	Life expectancy at birth in years

Case Study Cohort (8 Case-Study Nations):

    High-Income / Industrialized: Canada, United States, Spain

    Global South / Emerging & Developing: Brazil, India, Jamaica, Nigeria, South Africa

📚 Detailed Syllabus & Module Breakdown
Module 1: Workspace Infrastructure & Data Hygiene

Focus: Transitioning raw, messy administrative datasets into analysis-ready tidy structures.

Statistical & Computational Concepts: Pipe operator (%>%), column selection, header renaming, filtering observations, dealing with missing data (NA).

Key R Functions: readr::read_csv(), dplyr::select(), dplyr::rename(), dplyr::filter().
Module 2: Descriptive Statistics & Comparative Metrics

Focus: Summarizing central tendency and spread across national panels.

Statistical & Computational Concepts: Mean vs. Median (robustness against extreme historical shocks), Standard Deviation (SDSD) vs. Interquartile Range (IQRIQR), grouped aggregations.

Key R Functions: dplyr::group_by(), dplyr::summarize(), mean(), median(), sd(), IQR().
Module 3: The Social Scientist's Visual Workshop

Focus: Translating empirical questions into clear graphical forms using the Grammar of Graphics.

Statistical & Computational Concepts: Aesthetic mappings (aes), geometries (geom_*), small multiples (facet_wrap).

Visual Gallery (8 Figures):

    Single-Line Plot: Individual national trajectories (geom_line + geom_point).

    Multi-Line Overlay: Comparative cross-national trends (aes(color = country)).

    Frequency Histogram: Sample distribution and modality (geom_histogram).

    Kernel Density Curve: Continuous probability distribution across regional groups (geom_density).

    Comparative Boxplot: 5-number summaries, medians, and outlier detection (geom_boxplot + coord_flip).

    Bar Chart of Means: Direct group aggregate rankings (geom_col + geom_text).

    Bivariate Scatter Plot: Scatter points with overlaid linear regression trendlines (geom_point + geom_smooth).

    Faceted Panel Chart: Uncluttering complex multi-group panels (facet_wrap).

Module 4: Bivariate Correlation & Hypothesis Testing

Focus: Quantifying the direction, strength, and statistical significance of linear relationships between two continuous variables.

Statistical & Computational Concepts: Pearson's correlation coefficient (rr), null hypothesis testing (H0:ρ=0H0​:ρ=0), pp-values, tt-distributions.

Key R Functions: cor(), cor.test(), annotate().
Module 5: Simple Linear Regression Models (OLS)

Focus: Moving from association to predictive equations using Ordinary Least Squares.

Statistical & Computational Concepts: Model intercept (β0β0​), slope parameter (β1β1​), variable centering (setting baseline year 19501950), residual errors (ϵϵ), coefficient of determination (R2R2).

Key R Functions: stats::lm(), summary(lm), coef(), geom_smooth(method = "lm").
Module 6: Multiple Linear Regression & Control Variables

Focus: Evaluating multivariate relationships and holding confounding socio-economic metrics constant.

Statistical & Computational Concepts: Ceteris paribus logic, economic controls (GDP per capita), non-linear economic returns (log-transforming GDP for the Preston Curve), Adjusted R2R2.

Key R Functions: lm(Y ~ X1 + X2), log(), summary()$adj.r.squared.
Module 7: Categorical Predictors, Dummy Variables & Interaction Terms

Focus: Testing whether regression baselines (intercepts) and growth rates (slopes) differ across regional or institutional categories.

Statistical & Computational Concepts: Binary dummy variables (0/10/1), baseline reference groups, partial intercept shifts, interaction product terms (X×DX×D) for differential group slopes.

Key R Functions: factor(), lm(Y ~ X * D), scale_color_manual().
🛠️ Prerequisites & Installation Guide

To run these scripts and render the Quarto reports, install R (>= 4.0) and RStudio along with the required packages:
r

# Install core tidyverse package suite
install.packages("tidyverse")

# Install Quarto rendering support dependencies
install.packages(c("rmarkdown", "knitr"))

🚀 Getting Started

    Clone the repository:
    bash

    git clone https://github.com/your-username/Introduction-to-Statistics-for-Social-Sciences-using-R.git

    Open the project in RStudio (open the .Rproj file if available).

    Run scripts sequentially from scripts/01_intro_tidy_data.R through scripts/07_interaction_terms.R.

    Render Quarto reports by opening any .qmd file in reports/ and clicking Render, or run:
    bash

    quarto render reports/lab-1-intro.qmd

    View the slide deck by rendering slides/course_presentation.qmd to Reveal.js HTML.

📖 License

This course materials are provided for educational purposes. Please refer to the repository's license file for specific terms of use.
🙏 Acknowledgments

    Data sourced from Our World in Data

    Built with R, tidyverse, and Quarto

Happy modeling! 📈