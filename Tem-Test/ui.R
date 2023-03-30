library(shiny)
data_list<- data()$results
data_choices<- 1:nrow(data_list) %>% setNames(data_list["Item"])
-
ui<- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset","Select a dataset", choices = data_list),
      uiOutput("column_selection_x"),
      uiOutput("column_selection_y")
    ),
    mainPanel(
      h3("Column_selection"),
      DT::DTOutput("table")
    )
  )
)

