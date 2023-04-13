library(shiny)
library(DT)
library(ggplot2)

 server<- function(input,output) {
  dataset<- reactive({
    selected_data<- data_list[as.integer(input$dataset),]
    #browser()
    sprintf("data('%s', package='%s', envir = data_catch)",selected_data$Item,selected_data$Package) %>% parse(text=.) %>% eval
    as.list(data_catch)[[selected_data$Item]]
    #as.data.frame (get(selected_data["Item"],paste0("package:", selected_data["Package"])))
  })

   ggcode<- reactive({
    req(mydata<- data_list[as.integer(input$dataset),"Item"])
    req(x_var<-input$x_var)
    req(y_var<-input$y_var)
    sprintf("ggplot(%s,aes(x=%s,y=%s))+geom_point()",mydata,x_var,y_var)
  })
   output$ggcode_text<- renderText(ggcode())


   output$plot<- renderPlotly({
     req(myggcode<- ggcode())
     #req(mydata<- data_list[as.integer(input$dataset),"Item"])
     parse(text=myggcode) %>% eval(envir = data_catch)
   })

output$column_selection_x<- renderUI({
    if(is.null(dataset())) return()
    #browser()
    selectInput("x_var", "Select X varibale", choices = names(dataset()))
  })
    output$column_selection_y<- renderUI({
      if(is.null(dataset())) return()
    selectInput("y_var", "Select Y variable", choices = names(dataset()))
  })
    #ggplot(dataset(),aes(x=input$x_var,y=input$y_var))

    #output$plot<- renderPlotly()
    output$table<- DT::renderDT({
     if (is.null(dataset())||!all(c(input$x_var, input$y_var) %in% names(dataset()))) return()
     data<- dataset()
     DT::datatable(data[, c(input$x_var, input$y_val)])
   })
}