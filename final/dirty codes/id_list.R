library(dplyr)
steam.2012 = read.csv("./final/steam_2012.csv", stringsAsFactors = FALSE)
game.2012 = steam.2012$Game
steam.2013 = read.csv("./final/steam_2013.csv", stringsAsFactors = FALSE)
game.2013 = steam.2013$Game
steam.2014 = read.csv("./final/steam_2014.csv", stringsAsFactors = FALSE)
game.2014 = steam.2014$Game
steam.2015 = read.csv("./final/steam_2015.csv", stringsAsFactors = FALSE)
game.2015 = steam.2015$Game
steam.2016 = read.csv("./final/steam_2016.csv", stringsAsFactors = FALSE)
game.2016 = steam.2016$Game
steam.2017 = read.csv("./final/steam_2017.csv", stringsAsFactors = FALSE)
game.2017 = steam.2017$Game

title = c(game.2012, game.2013, game.2014, game.2015, game.2016, game.2017)
id = c()

id.list = data_frame(title = title)

game.id = read.csv("./final/Games_id.csv", stringsAsFactors = F)

for(i in 1:16836) {
  if(id.list$title[i] %in% game.id$name) {
    id.list$index[i] = game.id$appid[which(game.id$name == id.list$title[i])]
  } else {
    id.list$index[i] = NA
  }
}

year = c(rep(2012, 381), rep(2013, 502), rep(2014, 1682), rep(2015, 2680), rep(2016, 4617), rep(2017, 6974))

id.list = cbind(year, id.list)
write.csv(id.list, "appid_list.csv", row.names = F)

sum(is.na(id.list))
which(is.na(id.list[ ,2]))[1:10]

id.list[1408, ]
id.list[1408, ]$index = 262000

