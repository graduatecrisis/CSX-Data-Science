library(rvest)
library(stringr)
library(dplyr)

tag.2012 = read.csv("./tags/tags_2012.csv", stringsAsFactors = F)
tag.2013 = read.csv("./tags/tags_2013.csv", stringsAsFactors = F)
tag.2014 = read.csv("./tags/tags_2014.csv", stringsAsFactors = F)
tag.2015 = read.csv("./tags/tags_2015.csv", stringsAsFactors = F)
tag.2016 = read.csv("./tags/tags_2016.csv", stringsAsFactors = F)
tag.2017 = read.csv("./tags/tags_2017.csv", stringsAsFactors = F)

for(i in 1:6974) {
  id.2017$revised[i] = str_replace_all(id.2017[i,2], "-", " ")
  id.2017$revised[i] = str_replace_all(id.2017$revised[i], ":", "")
  id.2017$revised[i] = str_replace_all(id.2017$revised[i]," ", "_")
}

for(i in 1:6974) {
  id.2017$url[i] = paste("https://store.steampowered.com/app/", id.2017$index[i], "/", id.2017$revised[i], "/", sep = "")
}

for(i in 6000:6974) {
  id.2017$tags[i] = get.tag(id.2017$url[i])
}


which(tag.2017$index == 1)
tag.2014 = tag.2014[-which(tag.2014$index == 1), ]

get.description(tag.2012$url[1])

for(i in 1:2657) {
  tag.2015$description[i] = get.description(tag.2015$url[i])
}

write.csv(tag.2014[ ,c(1,2,6,7)], "t&s_2014.csv", row.names = F)

tags = tag.2014$tags
wlist = sapply(tags, strsplit, split = ",", perl = TRUE)
outl = sapply(wlist, function(x) paste(head(x, -1), tail(x, -1), sep = " "))
tag.net.2014 = data.frame(count = unclass(table(unlist(outl))))

tag.net.2104.1 = data.frame(tags = row.names(tag.net.2014), count = count.time) %>% arrange(desc(count.time))

str(tag.net.2104.1)
count.time = as.vector(tag.net.2014$count)
