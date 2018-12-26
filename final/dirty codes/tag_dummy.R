
ts.all.2012 = data_frame(Year = ts.2012.1$Year, Name = ts.2012.1$Name, Appid = ts.2012.1$Appid, Tags = tag.total)
ts.all.2013 = data_frame(Year = ts.2013.1$Year, Name = ts.2013.1$Name, Appid = ts.2013.1$Appid, Tags = tag.total)
ts.all.2014 = data_frame(Year = ts.2014.1$Year, Name = ts.2014.1$Name, Appid = ts.2014.1$Appid, Tags = tag.total)

ts.all = rbind.data.frame(ts.all.2012[ ,c(2,4)], ts.all.2013[ ,c(2,4)], ts.all.2014[, c(2,4)])
dummy.vector = rep(0, 2514)

for(i in 3:320) {
  ts.all[ ,i] = dummy.vector
  names(ts.all)[i] = unique.tag[i-2]
}

for(i in 1:2514) {
  for(j in 3:320) {
    if(names(ts.all)[j] %in% unlist(strsplit(ts.all$Tags[i], split = ","))) {
      ts.all[i,j] = 1
    } else {
      ts.all[i,j] = 0
    }
  }
}


write.csv(ts.all, "tag_dummy_2012-2014.csv", row.names = F)

ts.all.1 = rbind(ts.all.2012, ts.all.2013, ts.all.2014)
for(i in 1:2514) {
  ts.all.1$MainTags[i] = paste(unlist(strsplit(ts.all.1$Tags[i], ","))[1:5], collapse = ",")
}

for(i in 1:2514) {
  main.temp = unlist(strsplit(ts.all.1$MainTags[i], ","))
  sub.temp = unlist(strsplit(ts.all.1$Tags[i], ","))
  sub.string = paste(setdiff(sub.temp, main.temp), collapse = ",")
  ts.all.1$SubTags[i] = sub.string
}

ts.all.2 = rbind(ts.2012.1, ts.2013.1, ts.2014.1)

ts.finish = data_frame(Year = ts.all.2$Year, Name = ts.all.2$Name, Appid = ts.all.2$Appid, PlayerOption = ts.all.2$PlayerOption, VisualOption = ts.all.2$VisualOption, TraitOption = ts.all.2$TraitOption, MainTags = ts.all.1$MainTags, SubTags = ts.all.1$SubTags)
write.csv(ts.finish, "tags_2012-2014.csv", row.names = F)
