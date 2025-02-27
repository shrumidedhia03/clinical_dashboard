# Clinical Dashboard 🏥📊  
🚀 R Package for Data Cleaning and Pre-processing of Heart Disease Dataset which originates from the [UCI Heart Disease Repository](https://archive.ics.uci.edu/dataset/45/heart+disease).
🚀 An Interactive Shiny App for Heart Disease Analysis and Dataset Comparison

This project includes:
- ✅ **A Shiny Dashboard** to explore and analyze heart disease data
- ✅ **The `patientAnalytics` R package** for cleaning and preprocessing the unstructured data
- ✅ **Automated data cleaning report** for quality assurance  

---

## **📦 Project Structure**
clinical_dashboard/
│── patientAnalytics/       # Custom R package for data cleaning
│   ├── R/                  # Contains core R scripts for data cleaning
│   ├── tests/              # Unit tests for package validation
│   ├── DESCRIPTION         # Package metadata
│   ├── README.md           # Package documentation
│   ├── man/                # Stores function documentation (.Rd help files)
│   ├── NAMESPACE           # Controls function exports and imports from other packages
│── shiny_app/              # Shiny dashboard files
│   ├── data/               # Raw datasets (Cleveland, Hungarian, etc.)
│   ├── app.R               # Main script to launch the Shiny app
│   ├── ui.R                # User interface script
│   ├── server.R            # Server-side processing script
│── reports/                # Data analysis reports
│   ├── data_cleaning_report.html  # Preprocessed data report
│   ├── cleaned_cleveland.xlsx      # Cleaned cleveland dataset export
│   ├── raw_cleveland.xlsx          # Raw cleveland dataset before removing outliers
│   ├── data_cleaning_report.Rmd    # Script for generating HTML report
│── README.md               # Project documentation (this file)
│── clinical_dashboard.Rproj # R project file for RStudio
│── .gitignore              # Git ignored files
│── patientAnalytics_0.1.0.tar.gz  # Compressed package archive

## Installation Guide
### 1. Install Required Libraries:
Before running the project, install the necessary dependencies:
```r
install.packages(c("shiny", "ggplot2", "plotly", "DT", "devtools"))
```
### 2. Install patientAnalytics Package:
The project includes a custom R package (patientAnalytics) for data preprocessing. To install it:
```r
devtools::install("patientAnalytics/")
library(patientAnalytics)
```

## Loading & Cleaning Data
Ensure variables are created in the global environment 
Recommended variables to prevent Shiny app from crashing: 
```r
cleaned_cleveland <- clean_data("path_to/clinical_dashboard/shiny_app/data/cleveland.data")
cleaned_hungarian <- clean_data("path_to/clinical_dashboard/shiny_app/data/hungarian.data")
```

## Running the Shiny App
To launch the interactive dashboard, run: 
```r
shiny::runApp("shiny_app/")
```
This will open the dashboard in your web browser.

## Running Tests
To validate the package functionality:
```r
# Check your working directory
getwd()
# If incorrect, set it to the patientAnalytics folder
setwd("C:/Users/shrum/Downloads/clinical_dashboard/patientAnalytics")

# Run package tests
devtools::test()
```
You can update/add unit tests from clinical_dashboard/patientAnalytics/tests/testthat/test-clean_data.R

## Viewing Reports 
To view the latest HTML report, open:
reports/data_cleaning_report.html

## Key Files 

| **Component**        | **Location**          | **Description**                           |
|----------------------|-----------------------|-------------------------------------------|
| 📦 **R Package**     | `patientAnalytics/`   | Contains cleaning functions               |
| 📊 **Shiny App**     | `shiny_app/`          | UI & server files                         |
| 📄 **Datasets**      | `shiny_app/data/`     | Raw heart disease data                    |
| 📜 **Reports**       | `reports/`            | Processed analysis reports                |
| 📃 **Project Guide** | `README.md`           | This file!                                |


