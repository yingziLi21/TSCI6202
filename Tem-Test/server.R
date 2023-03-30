library(shiny)
library(DT)
library(ggplot2)

server<- function(input,output) {
  dataset<- reactive({
    selected_data<- data_list[as.integer(input$dataset),]
    browser()
    get(selected_data["Item"],pasteO("package:", selected_data["Package"]))
  })

  output$column_selection_x<- renderUI({
    if(is.null(dataset())) return()
    selectInput("x_var", "Select X varibale", choices = names(dataset()))
  })
    output$column_selection_y<- renderUI({
      if(is.null(dataset())) return()
    selectInput("y_var", "Select Y variable", choices = names(dataset()))
  })

   output$table<- DT::renderDT({
     if (is.null(dataset())||!all(c(input$x_var, input$y_var) %in% names(data))) return()
     data<- dataset()
     DT::datatable(data[, c(input$x_var, input$yvals)])
   })
}