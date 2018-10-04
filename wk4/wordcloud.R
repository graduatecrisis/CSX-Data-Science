### example_1_twitterR
### Refs:
# Load
install.packages("readtext")
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("readtext")

txt = readtext("./wk4/stevejobs_speech.txt", encoding = "UTF-8")
rm(docs)

doc1 = Corpus(VectorSource(doc))
inspect(doc1)

writeLines(as.character(doc2))

doc2 = tm_map(doc1,removePunctuation) 
toSpace = content_transformer(function (x , pattern ) gsub(pattern, " ", x))
doc2 = tm_map(doc2, toSpace, ":")
doc2 = tm_map(doc2, toSpace, "—")

doc2 = tm_map(doc2, content_transformer(tolower))
doc2 = tm_map(doc2, removeWords, c("the", "was", "been", "in", "m", "to"))
doc2 = tm_map(doc2, stripWhitespace)
rm(doc3)

doc2 = tm_map(doc2, removeWords, c("and", "that", "had", "for"))
doc2 = tm_map(doc2, removeWords, c("with", "have", "what", "but"))
doc2 = tm_map(doc2, removeWords, c("from", "about", "when", "this"))
doc2 = tm_map(doc2, removeWords, c("one", "very"))
doc2 = tm_map(doc2, removeWords, c("would", "didn", "don"))
doc2 = tm_map(doc2, removeWords, c("out", "months", "years", "know", "just"))
doc2 = tm_map(doc2, removeWords, c("now", "then", "only", "want", "were", "later"))
doc2 = tm_map(doc2, removeWords, c("your", "can", "did", "ever"))
doc2 = tm_map(doc2, removeWords, c("you", "they", "every", "few", "get"))
doc2 = tm_map(doc2, removeWords, c("never", "into", "next", "not"))
doc2 = tm_map(doc2, removeWords, c("most", "something"))
doc2 = tm_map(doc2, removeWords, c("their", "day", "are", "last", "any", "there", "she", "has", "almost", "told", "after"))
doc2 = tm_map(doc2, removeWords, c("even", "because", "being", "before", "going", "got"))
doc2 = tm_map(doc2, removeWords, c("found", "let", "his", "will"))
doc2 = tm_map(doc2, removeWords, c("today", "make", "dots", "back", "closest"))
doc2 = tm_map(doc2, removeWords, c("first", "how", "our", "put", "who", "final"))

dtm = TermDocumentMatrix(doc2)
m = as.matrix(dtm)
v = sort(rowSums(m),decreasing=TRUE)
d = data.frame(word = names(v),freq=v)
head(d, 30)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

library(ggplot2)

ggplot(data = d[1:50, ], aes(x = word, y = freq)) +
  geom_bar(width = 0.4, stat = "identity") +
  coord_flip()