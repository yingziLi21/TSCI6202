#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$decol<-renderUI({
    yvals<-input$yvals
    ylables<-paste0('ycol_',yvals)
    selectInput("ycols4", "Colors",
                choices = defaultpalette, selected = defaultpalette[1],
                multiple = TRUE)
  })



    output$distPlot <- renderPlotly({

      yvals<-input$yvals
      ycols<-names(input) %>% grep('^ycol',.,val=TRUE) %>%
        sapply(function(ii){input[[ii]]});
      if(length(yvals) == 3) browser();
      ggplotly(ggplot(data1,aes(x=reporting_date))+mapply(makegeomline,yvals,ycols)) %>%
        layout(dragmode="select") %>%
        event_register("plotly_click")

    })

})

#Matching number of variables of colors
