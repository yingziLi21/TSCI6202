library(shiny)
library(DT)
library(ggplot2)

server<- function(input,output) {
  dataset<- reactive({
    selected_data<- data_list[as.integer(input$dataset),]
    get(selected_data["Item"],paste0("package:", selected_data["Package"]))
  })

  output$x_var<- renderUI({
    if(is.null(dataset())) return()
    selectInput("x_var", "Select X varibale", choices = names(dataset()))
  })
    output$y_var<- renderUI({
      if(is.null(dataset())) return()
    selectInput("y_var", "Select Y variable", choices = names(dataset()))
  })

   output$table<- DT::renderDT({
     if (is.null(dataset())||!all(c(input$x_var, input$y_var) %in% names(dataset()))) return()
     data<- dataset()
     DT::datatable(data[, c(input$x_var, input$y_var)])
   })
}
