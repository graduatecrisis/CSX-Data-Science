library(shiny)
library(DT)
library(rvest)
library(datasets)
library(dplyr)
library(plotly)
library(stringr)

display = read.csv("display_data_12-14.csv", stringsAsFactors = F)
dummy = read.csv("dummy_data_v2.csv", stringsAsFactors = F)
tag.relation = read.csv("tag_calculation.csv", stringsAsFactors = F)

dummy.1 = dummy[-451, ]
tag.relation.1 = tag.relation
row.names(display) = display$Game
display.list = setNames(split(display, seq(nrow(display))), rownames(display))
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
                          selectInput('Namae', 'GameName', choices = display$Game)
                        ),
                        mainPanel(
                          verbatimTextOutput("trialName")
                        )

                      )
                      )
            ,

             tabPanel("chart",
                      h2(textOutput("inst1")),
                      sidebarPanel(
                        selectInput('criteria1', 'Your 1st Preference',c("None","Price","Playtime","Score")),
                        selectInput('criteria2', 'Your 2nd Preference',c("None","Price","Playtime","Score")),
                        selectInput('criteria3', 'Your 3rd Preference',c("None","Price","Playtime","Score"))
                      ),
                      h2(textOutput("inst2")),
                      sidebarPanel(

                        actionButton("update", "Search")
                      ),
                      mainPanel(DT::dataTableOutput("charteria"))
             )        
  
)
)
