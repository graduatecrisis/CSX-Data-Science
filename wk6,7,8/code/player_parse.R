library(rvest)
library(dplyr)
library(stringr)


url = "https://www.metacritic.com/game/switch/the-legend-of-zelda-breath-of-the-wild/user-reviews"
zeldawild = read_html(url)
zeldawild.id = get.id(zeldawild)
zeldawild.player = get.dataframe(zeldawild,zeldawild.id)
write.csv(zeldawild.player, "zeldawild_player.csv", row.names = F)

## get id
get.id = function(link) {
  id = c()
  user = link %>% html_nodes("#main > div.partial_wrap > div.module.reviews_module.user_reviews_module > div > ol") %>% 
    xml_find_all("//li/@id") %>% xml_text()
  id = c(id, user)
  id = str_sub(id, start = -7, end = -1) %>% as.integer()
  return(id)
}

## get score vector
get.score = function(link, id) {
  score = c()
  for(i in id) {
    nodes = paste("#user_review_", i, " > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div", sep = "")
    point = link %>% html_nodes(nodes) %>% html_text()
    score = c(score, point)
  }
  score = as.integer(score)
  return(score)
}

## get review
get.review = function(link, id) {
  review = c()
  for(i in id) {
    nodes = paste("#user_review_", i, " > div > div > div > div > div > div:nth-child(1) > div.review_body > span", sep = "")
    feedback = link %>% html_nodes(nodes) %>% html_text()
    review = c(review, feedback)
  }
  review = str_remove_all(review, "\n")
  review = str_remove_all(review, "\r")
  review = str_remove_all(review, "Expand")
  review = str_trim(review)
  return(review)
}

## combine
get.dataframe = function(link, id) {
  score = get.score(link, id)
  review = get.review(link,id)
  combine = data_frame(score = score, review = review)
  return(combine)
}
