library(shiny)
library(ggplot2)
library(plotly)
library(DT)

ui <- fluidPage(
  titlePanel("Heart Disease Analysis Dashboard"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("age_range", "Select Age Range:", min = min(cleaned_cleveland$age), max = max(cleaned_cleveland$age), value = c(min(cleaned_cleveland$age), max(cleaned_cleveland$age))),
      selectInput("sex", "Select Gender:", choices = c("All", "Male" = 1, "Female" = 0), selected = "All"),
      selectInput("cp", "Chest Pain Type:", choices = c("All", unique(cleaned_cleveland$cp)), selected = "All"),
      selectInput("num", "Heart Disease Status:", choices = c("All", "No Disease (0)" = 0, "Disease Present (1)" = 1), selected = "All"),
      actionButton("apply_filters", "Apply Filters", class = "btn-primary")
    ),
    
    
    mainPanel(
      tabsetPanel(
        tabPanel("Overview", plotOutput("bar_chart")),
        tabPanel("Age vs. Heart Rate", plotlyOutput("scatter_plot")),
        tabPanel("Cholesterol vs. BP", plotlyOutput("chol_bp_plot")),
        
  
        # New Dataset Comparison Tab
        tabPanel("Dataset Comparison",
                 selectInput("compare_var", "Select Variable:", 
                             choices = as.character(names(cleaned_cleveland)), 
                             selected = names(cleaned_cleveland)[1]),
                 
                 plotlyOutput("compare_hist"),  # Histogram for comparison
                 DTOutput("comparison_table")   # Summary table for comparison
        ),
        
        tabPanel("Data Table", DTOutput("filtered_table"))
      )
    )
  )
)
