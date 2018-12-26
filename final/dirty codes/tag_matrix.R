library(tidyr)
tag.net.1 = tag.net
tag.net.1$tags = as.character(tag.net$tags)
unlist(strsplit(tag.net.1$tags[1], split = ","))[2]
for(i in 1:7425) {
  tag.net.1$Tag1[i] = unlist(strsplit(tag.net.1$tags[i], split = ","))[1]
  tag.net.1$Tag2[i] = unlist(strsplit(tag.net.1$tags[i], split = ","))[2]
}

tag.net.1 = tag.net.1[ ,-1]
tag.net.1 = tag.net.1[ ,c(2,3,1)]
table(tag.net.1$Tag1, tag.net.1$Tag2)


outl.1 = sapply(wlist, function(x) paste(head(x, -1), tail(x, -1), sep = ","))
tag.net.1 = data.frame(count = unclass(table(unlist(outl.1))))
count.time.1 = as.vector(tag.net.1$count)

tag.net.1 = data.frame(tags = row.names(tag.net.1), count = count.time.1) %>% arrange(desc(count.time.1))
tag.net.1$tags = as.character(tag.net.1$tags)

tag.net.2 = spread(tag.net.1, key = Tag2, value = count)
tag.net.2[is.na(tag.net.2)] = 0

write.csv(tag.net.2, "tag_matrix.csv", row.names = F)
