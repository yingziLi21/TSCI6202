#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(shinyBS)
library(colourpicker)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Theme
  theme = bs_theme(primary = "#303943", secondary = "#DE511E",
                                   font_scale = NULL, bootswatch = "cosmo"),

  # Application title
  titlePanel("Bexar County COVID cases"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("yvals",
                  "plot values",
                  choices=names(data1)[-(1:3)],
                  selected=names(data1)[4],
                  multiple = TRUE
      ),
      # colourInput("color_1",
      #             defaultpalette[1]
      #
      # ),
      # selectInput("ycols",
      #             "Plot Colors",
      #             choices = defaultpalette,
      #             selected = defaultpalette[1],
      #             multiple = TRUE
      # ),
      # selectInput("ycols1",
      #             "Plot Colors",
      #             choices = defaultpalette,
      #             selected = defaultpalette[1],
      #             multiple = TRUE
      # ),
      # selectInput("ycols2",
      #             "Plot Colors",
      #             choices = defaultpalette,
      #             selected = defaultpalette[1],
      #             multiple = TRUE
      # ),
      #
      # selectInput("ycols3",
      #             "Plot Colors",
      #             choices = defaultpalette,
      #             selected = defaultpalette[1],
      #             multiple = TRUE
      # ),
      uiOutput('decol')
      ),


    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("distPlot"),
      DT::dataTableOutput(outputId = 'DT1', width = '90%')
    ))
))

