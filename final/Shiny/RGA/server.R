library(shiny)
library(datasets)
library(rvest)
library(dplyr)
library(plotly)
library(DT)
ran = read.csv("display_data_12-14.csv",stringsAsFactors = FALSE,encoding="UTF-8")
dummy.1 = read.csv("dummy_data_v2.csv",stringsAsFactors = FALSE,encoding="UTF-8")
formal = head(ran,20)
shinyServer(function(input, output) {
  
  
  output$intro <- renderText("This analysis is based on the ranking of 20 games that have the highest ranking of all PC games on Bahamut Forum.")

  output$trialName <- renderPrint(str(ran[ran$Game== input$Namae,]))
  

  output$radex <- renderText("The area doesn't represent the popularity of a game.\n
                             If the area is big, it means lots of players like it because of the same feature.\n
                             On the other hand,the area is small when people like it because of different reason.")
  
  output$mytable = DT::renderDataTable({
    formal
  }) 
  
  
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
  
  output$charteria <-renderDataTable({
                  
                  a = as.vector(dummy.1[dummy.1$Game == input$Namae, 4:326])
                  cosine.value = c()
                  
                  for(i in 1:2498) {
                    b = as.vector(dummy.1[i, 4:326])
                    cosine.cal = sum(a*b)/sqrt(sum(a^2)*sum(b^2))
                    cosine.value = c(cosine.value, cosine.cal)
                  }
                  
                  recommend.list = data_frame(Name = dummy.1$Game, Similarity = cosine.value)
                  print(head(arrange(recommend.list, desc(Similarity)), 20))
  })
  })
