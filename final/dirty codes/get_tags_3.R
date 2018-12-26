library(dplyr)
library(stringr)
library(rvest)

tag.2014 = read.csv("./final/tags/tags_2014.csv", stringsAsFactors = F)
tag.2014.1 = tag.2014[ ,-c(4,5)]
tag.2014.2 = read.csv("./final/t&s_2014.csv", stringsAsFactors = F)

tag.2014.2$index = tag.2014.1$index[match(tag.2014.2$title, tag.2014.1$title)]

for(i in 1:1675) {
  tag.2014.2$url[i] = paste("https://steamdb.info/app/", tag.2014.2$index[i], "/info/", sep = "")
}


get.tag.steamdb = function(url, k, n) {
  infopage = url %>% read_html()
  tag.string = c()
  for(i in 1:n) {
    selector = paste("#info > table > tbody > tr:nth-child(", k, ") > td:nth-child(2) > ul > li:nth-child(", i, ") > a", sep = "")
    tag.vector = html_nodes(infopage, selector) %>% html_text()
    tag.string = c(tag.string, tag.vector)
  }
  tag.string = paste(tag.string, collapse = ",")
  return(tag.string)
}

which(is.na(tag.2014.2$description))

tag.2014.2 = tag.2014.2[-c(3,8,12,36,65,67,74,116,145,201,241,361,447,479,822), ]


write.csv(tag.2014.finish, "t&s_2014.csv", row.names = F)

tag.2013.finish = data_frame(Year = tag.2013.2$year, Name = tag.2013.2$title, Appid = tag.2013.2$index, Tags = tag.2013.2$tags, Summary = tag.2013.2$description)
tag.2014.finish = data_frame(Year = tag.2014.2$year, Name = tag.2014.2$title, Appid = tag.2014.2$index, Tags = tag.2014.2$tags, Summary = tag.2014.2$description)
