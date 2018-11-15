library(rvest)
library(dplyr)
library(stringr)


## publisher 
scrap.publisher = function(n, link) {
  publisher = c()
  for(i in 1:n) {
    nodes = paste("#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(", i, ") > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_critic > div.source")
    title = link %>% html_nodes(nodes) %>% 
      html_text()
    publisher = c(publisher, title)
  }
  last.publisher = link %>% html_nodes("#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.last_review > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_critic > div.source") %>%
    html_text()
  publisher = c(publisher, last.publisher)
  return(publisher)
}

try = scrap.score(80, bayonetta2)

## score
scrap.score = function(n, link) {
  score = c()
  for(i in 1:n) {
    nodes = paste("#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(", i, ") > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div")
    point = link %>% html_nodes(nodes) %>%
      html_text()
    score = c(score, point)
  }
  last.point = link %>% html_nodes("#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.last_review > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div") %>%
    html_text()
  score = c(score, last.point)
  return(score)
}

## review
scrap.review = function(n, link) {
  reviews = c()
  for(i in 1:n) {
    nodes = paste("#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(", i, ") > div > div > div > div > div > div:nth-child(1) > div.review_body")
    article = link %>% html_nodes(nodes) %>%
      html_text()
    reviews = c(reviews, article)
  }
  last.review = link %>% html_nodes("#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.last_review > div > div > div > div > div > div:nth-child(1) > div.review_body") %>%
    html_text()
  reviews = c(reviews, last.review)
  reviews = str_remove_all(reviews, "\n")
  reviews = str_remove_all(reviews, "\r")
  reviews = str_trim(reviews)
  return(reviews)
}

## combine
build.dataframe = function(n, link) {
  publisher = scrap.publisher(n, link)
  score = scrap.score(n, link)
  reviews = scrap.review(n, link)
  combine = data_frame(publisher = publisher, score = score, review = reviews)
  return(combine)
}


url = "https://www.metacritic.com/game/xbox-360/tomb-raider/critic-reviews"
tombraider = read_html(url)
tombraider.critic = build.dataframe(70, tombraider)
write.csv(tombraider.critic, "Tomb Raider_critics.csv", row.names = FALSE)
