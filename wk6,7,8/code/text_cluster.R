library(wordcloud2)

critic = read.csv("critic_dtm.csv", stringsAsFactors = F)
row.names(critic) = critic$X
critic = critic[ ,-1]
a = colSums(critic != 0)
critic[1:10, 1:10]
aa = data_frame(Word = names(a), count = a)
aa.pass = aa[aa$count > 10, ]
wordcloud2(aa.pass)

player = read.csv("player_dtm.csv", stringsAsFactors = F)
row.names(player) = player$X
player = player[ ,-1]
player[1:10, 1:10]
b = colSums(player != 0)
bb = data_frame(Word = names(b), count = b)
bb.pass = bb[bb$count > 10, ]
wordcloud2(bb.pass)

# critic cluster
a.cluster = as.matrix(critic[ ,2:10298])
a.pca = prcomp(a.cluster)
summary(a.pca) # pca = 34 -> 85%

wss = c()
for(i in 1:20) {
  kout = kmeans(a.pca$x[ ,1:34], centers = i, nstart = 20)
  wss[i] = kout$tot.withinss
}

plot(1:20, wss, ylab = "", type = "b")

a.hclust = hclust(dist(a.pca$x[ ,1:34]))
plot(a.hclust)
a.hclust.tree = cutree(a.hclust, k = 10)

# player cluster
b.cluster = as.matrix(player[ ,2:25262])
b.pca = prcomp(b.cluster)
summary(b.pca) # pca 34 -> 85%

wss1 = c()
for(i in 1:20) {
  kout = kmeans(b.pca$x[ ,1:34], centers = i, nstart = 20)
  wss1[i] = kout$tot.withinss
}

plot(1:20, wss1, ylab = "", xlab = "", type = "b")

b.hclust = hclust(dist(b.pca$x[ ,1:34]))
plot(b.hclust)
b.hclust.tree = cutree(b.hclust, k = 10)

## compare
table(a.hclust.tree, b.hclust.tree)
