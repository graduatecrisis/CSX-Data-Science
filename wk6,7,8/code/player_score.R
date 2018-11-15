library(rvest)
library(dplyr)
library(stringr)

url = "https://www.metacritic.com/game/playstation-4/dragon-age-inquisition/user-reviews"
tombtry = read_html(url)
id = tombtry %>% html_nodes("#main > div.partial_wrap > div.module.reviews_module.user_reviews_module > div > ol") %>% xml_find_all("//li/@id") %>% xml_text()


id = str_sub(id, start = -7, end = -1) %>% as.integer()

tomb.score = c()
for(i in id) {
  nodes = paste("#user_review_", i, " > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div", sep = "")
  point = tombtry %>% html_nodes(nodes) %>% html_text()
  tomb.score = c(tomb.score, point)
}

tombtry %>% html_node("#user_review_4738103 > div > div > div > div > div > div:nth-child(1) > div.review_stats > div.review_grade > div") %>% html_text()


