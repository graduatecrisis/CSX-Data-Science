library(tidytext)
library(dplyr)
library(stringr)
library(tm)

player.2008 = read.csv("goty_player_review_2008.csv", stringsAsFactors = F)
player.2009 = read.csv("goty_player_review_2009.csv", stringsAsFactors = F)
player.2010 = read.csv("goty_player_review_2010.csv", stringsAsFactors = F)
player.2011 = read.csv("goty_player_review_2011.csv", stringsAsFactors = F)
player.2012 = read.csv("goty_player_review_2012.csv", stringsAsFactors = F)
player.2013 = read.csv("goty_player_review_2013.csv", stringsAsFactors = F)
player.2014 = read.csv("goty_player_review_2014.csv", stringsAsFactors = F)
player.2015 = read.csv("goty_player_review_2015.csv", stringsAsFactors = F)
player.2016 = read.csv("goty_player_review_2016.csv", stringsAsFactors = F)
player.2017 = read.csv("goty_player_review_2017.csv", stringsAsFactors = F)

player.all = rbind.data.frame(player.2008, player.2009, player.2010, player.2011, player.2012, player.2013, player.2014, player.2015, player.2016, player.2017)
player.text = data_frame(Game = player.all[ ,2], Review = player.all[ ,3])
head(player.text)

custom.stopwords = c("overwatch", "ow", "zelda", "mario", "ac", "assassin", "uncharted", "super", "metal", "gear", 
                     "solid", "mgs", "cod", "call", "duty", "gta", "fo", "fallout", "red", "dead", "redemption", "batman", "arkham", 
                     "lbp", "little", "big", "planet", "mass", "effect", "war", "god", "bayonetta", "dragon", "age", "inquisition", "bloodborne", 
                     "doom", "inside", "titanfall", "horizon", "pubg", "persona", "odyssey", "ld", "left", "black", "ops", "halo", "reach", 
                     "elder", "scrolls", "skyrim", "v", "portal", "walking", "bioshock", "game", "last", "tomb", "raider", "journey", 
                     "maker", "dishonored", "hearthstone", "mordor", "littlebigplanet", "skyward", "card", "gears", 
                     "souls", "modern", "city", "dawn", "us", "will", "breath", "wild", "witcher", "asylum", "assassins", 
                     "battlegrounds", "phantom", "sword", "creed", "iv", "iii", "warfare", "shadow", "pain", "infinite", "middleearth")

## tm
review.corpus = player.text$Review %>% enc2utf8() %>% 
  str_trim() %>%
  tolower() %>%
  VectorSource() %>%
  VCorpus()
review.corpus = tm_map(review.corpus, removeNumbers)
review.corpus = tm_map(review.corpus, removePunctuation)
review.corpus = tm_map(review.corpus, removeWords, stopwords("en"))
review.corpus = tm_map(review.corpus, removeWords, custom.stopwords)
review.corpus = tm_map(review.corpus, removeWords, '"')
review.corpus = tm_map(review.corpus, stripWhitespace)

## reorganize
review = c()
for(i in 1:4249) {
  review = c(review, content(review.corpus[[i]]))
}

player.text = data_frame(Game = player.all[ ,2], Review = review)
head(player.text)

## unnest token
review.words = player.text %>% unnest_tokens(word, Review) %>%
  filter(!str_detect(word, "[0-9]")) %>%
  count(Game, word, sort = TRUE) %>%
  ungroup()

head(review.words)

## count total n
review.words.total = review.words %>%
  group_by(Game) %>%
  summarize(total = sum(n))

head(review.words.total)

## clean text
review.words.clean = player.text %>% unnest_tokens(word, Review) %>%
  anti_join(stop_words) %>%
  count(Game, word, sort = TRUE) %>%
  ungroup()

head(review.words.clean)

## tf-idf
review.tfidf = left_join(review.words.clean, review.words.total) %>%
  bind_tf_idf(word, Game, n) %>%
  select(-total) %>%
  arrange(desc(tf_idf))

head(review.tfidf, 20)

## cast dtm
review.dtm = cast_dtm(review.tfidf, document = Game, term = word, tf_idf) %>% as.matrix()
review.dtm[1:10, 1:10]
write.csv(review.dtm, "player_dtm.csv")
