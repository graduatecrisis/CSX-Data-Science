library(dplyr)
library(rvest)
url = "https://store.steampowered.com/app/333930/Dirty_Bomb/"
try = read_html(url)
try %>% html_node("#game_highlights > div.rightcol > div > div.glance_ctn_responsive_right > div > div.glance_tags.popular_tags") %>% html_text()

body > div.responsive_page_frame.with_header > div.responsive_page_content > div.responsive_page_template_content > div.game_page_background.game > div.page_content_ctn > div:nth-child(6) > div.leftcol.game_description_column > div:nth-child(5) > div.game_page_autocollapse

#game_area_description

#game_highlights > div.rightcol > div > div.glance_ctn_responsive_right > div > div.glance_tags.popular_tags

library(jsonlite)
try = fromJSON("http://api.steampowered.com/ISteamApps/GetAppList/v2", simplifyDataFrame = TRUE)
appid = try$applist$apps

write.csv(appid, "Games_id.csv", row.names = FALSE, fileEncoding = "utf-8")


steam.2012 = read.csv("steam_2012.csv")
title = as.character(steam.2012$Game)

rm(temp)
id = c()

for(i in title) {
  temp = appid[game == i, 1]
  id = c(id, temp)
}

