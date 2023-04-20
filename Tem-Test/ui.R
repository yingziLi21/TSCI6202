library(shiny)

  shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      if(file.exists("debug")) actionButton("debug", "debug") else "",
      selectInput("dataset","Select a dataset", choices = data_choices),
      uiOutput("column_selection_x"),
      uiOutput("column_selection_y"),
      uiOutput("plot_color"),
      selectInput("geoms", "plot",
                  choices = c("geom_point()","geom_line()"))
      ),mainPanel(
      h3("column_selection"),
      plotlyOutput("plot"),
      textOutput("ggcode_text"),
      DT::DTOutput("table")
    ))
  )
)

