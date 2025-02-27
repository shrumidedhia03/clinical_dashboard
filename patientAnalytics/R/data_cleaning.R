#' Clean Continuous Variables
#'
#' This function removes outliers using the interquartile range (IQR) method and ensures integer-only columns are rounded.
#' @param df A data frame containing numerical variables.
#' @param cols A vector of column names to clean.
#' @return A cleaned data frame with outliers replaced by column means
#' @export
clean_continuous <- function(df, cols) {
  for (col in cols) {
    Q1 <- stats::quantile(df[[col]], 0.25, na.rm = TRUE)  # First quartile (25th percentile)
    Q3 <- stats::quantile(df[[col]], 0.75, na.rm = TRUE)  # Third quartile (75th percentile)
    IQR_value <- Q3 - Q1  # Compute interquartile range (IQR)

    lower_bound <- Q1 - 1.5 * IQR_value  # Define lower bound for outliers
    upper_bound <- Q3 + 1.5 * IQR_value  # Define upper bound for outliers

    # Replacing outliers with NA
    df[[col]] <- ifelse(df[[col]] < lower_bound | df[[col]] > upper_bound, NA, df[[col]])
    

    # Impute missing values with column mean
    df[[col]][is.na(df[[col]])] <- mean(df[[col]], na.rm = TRUE)
    
    # Ensure the column contains only integers
    if (all(df[[col]] == floor(df[[col]]), na.rm = TRUE)) {
      df[[col]] <- round(df[[col]])
    }
  }
  return(df)
}

#' Clean Categorical Variables
#'
#' This function replaces invalid categorical values with mode of the column.
#'
#' @param df A data frame.
#' @param valid_values A list where each element is a vector of valid values for a categorical column.
#' @return A cleaned data frame with only valid categorical values.
#' @export
clean_categorical <- function(df, valid_values) {
  for (col in names(valid_values)) {
    # Replace invalid values with NA
    df[[col]] <- ifelse(df[[col]] %in% valid_values[[col]], df[[col]], NA)
    
    # Replace NA values with the mode (most frequent value)
    mode_value <- as.numeric(names(sort(table(df[[col]]), decreasing = TRUE)[1]))  # Calculate mode
    df[[col]][is.na(df[[col]])] <- mode_value
  }
  return(df)
}

#' Clean Raw Clinical Dataset
#'
#' Reads, processes, and cleans a clinical dataset file.
#'
#' @param file_path Path to the raw dataset file.
#' @return A cleaned dataframe with selected columns.
#' @export
clean_data <- function(file_path, preprocess = TRUE) {
  lines <- readLines(file_path, encoding = "UTF-8", warn = FALSE)
  lines <- iconv(lines, from = "UTF-8", to = "ASCII", sub = "")

  data_lines <- list()
  temp_values <- c()
  # The dataset contains 76 columns initially (reference: UCI website),
  # Extracting only 14 important ones
  for (line in lines) {
    values <- unlist(strsplit(trimws(line), " "))
    for (value in values) {
      # Encountered significant -9 values which was assumed to be placeholder
      # Treat "-9" as missing data
      if (value != "-9") {
        if (suppressWarnings(!is.na(as.numeric(value)))) {
          temp_values <- c(temp_values, as.numeric(value))
          # Identify row delimiter
        } else if (tolower(value) == "name") {
          data_lines <- append(data_lines, list(temp_values))
          temp_values <- c()
        } else {
          temp_values <- c(temp_values, NA)
        }
      } else {
        # Convert "-9" to NA
        temp_values <- c(temp_values, NA)
      }
    }
  }

  # Convert list of rows into a DataFrame
  df <- do.call(rbind, data_lines)
  df <- as.data.frame(df)

  # Selecting only relevant 14 attributes out of 76 available
  selected_columns <- c(3, 4, 9, 10, 12, 16, 19, 32, 38, 40, 41, 44, 51, 58)
  column_names <- c("age", "sex", "cp", "trestbps", "chol", "fbs", "restecg",
                    "thalach", "exang", "oldpeak", "slope", "ca", "thal", "num")

  df_selected <- df[, selected_columns]
  colnames(df_selected) <- column_names

  df_selected[] <- lapply(df_selected, function(x) as.numeric(as.character(x)))
  
  if (!preprocess) {
    return(df_selected)  # Return raw extracted data
  }

  # Define continuous and categorical columns
  continuous_cols <- c("age", "trestbps", "chol", "thalach", "oldpeak")

  # Accepted values for categorical attributes (reference: UCI website)
  valid_categorical_values <- list(
    sex = c(0, 1),
    cp = c(1, 2, 3, 4),
    fbs = c(0, 1),
    restecg = c(0, 1, 2),
    exang = c(0, 1),
    slope = c(1, 2, 3),
    ca = c(0, 1, 2, 3),
    thal = c(3, 6, 7),
    num = c(0, 1)
  )

  # Apply cleaning functions
  df_selected <- clean_continuous(df_selected, continuous_cols)
  df_selected <- clean_categorical(df_selected, valid_categorical_values)

  # Return cleaned dataset
  return(df_selected)
}
