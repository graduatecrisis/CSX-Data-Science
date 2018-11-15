library(qdap)
library(tm)
library(tau)
library(plotrix)
library(wordcloud)

zelda.critic = read.csv("./wk6,7,8/2017/Zelda Wild_critics.csv", stringsAsFactors = FALSE)
zelda.player = read.csv("./wk6,7,8/2017/zeldawild_player.csv", stringsAsFactors = FALSE)

zelda.critic.review = zelda.critic[1:100, 3]
order(zelda,player$score, descending = TRUE)
n = length(zelda.critic.review)
player.review = zelda.player[ ,2]

# text cleaning
qdap.clean = function(x) {
  x = replace_abbreviation(x)
  x = replace_contraction(x)
  x = replace_number(x)
  x = replace_ordinal(x)
  x = replace_ordinal(x)
  x = replace_symbol(x)
  x = tolower(x)
  return(x)
}

tm.clean = function(corpus) {
  corpus = tm_map(corpus, removeNumbers)
  corpus = tm_map(corpus, content_transformer(tolower))
  corpus = tm_map(corpus, removePunctuation)
  corpus = tm_map(corpus, stripWhitespace)
  corpus = tm_map(corpus, removeWords, stopwords("en"))
  return(corpus)
} 


tokenize_ngrams <- function(x, n=3) return(rownames(as.data.frame(unclass(textcnt(x,method="string",n=n)))))


# Combine into one dataframe
all.review = data.frame(critic = zelda.critic.review, player = player.review, stringsAsFactors = FALSE)

# Create Corpus
all.review.corp = VCorpus(VectorSource(all.review))
all.review.corp = tm.clean(all.review.corp)

# TDM with bi-grams & tf-idf
all.tdm = DocumentTermMatrix(all.review.corp, control = list(tokenize = tokenize_ngrams))
colnames(all.tdm) = c("Critics", "Player")
all.tdm.m = as.matrix(all.tdm)

# comparison cloud
comparison.cloud(all.tdm.m, color = c("skyblue", "green"), max.words = 30)
