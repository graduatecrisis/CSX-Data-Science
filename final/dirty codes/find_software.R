library(dplyr)

## 2012
steam.2012 = read.csv("./final/2012 - Year Stats - SteamSpy - All the data and stats about Steam games.csv")
publisher = unique(steam.2012$Publisher.s.)
price = unique(steam.2012$Price)

subset(steam.2012, Price == price[1])


test = c(217, 215, 213, 211, 208, 207, 205, 203, 202, 201)
m = data.frame()
for(i in test) {
  m1 = steam.2012 %>% subset(Publisher.s. == publisher[i])
  m = rbind(m, m1)
}

subset(steam.2012, X. %in%c(267,262,228,338,285))

scatter

steam.2012.revised = steam.2012[-c(52,88,354,357,376), ]
write.csv(steam.2012.revised, "steam_2012.csv", row.names = FALSE)


## 2013
steam.2013 = read.csv("./final/2013 - Year Stats - SteamSpy - All the data and stats about Steam games.csv")
price = unique(steam.2013$Price)
subset(steam.2013, Price == price[1])
subset(steam.2013, X. %in% c(403, 483, 492, 450, 406, 275, 338, 508, 290, 329, 448, 433, 509))
soft = c(291, 294, 298, 309, 418, 442, 474, 478, 480, 500, 506, 507, 513)
steam.2013.revised = steam.2013[-soft, ]
write.csv(steam.2013.revised, "steam_2013.csv", row.names = FALSE)


## 2014
steam.2014 = read.csv("./final/2014 - Year Stats - SteamSpy - All the data and stats about Steam games.csv")
price = unique(steam.2014$Price)

subset(steam.2014, Price == price[1])

soft = c(1338, 911, 1612, 721, 1065, 1458, 1572, 1594, 1295, 395, 1634, 1641, 686, 1256, 1479, 1463)
steam.2014.revised = steam.2014[-soft, ]
write.csv(steam.2014.revised, "steam_2014.csv", row.names = FALSE)
