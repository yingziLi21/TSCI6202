library(shiny)

  shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset","Select a dataset", choices = data_choices),
      uiOutput("column_selection_x"),
      uiOutput("column_selection_y")
      ),mainPanel(
      h3("column_selection"),
      plotlyOutput("plot"),
      textOutput("ggcode_text"),
      DT::DTOutput("table")
    ))
  )
)
