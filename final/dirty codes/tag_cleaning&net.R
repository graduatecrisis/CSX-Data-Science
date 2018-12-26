library(dplyr)
library(stringr)

## Function
get.maintag = function(string, text) {
  library(stringr)
  a = unlist(strsplit(string, split = ","))
  w.main = c()
  text.lower = tolower(text)
  for(w in a) {
    w.lower = tolower(w)
    if(str_detect(text.lower, w.lower) == TRUE) {
      w.main = c(w.main, w.lower)
    }
  }
  w.main = paste(w.main, collapse = ",")
  return(w.main)
}

## Dictionary
player = c("singleplayer", "multiplayer", "massively multiplayer", "local multiplayer", "4 player local", "asynchronous multiplayer")
trait = c("free to play", "great soundtrack", "replay value", "controller", "memes", "soundtrack", "remake")
visual = c("2d", "vr", "pixel graphics", "colorful", "dark", "3d", "2.5d", "cartoon", "1990's", "1980s", "3d vision", "360 video")

## Read Data
ts.2012 = read.csv("t&s_2012.csv", stringsAsFactors = F)
ts.2012 = ts.2012[ ,-c(4,7)]
ts.2012$Tags = tolower(ts.2012$Tags)
ts.2013 = read.csv("t&s_2013.csv", stringsAsFactors = F)
ts.2013$Tags = tolower(ts.2013$Tags)
ts.2014 = read.csv("t&s_2014.csv", stringsAsFactors = F)
ts.2014$Tags = tolower(ts.2014$Tags)

## tagnet

### unique tags
a = c(unlist(strsplit(ts.2012.1$MainTag, split = ",")), unlist(strsplit(ts.2012.1$Tag3, split = ",")))
b = c(unlist(strsplit(ts.2013.1$MainTag, split = ",")), unlist(strsplit(ts.2013.1$Tag3, split = ",")))
d = c(unlist(strsplit(ts.2014.1$MainTag, split = ",")), unlist(strsplit(ts.2014.1$Tag3, split = ",")))
unique.tag = unique(c(a,b,d))

### tag relation
tag.total = c()

for(i in 1:374) {
  if(ts.2012.1$MainTag[i] != "") {
    tag.combine = paste(ts.2012.1$MainTag[i], ts.2012.1$Tag3[i], sep = ",")
  } else {
    tag.combine = ts.2012.1$Tag3[i]
  }
  tag.total = c(tag.total, tag.combine)
}

for(i in 1:485) {
  if(ts.2013.1$MainTag[i] != "") {
    tag.combine = paste(ts.2013.1$MainTag[i], ts.2013.1$Tag3[i], sep = ",")
  } else {
    tag.combine = ts.2013.1$Tag3[i]
  }
  tag.total = c(tag.total, tag.combine)
}

for(i in 1:1655) {
  if(ts.2014.1$MainTag[i] != "") {
    tag.combine = paste(ts.2014.1$MainTag[i], ts.2014.1$Tag3[i], sep = ",")
  } else {
    tag.combine = ts.2014.1$Tag3[i]
  }
  tag.total = c(tag.total, tag.combine)
}

wlist = sapply(tag.total, strsplit, split = ",", perl = TRUE)
outl = sapply(wlist, function(x) paste(head(x, -1), tail(x, -1), sep = " "))
tag.net = data.frame(count = unclass(table(unlist(outl))))
count.time = as.vector(tag.net$count)

tag.net = data.frame(tags = row.names(tag.net), count = count.time) %>% arrange(desc(count.time))
write.csv(tag.net, "tag_net.csv", row.names = F)

## extract tags in dictionaries

### 2012 player option
for(i in 1:374) {
  tag.vector = unlist(strsplit(ts.2012$Tags[i], split = ",")) %>% tolower()
  player.vector = c()
  player.vector = c(player.vector, intersect(tag.vector, player))
  player.string = paste(player.vector, collapse = ",")
  ts.2012$PlayerOption[i] = player.string
}

### 2012 visual option
for(i in 1:374) {
  tag.vector = unlist(strsplit(ts.2012$Tags[i], split = ",")) %>% tolower()
  visual.vector = c()
  visual.vector = c(visual.vector, intersect(tag.vector, visual))
  visual.string = paste(visual.vector, collapse = ",")
  ts.2012$VisualOption[i] = visual.string
}

### 2012 trait option
for(i in 1:374) {
  tag.vector = unlist(strsplit(ts.2012$Tags[i], split = ",")) %>% tolower()
  trait.vector = c()
  trait.vector = c(trait.vector, intersect(tag.vector, trait))
  trait.string = paste(trait.vector, collapse = ",")
  ts.2012$TraitOption[i] = trait.string
}


### 2013 player option
for(i in 1:485) {
  tag.vector = unlist(strsplit(ts.2013$Tags[i], split = ",")) %>% tolower()
  player.vector = c()
  player.vector = c(player.vector, intersect(tag.vector, player))
  player.string = paste(player.vector, collapse = ",")
  ts.2013$PlayerOption[i] = player.string
}

### 2013 visual option
for(i in 1:485) {
  tag.vector = unlist(strsplit(ts.2013$Tags[i], split = ",")) %>% tolower()
  visual.vector = c()
  visual.vector = c(visual.vector, intersect(tag.vector, visual))
  visual.string = paste(visual.vector, collapse = ",")
  ts.2013$VisualOption[i] = visual.string
}

### 2013 trait option
for(i in 1:485) {
  tag.vector = unlist(strsplit(ts.2013$Tags[i], split = ",")) %>% tolower()
  trait.vector = c()
  trait.vector = c(trait.vector, intersect(tag.vector, trait))
  trait.string = paste(trait.vector, collapse = ",")
  ts.2013$TraitOption[i] = trait.string
}

### 2014 player option
for(i in 1:1655) {
  tag.vector = unlist(strsplit(ts.2014$Tags[i], split = ",")) %>% tolower()
  player.vector = c()
  player.vector = c(player.vector, intersect(tag.vector, player))
  player.string = paste(player.vector, collapse = ",")
  ts.2014$PlayerOption[i] = player.string
}

### 2014 visual option
for(i in 1:1655) {
  tag.vector = unlist(strsplit(ts.2014$Tags[i], split = ",")) %>% tolower()
  visual.vector = c()
  visual.vector = c(visual.vector, intersect(tag.vector, visual))
  visual.string = paste(visual.vector, collapse = ",")
  ts.2014$VisualOption[i] = visual.string
}

### 2014 trait option
for(i in 1:1655) {
  tag.vector = unlist(strsplit(ts.2014$Tags[i], split = ",")) %>% tolower()
  trait.vector = c()
  trait.vector = c(trait.vector, intersect(tag.vector, trait))
  trait.string = paste(trait.vector, collapse = ",")
  ts.2014$TraitOption[i] = trait.string
}


## remain tags

### 2012 remain
for(i in 1:374) {
  player.vector = unlist(strsplit(ts.2012$PlayerOption[i], split = ","))
  visual.vector = unlist(strsplit(ts.2012$VisualOption[i], split = ","))
  trait.vector = unlist(strsplit(ts.2012$TraitOption[i], split = ","))
  option.union = c(player.vector, visual.vector, trait.vector)
  tag.vector = unlist(strsplit(ts.2012$Tags[i], split = ","))
  tag2.string = setdiff(tag.vector, option.union) %>% paste(collapse = ",")
  ts.2012$Tags2[i] = tag2.string
}

### 2013 remain
for(i in 1:485) {
  player.vector = unlist(strsplit(ts.2013$PlayerOption[i], split = ","))
  visual.vector = unlist(strsplit(ts.2013$VisualOption[i], split = ","))
  trait.vector = unlist(strsplit(ts.2013$TraitOption[i], split = ","))
  option.union = c(player.vector, visual.vector, trait.vector)
  tag.vector = unlist(strsplit(ts.2013$Tags[i], split = ","))
  tag2.string = setdiff(tag.vector, option.union) %>% paste(collapse = ",")
  ts.2013$Tags2[i] = tag2.string
}

### 2014 remain
for(i in 1:1655) {
  player.vector = unlist(strsplit(ts.2014$PlayerOption[i], split = ","))
  visual.vector = unlist(strsplit(ts.2014$VisualOption[i], split = ","))
  trait.vector = unlist(strsplit(ts.2014$TraitOption[i], split = ","))
  option.union = c(player.vector, visual.vector, trait.vector)
  tag.vector = unlist(strsplit(ts.2014$Tags[i], split = ","))
  tag2.string = setdiff(tag.vector, option.union) %>% paste(collapse = ",")
  ts.2014$Tags2[i] = tag2.string
}

## main tag

### 2012 main tag
for(i in 1:374) {
  ts.2012$MainTag[i] = get.maintag(ts.2012$Tags2[i], ts.2012$Summary[i])
}

### 2013 main tag
for(i in 1:485) {
  ts.2013$MainTag[i] = get.maintag(ts.2013$Tags2[i], ts.2013$Summary[i])
}

### 2014 main tag
for(i in 1:1655) {
  ts.2014$MainTag[i] = get.maintag(ts.2014$Tags2[i], ts.2014$Summary[i])
}

## remain tag

### 2012 tag3
for(i in 1:374) {
  tag2.vector = unlist(strsplit(ts.2012$Tags2[i], split = ","))
  main.vector = unlist(strsplit(ts.2012$MainTag[i], split = ","))
  tag3.string = setdiff(tag2.vector, main.vector) %>% paste(collapse = ",")
  ts.2012$Tag3[i] = tag3.string
}

### 2013 tag3
for(i in 1:485) {
  tag2.vector = unlist(strsplit(ts.2013$Tags2[i], split = ","))
  main.vector = unlist(strsplit(ts.2013$MainTag[i], split = ","))
  tag3.string = setdiff(tag2.vector, main.vector) %>% paste(collapse = ",")
  ts.2013$Tag3[i] = tag3.string
}

### 2014 tag3
for(i in 1:1655) {
  tag2.vector = unlist(strsplit(ts.2014$Tags2[i], split = ","))
  main.vector = unlist(strsplit(ts.2014$MainTag[i], split = ","))
  tag3.string = setdiff(tag2.vector, main.vector) %>% paste(collapse = ",")
  ts.2014$Tag3[i] = tag3.string
}

## reorganized
ts.2012.1 = ts.2012[ ,-c(4,5,9)]
ts.2013.1 = ts.2013[ ,-c(4,5,9)]
ts.2014.1 = ts.2014[ ,-c(4,5,9)]

## write data
write.csv(ts.2012.1, "t&s_2012_v2.csv", row.names = F)
write.csv(ts.2013.1, "t&s_2013_v2.csv", row.names = F)
write.csv(ts.2014.1, "t&s_2014_v2.csv", row.names = F)
