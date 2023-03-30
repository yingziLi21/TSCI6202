library(shiny)
shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset","Select a dataset", choices = data_choices),
      uiOutput("x_var"),
      uiOutput("y_var")
    ),
    mainPanel(
      h3("Column_selection"),
      DT::DTOutput("table")
    )
  )
))

