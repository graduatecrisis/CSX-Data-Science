library(shiny)
library(DT)
library(rvest)
library(datasets)
library(dplyr)
library(plotly)
ran = read.csv("display_data_12-14.csv",stringsAsFactors = FALSE,encoding="UTF-8")

shinyUI(
  
  navbarPage("CSX_PCGame",  
             tabPanel("Intro",
                      fluidPage(theme = "bootstrap.css",
                      headerPanel("PCGame: Recommendation to your desire"),
                      textOutput("intro")
                      )
             )
             ,

             tabPanel("Gamesearch",
                      fluidPage(theme = "bootstrap.css",
                        sidebarPanel(  
                          selectInput(
                          'Namae', 'GameName', choices = ran$Game
                        )
                        ),

                        mainPanel(
                          verbatimTextOutput("trialName")
                        )

                      )
                      )
            ,

             tabPanel("chart",
                      sidebarPanel(
                        selectInput('criteria1', 'Your 1st Preference',c("None","Price","Playtime","Score")),
                        selectInput('criteria2', 'Your 2nd Preference',c("None","Price","Playtime","Score")),
                        selectInput('criteria3', 'Your 3rd Preference',c("None","Price","Playtime","Score")),
                        actionButton("update", "Search")
                      ),
                      mainPanel(DT::dataTableOutput("charteria"))
             )        
  
)
)
