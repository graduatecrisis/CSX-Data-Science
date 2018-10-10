fb.data = readLines("C:/Users/U430/Desktop/CSX Data Science/wk4/hw4_wordcloud/Facebooknews.txt")
amazon.data = readLines("C:/Users/U430/Desktop/CSX Data Science/wk4/hw4_wordcloud/Amazonnews.txt")
google.data = readLines("C:/Users/U430/Desktop/CSX Data Science/wk4/hw4_wordcloud/Googlenews.txt")


library(tm)
library(stringr)
library(wordcloud)

## Preparation
fb.doc = VectorSource(fb.data)
amazon.doc = VectorSource(amazon.data)
google.doc = VectorSource(google.data)

fb.corpus = VCorpus(fb.doc)
amazon.corpus = VCorpus(amazon.doc)
google.corpus = VCorpus(google.doc)


## FB
fb.corpus = tm_map(fb.corpus, content_transformer(tolower))
fb.corpus = tm_map(fb.corpus, removePunctuation)
fb.corpus = tm_map(fb.corpus, removeNumbers)
stop = c(stopwords("en"), "facebook", "theres", "heres", "there", "here", "'", "facebooks", "will", "just", "opinion", "zuckerberg", "can", "smart", "post", "mark", "still", "dont", "go", "come", "goes")
fb.corpus = tm_map(fb.corpus, removeWords, stop)
fb.corpus = tm_map(fb.corpus, stripWhitespace)

fb.tdm = TermDocumentMatrix(fb.corpus)
fb.words.matrix = as.matrix(fb.tdm)
fb.term = rowSums(fb.words.matrix)
fb.term = sort(fb.term, decreasing = TRUE)

fb.term[1:20]

fb.word.freq = data.frame(term = names(fb.term), num = fb.term)

wordcloud(fb.word.freq$term, fb.word.freq$num, 
          max.words = 100, min.freq = 2, random.order = FALSE, 
          rot.per = 0.35, colors = brewer.pal(6, "Dark2"))

## Amazon
amazon.corpus = tm_map(amazon.corpus, content_transformer(tolower))
amazon.corpus = tm_map(amazon.corpus, removePunctuation)
amazon.corpus = tm_map(amazon.corpus, removeNumbers)
stop = c(stopwords("en"), "theres", "heres", "there", "here", "'", "will", 
         "just", "opinion", "can", "smart", "post", "still", "dont", "go",
         "come", "goes", "amazon", "says", "now", "may", "sell", "selling", 
         "top", "deals", "whole", "world", " ¡¦ll", "addresses", "amazoncom", 
         "become", "area", "amazons")
amazon.corpus = tm_map(amazon.corpus, removeWords, stop)
amazon.corpus = tm_map(amazon.corpus, stripWhitespace)

amazon.tdm = TermDocumentMatrix(amazon.corpus)
amazon.words.matrix = as.matrix(amazon.tdm)
amazon.term = rowSums(amazon.words.matrix)
amazon.term = sort(amazon.term, decreasing = TRUE)

amazon.term[1:30]

amazon.word.freq = data.frame(term = names(amazon.term), num = amazon.term)

wordcloud(amazon.word.freq$term, amazon.word.freq$num, 
          max.words = 100, min.freq = 2, random.order = FALSE, 
          rot.per = 0.35, colors = brewer.pal(8, "Dark2"))



## Google
google.corpus = tm_map(google.corpus, content_transformer(tolower))
google.corpus = tm_map(google.corpus, removePunctuation)
google.corpus = tm_map(google.corpus, removeNumbers)
stop = c(stopwords("en"), "theres", "heres", "there", "here", "'", "will", 
         "just", "opinion", "can", "smart", "post", "still", "dont", "go",
         "come", "goes", "google", "says", "now", "may", "googles", "news", 
         "gmail", "big", "calls", "get", "know", "admits", "announces", "years", "friday",
         "revealed", "former", "search")
google.corpus = tm_map(google.corpus, removeWords, stop)
google.corpus = tm_map(google.corpus, stripWhitespace)

google.tdm = TermDocumentMatrix(google.corpus)
google.words.matrix = as.matrix(google.tdm)
google.term = rowSums(google.words.matrix)
google.term = sort(google.term, decreasing = TRUE)

google.term[1:30]

google.word.freq = data.frame(term = names(google.term), num = google.term)

wordcloud(google.word.freq$term, google.word.freq$num, 
          max.words = 100, min.freq = 2, random.order = FALSE, 
          rot.per = 0.35, colors = brewer.pal(8, "Dark2"))
