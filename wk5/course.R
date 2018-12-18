install.packages("tidyverse")
install.packages("tidytext")


library(dplyr)
library(tidyverse)
library(tidytext)
library(tm)

fb.news = readLines("C:/Users/U430/Desktop/CSX Data Science/wk4/hw4_wordcloud/Facebooknews.txt") %>% tolower()
amazon.news = readLines("C:/Users/U430/Desktop/CSX Data Science/wk4/hw4_wordcloud/Amazonnews.txt") %>% tolower()
google.news = readLines("C:/Users/U430/Desktop/CSX Data Science/wk4/hw4_wordcloud/Googlenews.txt") %>% tolower()

fb.stopword = c(stopwords("en"), "facebook", "facebooks", "mark", "zuckerburg")
amazon.stopword = c(stopwords("en"), "amazon", "amazons", "amazonprime", "prime")
google.stopword = c(stopwords("en"), "google", "googles")

fb.corpus = VectorSource(fb.news) %>% VCorpus()
fb.corpus = tm_map(fb.corpus, removePunctuation)
fb.corpus = tm_map(fb.corpus, removeNumbers)
fb.corpus = tm_map(fb.corpus, removeWords, fb.stopword)
fb.corpus = tm_map(fb.corpus, stripWhitespace)

fb.title = c()
for(i in 1:100) {
  fb.title[i] = content(fb.corpus[[i]])
}


amazon.corpus = VectorSource(amazon.news) %>% VCorpus()
amazon.corpus = tm_map(amazon.corpus, removePunctuation)
amazon.corpus = tm_map(amazon.corpus, removeNumbers)
amazon.corpus = tm_map(amazon.corpus, removeWords, fb.stopword)
amazon.corpus = tm_map(amazon.corpus, stripWhitespace)

amazon.title = c()
for(i in 1:100) {
  amazon.title[i] = content(amazon.corpus[[i]])
}


google.corpus = VectorSource(google.news) %>% VCorpus()
google.corpus = tm_map(google.corpus, removePunctuation)
google.corpus = tm_map(google.corpus, removeNumbers)
google.corpus = tm_map(google.corpus, removeWords, fb.stopword)
google.corpus = tm_map(google.corpus, stripWhitespace)

google.title = c()
for(i in 1:100) {
  google.title[i] = content(google.corpus[[i]])
}


source = c(rep("Facebook", 100), rep("Amazon", 100), rep("Google", 100))
overall = data.frame(source, titles = c(fb.title, amazon.title, google.title), stringsAsFactors = FALSE)

class(overall$titles)

overall.word = overall %>% unnest_tokens(word, titles) %>%
  count(source, word, sort = TRUE) %>%
  ungroup()

total.word = overall.word %>%
  group_by(source) %>%
  summarise(total = sum(n))

overall.word = left_join(overall.word, total.word)

overall.word = overall.word %>% 
  bind_tf_idf(word, source, n)

overall.word = overall.word %>%
  select(-total) %>%
  arrange(desc(tf_idf))


book_words <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE) %>%
  ungroup()

total_words <- book_words %>% 
  group_by(book) %>% 
  summarize(total = sum(n))

book_words <- left_join(book_words, total_words)

book_words

book_words <- book_words %>%
  bind_tf_idf(word, book, n)
book_words

book_words %>%
  select(-total) %>%
  arrange(desc(tf_idf))