library(rvest)
library(stringr)
id.list = read.csv("appid_list.csv", stringsAsFactors = F)
url = "https://store.steampowered.com/app/208090/?curator_clanid=4777282&utm_source=SteamDB"
try = id.list[1,2]
str_replace(try, "-", " ")
str_replace(try, ":", " ")

#game_area_description
#game_highlights > div.rightcol > div > div.glance_ctn_responsive_right > div > div.glance_tags.popular_tags
tag.load = url %>% read_html() %>% html_node("#game_highlights > div.rightcol > div > div.glance_ctn_responsive_right > div > div.glance_tags.popular_tags") %>% html_text()
gsub("\n|\r|\t|\\.", "", try.slay)


get.description = function(url) {
  about = url %>% read_html() %>% html_node("#game_area_description") %>% html_text()
  about.clean = gsub("\r|\t|\\.|:", "", about)
  about.clean = gsub("\n", ",", about.clean)
  return(about.clean)
}

get.tag = function(url) {
  tags = url %>% read_html() %>% html_node("#game_highlights > div.rightcol > div > div.glance_ctn_responsive_right > div > div.glance_tags.popular_tags") %>% html_text()
  tags = gsub("\t|\r|\\+", "", tags)
  tags = gsub("\n", ",", tags)
  tags.clean = str_sub(tags,3,-2)
  return(tags.clean)
}


tag.holmes = gsub("\t|\r|\\+", "", tag.holmes)
tag.holmes = gsub("\n", ",", tag.holmes)
str_sub(tag.holmes,3,-2)


