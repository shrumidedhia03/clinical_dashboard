library(testthat)
library(patientAnalytics)

test_that("clean_data works correctly", {
  df <- clean_data("C:/Users/shrum/Downloads/clinical_dashboard/clinical_dashboard/shiny_app/data/cleveland.data")

  expect_true(is.data.frame(df))  # Should return a dataframe
  expect_equal(ncol(df), 14)  # Should have 14 selected columns
  expect_false(any(is.na(df)))  # No missing values
  expect_true(all(df$sex %in% c(0,1)))  # Only valid sex values
  expect_true(all(df$cp %in% c(1,2,3,4)))  # Only valid cp values

  # Can add more test cases
})
