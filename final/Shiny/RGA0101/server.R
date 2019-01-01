library(shiny)
library(datasets)
library(rvest)
library(dplyr)
library(plotly)
library(DT)
library(stringr)

# Read in data
display = read.csv("display_data_12-14.csv", stringsAsFactors = F)
dummy = read.csv("dummy_data_v2.csv", stringsAsFactors = F)
tag.relation = read.csv("tag_calculation.csv", stringsAsFactors = F)
## copy dummy dataset for calculation
dummy.1 = dummy[-451, ]
tag.relation.1 = tag.relation
row.names(display) = display$Game
display.list = setNames(split(display, seq(nrow(display))), rownames(display))

for(i in 1:326) {
  names(dummy.1)[i] = str_replace_all(names(dummy.1[i]), "\\.", " ")
}


shinyServer(function(input, output) {
  
  
  output$intro <- renderText("Data including steam games published in 2012-2014,and statistics based on SteamSpy and Metacritic.")

  output$trialName <- renderPrint({target.list = display.list[[input$Namae]]
                                  str(target.list)})
  
  output$inst1 <- renderText("Please rank the following criteria: Price, Playtime or Scores")
  
  output$inst2 <- renderText(cat("please rank the following element:", target.list$MainTags))
  
  eventReactive(input$update,{
          if(input$criteria1 == "Price") {
                dummy.1$PriceRange = dummy.1$PriceRange * 4
              } else if(input$criteria1 == "Playtime") {
                dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *4
              } else if(input$criteria1 == "Score") {
                dummy.1$Index = dummy.1$Index *4
              }
              
              if(input$criteria2 == "Price") {
                dummy.1$PriceRange = dummy.1$PriceRange * 3
              } else if(input$criteria2 == "Playtime") {
                dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *3
              } else if(input$criteria2 == "Score") {
                dummy.1$Index = dummy.1$Index *3
              }
              
              if(input$criteria3 == "Price") {
                dummy.1$PriceRange = dummy.1$PriceRange * 2
              } else if(input$criteria3 == "Playtime") {
                dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *2
              } else if(input$criteria3 == "Score") {
                dummy.1$Index = dummy.1$Index *2
              }
          }, ignoreNULL = FALSE)
  output$maintag.vector <- renderTable(unlist(strsplit(target.list$MainTags, ",")))
  output$charteria <-renderDataTable({
                  
                  a = as.vector(dummy.1[dummy.1$Game == input$Namae, 4:326])
                  cosine.value = c()
                  
                  for(i in 1:2498) {
                    b = as.vector(dummy.1[i, 4:326])
                    cosine.cal = sum(a*b)/sqrt(sum(a^2)*sum(b^2))
                    cosine.value = c(cosine.value, cosine.cal)
                  }
                  
                  recommend.list = data_frame(Name = dummy.1$Game, Similarity = cosine.value)
                  head(arrange(recommend.list, desc(Similarity)), 20)
  })
  })
