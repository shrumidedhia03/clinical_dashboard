
# patientAnalytics

<!-- badges: start -->
<!-- badges: end -->

📌 An R Package for Cleaning the UCI Heart Disease Dataset

🚀 patientAnalytics is an R package designed to clean and preprocess raw clinical data from the UCI Heart Disease Dataset (UCI Repository).

The raw dataset is unstructured and must be converted into a structured format before analysis. This package extracts, processes, and cleans the data by:
✅ Splitting the raw file into 76 structured columns (using "name" as a delimiter)
✅ Selecting the 14 most important attributes relevant for clinical analysis
✅ Cleaning numerical variables by  replacing outliers (IQR-based filtering)
✅ Validating categorical variables and replacing unacceptable values

This package ensures clean and structured clinical data, making it suitable for machine learning, statistical analysis, and research.
## Libraries
Before installing **patientAnalytics**, ensure you have the required packages:
```r
install.packages(c("shiny", "ggplot2", "plotly", "DT", "devtools"))
```

## Installation

You can install patientAnalytics from GitHub using devtools:

``` r
# Install devtools if not already installed
install.packages("devtools")

# Install the package from GitHub
devtools::install_github("https://github.com/shrumidedhia03/clinical_dashboard/blob/main/patientAnalytics_0.1.0.tar.gz")
```
After installation, load the package in R:

``` r
library(patientAnalytics)
```
## How to Use patientAnalytics
1. After installing, you can clean any raw .data file from the UCI dataset:

``` r
cleaned_cleveland <- clean_data("C:/Users/shrum/Downloads/clinical_dashboard/clinical_dashboard/shiny_app/data/cleveland.data")
```
This function:

Reads the raw file and extracts 76 attributes
Selects 14 key attributes for analysis
Cleans continuous variables by removing outliers
Drops invalid categorical values

2. Once the data is cleaned, you can run any of the following commands:

``` r
head(data)
summary(data)
dim(data)
view(data)
```

## Summary

✅ Cleans raw UCI heart disease dataset
✅ Converts unstructured data into structured format
✅ Handles missing values, outliers, and categorical inconsistencies
✅ Returns a clean dataset for analysis
