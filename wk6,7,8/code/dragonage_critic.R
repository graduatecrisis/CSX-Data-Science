library(rvest)
library(dplyr)
library(stringr)
url = "https://www.metacritic.com/game/playstation-4/dragon-age-inquisition/critic-reviews"
dragonage = read_html(url)
html_nodes(dragon_try, "#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(1) > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_critic > div.source > a") %>% 
  html_text()

publisher = c()

for(i in 1:43) {
  nodes = paste("#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(", i, ") > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_critic > div.source")
  title = dragonage %>% html_nodes(nodes) %>%
    html_text()
  publisher = c(publisher, title)
}

last = dragonage %>% html_nodes("#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.last_review > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_critic > div.source") %>%
  html_text()
publisher = c(publisher, last)

score = c()

for(i in 1:43) {
  nodes = paste("#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(", i, ") > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div")
  point = dragonage %>% html_nodes(nodes) %>%
    html_text()
  score = c(score, point)
}

last.point = dragonage %>% html_nodes("#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.last_review > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div") %>%
  html_text()
score = c(score, last.point)

reviews = c()

for(i in 1:43) {
  nodes = paste("#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(", i, ") > div > div > div > div > div > div:nth-child(1) > div.review_body")
  article = dragonage %>% html_nodes(nodes) %>%
    html_text()
  reviews = c(reviews, article)
}

last.review = dragonage %>% html_nodes("#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.last_review > div > div > div > div > div > div:nth-child(1) > div.review_body") %>%
  html_text()
reviews = c(reviews, last.review)

reviews = str_remove_all(reviews, "\n")
reviews = str_remove_all(reviews, "\r")
reviews = str_trim(reviews)

dragonage.critic = data_frame(publisher = publisher, score = score, review = reviews)
write.csv(dragonage.critic, "Dragon Age_critics.csv", row.names = FALSE)
#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(2) > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_critic > div.source > a
#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.last_review > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_critic > div.source

#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.first_review > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div
#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(5) > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div
#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.last_review > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div

#main > div.module.reviews_module.critic_reviews_module > div > ol > li.review.critic_review.first_review > div > div > div > div > div > div:nth-child(1) > div.review_body
#main > div.module.reviews_module.critic_reviews_module > div > ol > li:nth-child(2) > div > div > div > div > div > div:nth-child(1) > div.review_body

