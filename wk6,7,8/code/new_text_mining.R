library(tidytext)
library(dplyr)
library(stringr)
library(tm)

critic.2008 = read.csv("goty_critic_review_2008.csv", stringsAsFactors = F)
critic.2009 = read.csv("goty_critic_review_2009.csv", stringsAsFactors = F)
critic.2010 = read.csv("goty_critic_review_2010.csv", stringsAsFactors = F)
critic.2011 = read.csv("goty_critic_review_2011.csv", stringsAsFactors = F)
critic.2012 = read.csv("goty_critic_review_2012.csv", stringsAsFactors = F)
critic.2013 = read.csv("goty_critic_review_2013.csv", stringsAsFactors = F)
critic.2014 = read.csv("goty_critic_review_2014.csv", stringsAsFactors = F)
critic.2015 = read.csv("goty_critic_review_2015.csv", stringsAsFactors = F)
critic.2016 = read.csv("goty_critic_review_2016.csv", stringsAsFactors = F)
critic.2017 = read.csv("goty_critic_review_2017.csv", stringsAsFactors = F)

critc.all = rbind.data.frame(critic.2008, critic.2009, critic.2010, critic.2011, critic.2012, critic.2013, critic.2014, critic.2015, critic.2016, critic.2017)
critic.text = data_frame(Game = critc.all[ ,2], Review = critc.all[ ,3])
head(critic.text)

custom.stopwords = c("overwatch", "ow", "zelda", "mario", "ac", "assassin", "uncharted", "super", "metal", "gear", 
                     "solid", "mgs", "cod", "call", "duty", "gta", "fo", "fallout", "red", "dead", "redemption", "batman", "arkham", 
                     "lbp", "little", "big", "planet", "mass", "effect", "war", "god", "bayonetta", "dragon", "age", "inquisition", "bloodborne", 
                     "doom", "inside", "titanfall", "horizon", "pubg", "persona", "odyssey", "ld", "left", "black", "ops", "halo", "reach", 
                     "elder", "scrolls", "skyrim", "v", "portal", "walking", "bioshock", "game", "last", "tomb", "raider", "journey", 
                     "maker", "dishonored", "hearthstone", "mordor", "littlebigplanet", "skyward", "card", "gears", 
                     "souls", "modern", "city", "dawn", "us", "will", "breath", "wild", "witcher", "asylum", "assassins", 
                     "battlegrounds", "phantom", "sword", "creed", "iv", "iii", "warfare", "shadow", "pain", "infinite", "middleearth")

## tm
review.corpus = critic.text$Review %>% enc2utf8() %>% 
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
for(i in 1:3994) {
  review = c(review, content(review.corpus[[i]]))
}

critic.text = data_frame(Game = critc.all[ ,2], Review = review)
head(critic.text)

## unnest token
review.words = critic.text %>% unnest_tokens(word, Review) %>%
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
review.words.clean = critic.text %>% unnest_tokens(word, Review) %>%
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
write.csv(review.dtm, "critic_dtm.csv")
