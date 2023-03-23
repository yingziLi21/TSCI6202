#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(plotly)
library(ggplot2)
library(dplyr)

data1<- SharedData$new(faithful)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
          sidebarPanel(width='1px'),

        # Show a plot of the generated distribution
        mainPanel(
           plotlyOutput("distPlot"),
           DT::dataTableOutput(outputId = 'DT1', width = '90%')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {


    output$distPlot <- renderPlotly({

      #yvals<-input$yvals
      #ycols<-names(input) %>% grep('^ycol_',.,val=TRUE) %>%
        #sapply(function(ii){input[[ii]]});
      #if(length(yvals) == 3) browser();
      ggplotly(ggplot(data1,aes(x=eruptions))+
                 #mapply(makegeomline,yvals,ycols)+mapply(makegeompoint,yvals)) %>%
        geom_point(aes(y=waiting)))%>%
        highlight(color = "red",on = "plotly_click")
                 #layout(dragmode="select") %>%
        #event_register("plotly_selected")

    })
    output$DT1 <- DT::renderDataTable({datatable(data1,options=list(deferRender=FALSE))},server = FALSE)
}

# Run the application
shinyApp(ui = ui, server = server)
