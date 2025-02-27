server <- function(input, output, session) {
  filtered_data <- reactive({
    df <- cleaned_cleveland
    
    if (input$sex != "All") {
      df <- df[df$sex == as.numeric(input$sex), , drop = FALSE]
    }
    
    if (input$cp != "All") {
      df <- df[df$cp == as.numeric(input$cp), , drop = FALSE]
    }
    
    if (input$num != "All") {
      df <- df[df$num == as.numeric(input$num), , drop = FALSE]
    }
    
    df <- df[df$age >= input$age_range[1] & df$age <= input$age_range[2], , drop = FALSE]
    
    return(df)
  })
  
  # Overview Bar Chart 
  output$bar_chart <- renderPlot({
    req(nrow(filtered_data()) > 0)  # Prevents errors if dataset is empty
    
    ggplot(filtered_data(), aes(x = factor(num), fill = factor(num))) +
      geom_bar() +
      labs(title = "Heart Disease Distribution", x = "Diagnosis (num)", y = "Count") +
      scale_fill_manual(values = c("0" = "green", "1" = "red")) +
      theme_minimal()
  })
  
  # Scatter Plot for Age vs. Max Heart Rate
  output$scatter_plot <- renderPlotly({
    req(nrow(filtered_data()) > 0)
    
    p <- ggplot(filtered_data(), aes(x = age, y = thalach, color = factor(num))) +
      geom_point(size = 2, alpha = 0.7) +
      labs(title = "Age vs. Max Heart Rate", x = "Age", y = "Max Heart Rate (thalach)", color = "Heart Disease") +
      scale_color_manual(values = c("0" = "green", "1" = "red")) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Cholesterol vs Blood Pressure Plot
  output$chol_bp_plot <- renderPlotly({
    req(nrow(filtered_data()) > 0)
    
    p <- ggplot(filtered_data(), aes(x = chol, y = trestbps, color = factor(num))) +
      geom_point(size = 2, alpha = 0.7) +
      labs(title = "Cholesterol vs. Blood Pressure", x = "Cholesterol", y = "Blood Pressure", color = "Heart Disease") +
      scale_color_manual(values = c("0" = "blue", "1" = "orange")) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Dataset Comparison Histogram
  output$compare_hist <- renderPlotly({
    req(input$compare_var)  # Ensure variable is selected
    
    # Check if the selected variable exists in both datasets
    if (!(input$compare_var %in% names(cleaned_cleveland)) || !(input$compare_var %in% names(cleaned_hungarian))) {
      return(NULL)
    }
    
    # Create long format dataset for comparison
    compare_df <- rbind(
      data.frame(Dataset = "Cleveland", Value = cleaned_cleveland[[input$compare_var]]),
      data.frame(Dataset = "Hungarian", Value = cleaned_hungarian[[input$compare_var]])
    )
    
    # Ensure column is numeric before plotting
    if (!is.numeric(compare_df$Value)) {
      return(NULL)  # Skip plotting if the variable is categorical
    }
    
    p <- ggplot(compare_df, aes(x = Value, fill = Dataset)) +
      geom_histogram(alpha = 0.6, position = "identity", bins = 30) +
      labs(title = paste("Distribution of", input$compare_var), x = input$compare_var, y = "Count") +
      scale_fill_manual(values = c("Cleveland" = "blue", "Hungarian" = "red")) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Dataset Comparison Table
  output$comparison_table <- renderDT({
    req(input$compare_var)
    
    # Check if variable exists in both datasets
    if (!(input$compare_var %in% names(cleaned_cleveland)) || !(input$compare_var %in% names(cleaned_hungarian))) {
      return(NULL)
    }
    
    # Ensure the selected variable is numeric before computing statistics
    if (!is.numeric(cleaned_cleveland[[input$compare_var]]) || !is.numeric(cleaned_hungarian[[input$compare_var]])) {
      return(NULL)
    }
    
    comparison <- data.frame(
      Metric = c("Mean", "Median", "Min", "Max"),
      Cleveland = c(mean(cleaned_cleveland[[input$compare_var]], na.rm = TRUE),
                    median(cleaned_cleveland[[input$compare_var]], na.rm = TRUE),
                    min(cleaned_cleveland[[input$compare_var]], na.rm = TRUE),
                    max(cleaned_cleveland[[input$compare_var]], na.rm = TRUE)),
      Hungarian = c(mean(cleaned_hungarian[[input$compare_var]], na.rm = TRUE),
                    median(cleaned_hungarian[[input$compare_var]], na.rm = TRUE),
                    min(cleaned_hungarian[[input$compare_var]], na.rm = TRUE),
                    max(cleaned_hungarian[[input$compare_var]], na.rm = TRUE))
    )
    
    datatable(comparison, options = list(pageLength = 5))
  })
  
  # Data Table
  output$filtered_table <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10))
  })
}
