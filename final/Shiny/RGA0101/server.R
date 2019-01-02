library(shiny)
library(datasets)
library(rvest)
library(dplyr)
library(plotly)
library(DT)
library(stringr)

# Read in data
display = read.csv("display_data_12-14.csv", stringsAsFactors = F)
dummy = read.csv("dummy_data_v3.csv", stringsAsFactors = F)
tag.relation = read.csv("tag_calculation.csv", stringsAsFactors = F)

## copy dummy dataset for calculation
dummy.1 = dummy
tag.relation.1 = tag.relation
row.names(display) = display$Game
display.list = setNames(split(display, seq(nrow(display))), rownames(display))


for(i in 1:326) {
  names(dummy.1)[i] = str_replace_all(names(dummy.1[i]), "\\.", " ")
}


shinyServer(function(input, output, session) {
  
  
  output$intro <- renderText("Data including steam games published in 2012-2014,and statistics based on SteamSpy and Metacritic.")

  output$trialName <- renderPrint({target.list = display.list[[input$Namae]]
                                  str(target.list)})
  
  
  eventReactive(input$update,{
    if(input$criteria1 == "price") {
      dummy.1$PriceRange = dummy.1$PriceRange * 4
    } else if(input$criteria1 == "playtime") {
      dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *4
    } else if(input$criteria1 == "score") {
      dummy.1$Index = dummy.1$Index *4
    }
    ## First category - Criteria2
    if(input$criteria2 == "price") {
      dummy.1$PriceRange = dummy.1$PriceRange * 3
    } else if(input$criteria2 == "playtime") {
      dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *3
    } else if(input$criteria2 == "score") {
      dummy.1$Index = dummy.1$Index *3
    }
    ## First category - Criteria3
    if(input$criteria3 == "price") {
      dummy.1$PriceRange = dummy.1$PriceRange * 2
    } else if(input$criteria3 == "playtime") {
      dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *2
    } else if(input$criteria3 == "score") {
      dummy.1$Index = dummy.1$Index *2
    }
    
    ## Second category
    target.list = display.list[[input$Namae]]
    maintag.vector = unlist(strsplit(target.list$MainTags, ","))
    
    ### retrieve index
    sub.tagprob = tag.relation.1 %>% subset(Tag1 == input$inSelect1 | Tag1 == input$inSelect2 | Tag1 == input$inSelect3)
    sub.tagprob[sub.tagprob$Tag1 == input$inSelect1, 3] = sub.tagprob[sub.tagprob$Tag1 == input$inSelect1, 3] * 4
    sub.tagprob[sub.tagprob$Tag1 == input$inSelect2, 3] = sub.tagprob[sub.tagprob$Tag1 == input$inSelect1, 3] * 3
    sub.tagprob[sub.tagprob$Tag1 == input$inSelect3, 3] = sub.tagprob[sub.tagprob$Tag1 == input$inSelect1, 3] * 2
    
    sub.tagprob = sub.tagprob %>% group_by(Tag2) %>% summarise(Accuprob = sum(value))
    
    ### assign weight
    for(i in 9:326) {
      if(colnames(dummy.1)[i] == input$inSelect1) {
        dummy.1[ ,i] = dummy.1[ ,i] * 4
      } else if(colnames(dummy.1)[i] == input$inSelect2) {
        dummy.1[ ,i] = dummy.1[ ,i] * 3
      } else if(colnames(dummy.1)[i] == input$inSelect3) {
        dummy.1[ ,i] = dummy.1[ ,i] * 2
      } else if(colnames(dummy.1)[i] %in% sub.tagprob$Tag2) {
        multiply = sub.tagprob[sub.tagprob$Tag2 == colnames(dummy.1)[i], ]$Accuprob
        dummy.1[ ,i] = dummy.1[ ,i] * multiply
      }
    }
          }, ignoreNULL = FALSE)
  
  
              observe({
                # Can also set the label and select items
                target.list = display.list[[input$Namae]]
                updateSelectInput(session, "inSelect",
                                  label = paste("Select input label"),
                                  choices = unlist(strsplit(target.list$MainTags, ",")))
                updateSelectInput(session, "inSelect2",
                                  label = paste("Select input label"),
                                  choices = unlist(strsplit(target.list$MainTags, ",")))
                updateSelectInput(session, "inSelect3",
                                  label = paste("Select input label"),
                                  choices = unlist(strsplit(target.list$MainTags, ",")))
                })
              
              

            output$charteria <-renderDataTable({
              target.list = display.list[[input$Namae]]
              a = as.vector(dummy.1[dummy.1$Appid == target.list$Appid, 4:326])
              cosine.value = c()
              
              for(i in 1:2497) {
                b = as.vector(dummy.1[i, 4:326])
                cosine.cal = sum(a*b)/sqrt(sum(a^2)*sum(b^2))
                cosine.value = c(cosine.value, cosine.cal)
              }
              
              recommend.list = data_frame(Game = dummy.1$Game, ID = dummy.1$Appid, Publisher = display$Publisher, Score = display$Index ,PlayerOption = display$PlayerOption, VisualOption = display$VisualOption, TraitOption = display$TraitOption, Similarity = cosine.value)
                  head(arrange(recommend.list, desc(Similarity), VisualOption), 20)
  })
  })
