library(dendextend)

goty.data = read.csv("goty_data.csv", stringsAsFactors = FALSE)
goty.score = read.csv("goty_score.csv")

sub.cluster = as.matrix(goty.data[ ,10:15])
row.names(sub.cluster) = goty.data$Game

critic.cluster = as.matrix(goty.score[ ,3:7])
row.names(critic.cluster) = goty.score$Game

player.cluster = as.matrix(goty.score[ ,8:12])
row.names(player.cluster) = goty.score$Game

# pca
sub.pr = prcomp(sub.cluster, scale = FALSE)
summary(sub.pr) ## choose pc1

critic.pr = prcomp(critic.cluster, scale = FALSE)
summary(critic.pr) ## choose pc1

player.pr = prcomp(player.cluster, scale = FALSE)
summary(player.pr)


# sub kmeans
wss = c()
for(i in 1:15) {
  kout = kmeans(sub.pr$x[ ,1:2], centers = i, nstart = 20)
  wss[i] = kout$tot.withinss
}
plot(1:15, wss, xlab = "", ylab = "", main = "k Detection for sub", type = "b")

sub.kmean = kmeans(sub.pr$x[ ,1:2], centers = 4)

# critic kmeans
wss1 = c()
for(i in 1:15) {
  kout = kmeans(critic.pr$x[ ,1:2], centers = i, nstart = 20)
  wss1[i] = kout$tot.withinss
}
plot(1:15, wss1, xlab = "", ylab = "", main = "k Detection for critic", type = "b")

critic.kmean = kmeans(critic.pr$x[ ,1:2], centers = 4)

# player kmeans
wss2 = c()
for(i in 1:15) {
  kout = kmeans(player.pr$x[ ,1:2], centers = i, nstart = 20)
  wss2[i] = kout$tot.withinss
}
plot(1:15, wss2, xlab = "", ylab = "", main = "k Detection for player", type = "b")

player.kmean = kmeans(critic.pr$x[ ,1:2], centers = 4)


# sub final
sub.final = data.frame(game = goty.data$Game, x = sub.pr$x[ ,1], y = sub.pr$x[ ,2], cluster = sub.kmean$cluster, winner = goty.data$winner)
sub.final$winner = as.factor(sub.final$winner)
sub.final$cluster = as.factor(sub.final$cluster)
sub.cluster.plot = ggplot(sub.final, aes(x = x, y = y, shape = cluster)) +
  geom_point(aes(color = winner), size = 3) +
  ggtitle("Cluster for GOTY - By Game Traits", subtitle = "k = 4, pca = 2") +
  xlab("") +
  ylab("") +
  theme(title = element_text(size = 14, face = "bold"))

# critic final
critic.final = data.frame(game = goty.data$Game, x = critic.pr$x[ ,1], y = critic.pr$x[ ,2], cluster = critic.kmean$cluster, winner = goty.data$winner)
critic.final$winner = as.factor(critic.final$winner)
critic.final$cluster = as.factor(critic.final$cluster)
critic.cluster.plot = ggplot(critic.final, aes(x = x, y = y, shape = cluster)) +
  geom_point(aes(color = winner), size = 3) +
  ggtitle("Cluster for GOTY - By Crtiic's Reviews", subtitle = "k = 4, pca = 2") +
  xlab("") +
  ylab("") +
  theme(title = element_text(size = 14, face = "bold"))

# player final
player.final = data.frame(game = goty.data$Game, x = player.pr$x[ ,1], y = player.pr$x[ ,2], cluster = player.kmean$cluster, winner = goty.data$winner)
player.final$winner = as.factor(player.final$winner)
player.final$cluster = as.factor(player.final$cluster)
player.cluster.plot = ggplot(player.final, aes(x = x, y = y, shape = cluster)) +
  geom_point(aes(color = winner), size = 3) +
  ggtitle("Cluster for GOTY - By Player's Reviews", subtitle = "k = 4, pca = 2") +
  xlab("") +
  ylab("") +
  theme(title = element_text(size = 14, face = "bold"))


winners = c("Dragon Age: Inquisition", "The Legend of Zelda: Breath of the Wild", 
           "The Witcher 3: Wild Hunt", "The Elder Scrolls V: Skyrim", "Red Dead Redemption", 
           "Grand Theft Auto IV", "Grand Theft Auto V", "Overwatch", "The Walking Dead: The Game","Uncharted 2: Among Thieves")

# sub hclust
sub.hclust.pr = hclust(dist(sub.cluster), method = "average")
sub.hcd = as.dendrogram(sub.hclust.pr)
labels(sub.hcd)
sub.hcd = branches_attr_by_labels(sub.hcd, winners, color = "red")
par(mar=c(0.1,1,0.1,18))
plot(sub.hcd,axes= FALSE, horiz = TRUE)                                  
dev.off()

# critic hclust
critic.hclust.pr = hclust(dist(critic.cluster), method = "average")
critic.hcd = as.dendrogram(critic.hclust.pr)
critic.hcd = branches_attr_by_labels(critic.hcd, winners, color = "red")
par(mar=c(0.8,1,0.8,18))
plot(critic.hcd,axes= FALSE, horiz = TRUE)                                  
dev.off()

# player hclust
player.hclust.pr = hclust(dist(player.cluster), method = "complete")
player.hcd = as.dendrogram(player.hclust.pr)
player.hcd = branches_attr_by_labels(player.hcd, winners, color = "red")
par(mar=c(0.8,1,0.8,18))
plot(player.hcd,axes= FALSE, horiz = TRUE)                                  
dev.off()


