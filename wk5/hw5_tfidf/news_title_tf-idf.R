library(tidytext)
library(dplyr)
library(ggplot2)
library(stringr)
library(tidyr)

## Read in data
fb = readLines("/Users/wanjunghuang/Desktop/CSX_local/wk5/Facebooknews_1017.txt")
google = readLines("/Users/wanjunghuang/Desktop/CSX_local/wk5/Googlenews_1017.txt")
amazon = readLines("/Users/wanjunghuang/Desktop/CSX_local/wk5/Amazonnews_1017.txt")
company = c(rep("Facebook", 100), rep("Amazon", 100), rep("Google", 100))
news_title = data_frame(company = as.factor(company), title = c(fb,amazon,google))
news_title

## Tidy text -- tf matrix
title.words = news_title %>%
  unnest_tokens(word, title) %>%
  count(company, word, sort = TRUE) %>%
  ungroup()

title.words

total.words = title.words %>% 
  group_by(company) %>%
  summarize(total = sum(n))

title.words.clean = news_title %>%
  unnest_tokens(word, title) %>%
  anti_join(stop_words) %>%
  count(company, word, sort = TRUE) %>%
  ungroup()

title.words.combine = left_join(title.words.clean, total.words)
title.words.combine

## tf_idf
title.word.idf = title.words.combine %>%
  bind_tf_idf(word, company, n)

title.word.idf %>% 
  select(-total) %>%
  arrange(desc(tf_idf))

## Plot
idf.plot = title.word.idf %>% arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>%
  group_by(company) %>%
  top_n(13) %>%
  ungroup %>%
  ggplot(aes(word, tf_idf, fill = company)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~company, ncol = 2, scales = "free") +
  coord_flip()

## Bigram
news.bigram = news_title %>%
  unnest_tokens(bigram, title, token = "ngrams", n = 2) %>%
  count(company, bigram, sort = TRUE)
news.bigram

news.bigram.seperate = news.bigram %>%
  separate(bigram, c("word1", "word2"), sep = " ")
news.bigram.seperate

news.bigram.filtered = news.bigram.seperate %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(word1 != word2) 
news.bigram.filtered

news.bigram.united = news.bigram.filtered %>%
  unite(bigram, word1, word2, sep = " ")
news.bigram.united

news.bigram.idf = news.bigram.united %>%
  bind_tf_idf(bigram, company, n) %>%
  arrange(desc(tf_idf))
news.bigram.idf


## Plot
bigram.plot = news.bigram.idf %>%
  filter(n!=1) %>%
  arrange(desc(tf_idf)) %>%
  mutate(bigram = factor(bigram, levels = rev(unique(bigram)))) %>%
  group_by(company) %>%
  top_n(15) %>%
  ungroup() %>%
  ggplot(aes(bigram, tf_idf, fill = company)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~company, ncol = 2, scales = "free") +
  coord_flip()
bigram.plot
