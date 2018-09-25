library(httr)

## Request Response
airbnb_url = "https://www.airbnb.com.tw/api/v2/explore_tabs?version=1.3.9&satori_version=1.0.5&_format=for_explore_search_web&experiences_per_grid=20&items_per_grid=18&guidebooks_per_grid=20&auto_ib=false&fetch_filters=true&has_zero_guest_treatment=false&is_guided_search=true&is_new_cards_experiment=true&luxury_pre_launch=false&query_understanding_enabled=true&show_groupings=true&supports_for_you_v3=true&timezone_offset=480&client_session_id=e2f76188-ff1c-46c7-a2fb-b920711bc3c4&metadata_only=false&is_standard_search=true&refinement_paths%5B%5D=%2Fselect_homes&selected_tab_id=select_home_tab&click_referer=t%3ASEE_ALL%7Csid%3Afaf9b561-b49d-4d47-95f7-4ec3b4e2438e%7Cst%3AHOME_GROUPING_SELECT_HOMES&superhost=false&guests=1&children=0&allow_override%5B%5D=&zoom=12&search_by_map=true&sw_lat=45.459863034753035&sw_lng=-73.63029267791465&ne_lat=45.54028300669568&ne_lng=-73.49478735516233&s_tag=2AR1yFa5&screen_size=medium&query=Montr%C3%A9al%2C%20QC%2C%20Canada&_intents=p1&key=d306zoyjsyarp7ifhu67rjxn52tv0t20&currency=TWD&locale=zh-TW"
respond = GET(airbnb_url)
res = content(respond)

## Find Useful Data
res_explore = res$explore_tabs
res_section = res_explore[[1]]$sections
res_section_list_1 = res_section[[2]]$listings
res_section_list_2 = res_section[[4]]$listings

## Fixing Null : list2 element2, 3 neighborhood = NULL
for(i in 1:12) {
  if(is.null(res_section_list_2[[i]][["listing"]][["neighborhood"]])) {
    res_section_list_2[[i]][["listing"]][["neighborhood"]] = "Not Given"
  }
}



## Extract funciton: list 1
extract = function(n, x) {
  A = 1:n
  for(i in 1:n) {
    A[i] = res_section_list_1[[i]][["listing"]][[x]]
  }
  return(A)
}

price_tag = function(n, price_string) {
  B = 1:n
  for(i in 1:n) {
    B[i] = res_section_list_1[[i]][["pricing_quote"]][[price_string]]
  }
  return(B)
}


## Extract funciton: list 2
extract_2 = function(n, x) {
  A = 1:n
  for(i in 1:n) {
    A[i] = res_section_list_2[[i]][["listing"]][[x]]
  }
  return(A)
}

price_tag_2 = function(n, price_string) {
  B = 1:n
  for(i in 1:n) {
    B[i] = res_section_list_2[[i]][["pricing_quote"]][[price_string]]
  }
  return(B)
}

## Vector Creating Function
combine_trait = function(n1, n2, label) {
  D = c(extract(n1, label), extract_2(n2, label))
  return(D)
}

combine_price = function(n1, n2, label) {
  E = c(price_tag(n1, label), price_tag_2(n2, label))
  return(E)
}

names = combine_trait(6, 12, "name")
district = combine_trait(6, 12, "neighborhood")
guest_num = combine_trait(6, 12, "guest_label")
bedroom_num = combine_trait(6, 12, "bedroom_label")
bed_num = combine_trait(6, 12, "bed_label")
bathroom_num = combine_trait(6, 12, "bathroom_label")
amenities = combine_trait(6, 12, "preview_amenities")
type = combine_trait(6, 12, "room_type")
rating = combine_trait(6, 12, "star_rating")
price = combine_price(6, 12, "price_string")

montreal_airbnb = data.frame(names, district, guest_num, bedroom_num, bed_num, 
                             bathroom_num, amenities, type, rating, price)
## Tidy Data
library(dplyr)
library(stringr)
library(tidyr)

montreal_airbnb = tbl_df(unite(montreal_airbnb, bedroom, bedroom_num, bed_num, sep = ";"))
montreal_airbnb$rating = as.numeric(montreal_airbnb$rating)
montreal_airbnb$names = as.character(montreal_airbnb$names)
montreal_airbnb$district = as.character(montreal_airbnb$district)
montreal_airbnb$guest_num = as.character(montreal_airbnb$guest_num)
montreal_airbnb$bathroom_num = as.character(montreal_airbnb$bathroom_num)
montreal_airbnb$amenities = as.character(montreal_airbnb$amenities)
montreal_airbnb$type = as.character(montreal_airbnb$type)
montreal_airbnb$price = as.character(montreal_airbnb$price)

str(montreal_airbnb)
