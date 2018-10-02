library(httr)


url = "https://www.airbnb.com.tw/api/v2/explore_tabs?version=1.3.9&satori_version=1.0.7&_format=for_explore_search_web&experiences_per_grid=20&items_per_grid=18&guidebooks_per_grid=20&auto_ib=false&fetch_filters=true&has_zero_guest_treatment=false&is_guided_search=true&is_new_cards_experiment=true&luxury_pre_launch=false&query_understanding_enabled=true&show_groupings=true&supports_for_you_v3=true&timezone_offset=480&client_session_id=c2f43234-5e38-4ee1-9a5c-2366075d5201&metadata_only=false&is_standard_search=true&refinement_paths%5B%5D=%2Fhomes&selected_tab_id=home_tab&click_referer=t%3ASEE_ALL%7Csid%3Ad78a993a-bda2-4cc7-b9be-20a667840c6d%7Cst%3ASELECT_TAB_HOMES_GROUPING&superhost=false&guests=1&children=0&allow_override%5B%5D=&s_tag=m5hIiZ1g&section_offset=3&screen_size=medium&query=Montr%C3%A9al%2C%20QC%2C%20Canada&_intents=p1&key=d306zoyjsyarp7ifhu67rjxn52tv0t20&currency=TWD&locale=zh-TW"
p4 = url %>%
  GET() %>%
  content()
p4.section = p4$explore_tabs[[1]]$sections
p4.listings = p4.section[[1]]$listings

## Extract funciton: list 1
extract = function(n, x) {
  A = 1:n
  for(i in 1:n) {
    if(is.null(p4.listings[[i]][["listing"]][[x]])) {
      A[i] = "Not Given"
    } else {
      A[i] = p4.listings[[i]][["listing"]][[x]]
    }
    
  }
  return(A)
}

price_tag = function(n, price_string) {
  B = 1:n
  for(i in 1:n) {
    B[i] = p4.listings[[i]][["pricing_quote"]][["rate"]][[price_string]]
  }
  return(B)
}

title = extract(18, "name")
district = extract(18, "neighborhood")
lat = extract(18, "lat")
lng = extract(18, "lng")
person = extract(18, "person_capacity")
bedrooms = extract(18, "bedrooms")
beds = extract(18, "beds")
type = extract(18, "room_type_category")
price = price_tag(18, "amount")

p4.house = data.frame(title, district, lat, lng, person, bedrooms, beds, type, price)

?merge.data.frame
Montreal.house = rbind.data.frame(p2.house, p3.house, p4.house)
write.csv(Montreal.house, "Montreal_Airbnb.csv", row.names = FALSE)
