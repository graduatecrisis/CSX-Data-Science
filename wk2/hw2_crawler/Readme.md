R Web Crawler Example -- Airbnb
-------------------------------

資料內容主軸
------------

利用Airbnb查詢Montreal, Canada的住宿資料，並將需要的資訊製作成dataframe。 所需資料:

-   名稱

-   房源所在地區

-   可容納人數

-   房間數、床位數

-   衛浴設備數量

-   其他設備

-   房源類型

-   評價星等

-   價格

爬蟲邏輯與步驟
--------------

這個範例選用的是 `httr` package，原因在於其有API可以獲得完整的JSON資料，較容易直接存成dataframe格式。也曾經嘗試過 `rvest` package，但因為網頁本身在捲動時大量使用javascript\*格式，導致 `rvest` 常常抓到空的東西，所以最後選用 `httr` package

### RCode Demo

``` r
library(httr)

## Request Response
airbnb_url = "https://www.airbnb.com.tw/api/v2/explore_tabs?version=1.3.9&satori_version=1.0.5&_format=for_explore_search_web&experiences_per_grid=20&items_per_grid=18&guidebooks_per_grid=20&auto_ib=false&fetch_filters=true&has_zero_guest_treatment=false&is_guided_search=true&is_new_cards_experiment=true&luxury_pre_launch=false&query_understanding_enabled=true&show_groupings=true&supports_for_you_v3=true&timezone_offset=480&client_session_id=e2f76188-ff1c-46c7-a2fb-b920711bc3c4&metadata_only=false&is_standard_search=true&refinement_paths%5B%5D=%2Fselect_homes&selected_tab_id=select_home_tab&click_referer=t%3ASEE_ALL%7Csid%3Afaf9b561-b49d-4d47-95f7-4ec3b4e2438e%7Cst%3AHOME_GROUPING_SELECT_HOMES&superhost=false&guests=1&children=0&allow_override%5B%5D=&zoom=12&search_by_map=true&sw_lat=45.459863034753035&sw_lng=-73.63029267791465&ne_lat=45.54028300669568&ne_lng=-73.49478735516233&s_tag=2AR1yFa5&screen_size=medium&query=Montr%C3%A9al%2C%20QC%2C%20Canada&_intents=p1&key=d306zoyjsyarp7ifhu67rjxn52tv0t20&currency=TWD&locale=zh-TW"
respond = GET(airbnb_url)
res = content(respond)
```

> 從網頁獲得需要的JSON檔，並進行編譯。

``` r
## Find Useful Data
res_explore = res$explore_tabs
res_section = res_explore[[1]]$sections
res_section_list_1 = res_section[[2]]$listings
res_section_list_2 = res_section[[4]]$listings
```

> 首先觀察此URL之 `Preview` 內容，找出所需的資料藏在 **xplore\_tabs -&gt; sections -&gt; listings**，且此頁面共顯示18筆結果，其中 `section[[1]]` 儲存了12筆，`section[[2]]`儲存了6筆

``` r
## Fixing Null : list2 element2, 3 neighborhood = NULL
for(i in 1:12) {
  if(is.null(res_section_list_2[[i]][["listing"]][["neighborhood"]])) {
    res_section_list_2[[i]][["listing"]][["neighborhood"]] = "Not Given"
  }
}
```

> 因 `res_section_list_2`中的neighborhood資料有一些有缺漏(**NULL**)，因此使用 `for loop` 來進行偵錯和取代遺漏值

``` r
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
```

> 為了作業方便，將提取內容的步驟寫成函數，先個別寫不同list的提取函數，再用新函數將兩個結果合併成一個向量

``` r
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
str(montreal_airbnb)
```

    ## 'data.frame':    18 obs. of  10 variables:
    ##  $ names       : Factor w/ 18 levels "Amazing Luxury Downtown Condo at the Bell Center with Views of Mount Royal",..: 13 17 16 8 18 5 1 7 9 10 ...
    ##  $ district    : Factor w/ 10 levels "Downtown Montreal",..: 1 1 8 6 7 8 1 5 1 10 ...
    ##  $ guest_num   : Factor w/ 5 levels "2位","3位","4位",..: 3 2 4 2 1 4 2 3 3 3 ...
    ##  $ bedroom_num : Factor w/ 3 levels "1間臥室","2間臥室",..: 1 3 3 1 1 1 1 2 1 1 ...
    ##  $ bed_num     : Factor w/ 3 levels "1張床","2張床",..: 2 1 2 1 1 1 1 2 1 2 ...
    ##  $ bathroom_num: Factor w/ 1 level "1間衛浴": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ amenities   : Factor w/ 2 levels "建築物內免費停車, 無線網路, 廚房, 洗衣機",..: 2 2 2 2 2 2 2 1 2 2 ...
    ##  $ type        : Factor w/ 1 level "整套房子／公寓": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ rating      : num  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ price       : Factor w/ 18 levels "每晚$1842起",..: 3 10 15 2 18 13 6 8 9 7 ...

> 將所需的資料集合成Dataframe的格式，可以發現目前許多格式跟資料類型不太正確，因此需要再做更進一步的整理

``` r
## Tidy Data
library(dplyr)
library(stringr)
library(tidyr)
```

``` r
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
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    18 obs. of  9 variables:
    ##  $ names       : chr  "Relax in a Mid-Century Modern Downtown Loft" "Urban Retreat in Amazing Location Loft" "The New York Loft in Old Montreal" "Logement moderne et confo a Notre-Dame-de-Grace" ...
    ##  $ district    : chr  "Downtown Montreal" "Downtown Montreal" "Old Port" "Notre-Dame-de-Grace" ...
    ##  $ guest_num   : chr  "4位" "3位" "5位" "3位" ...
    ##  $ bedroom     : chr  "1間臥室;2張床" "套房公寓;1張床" "套房公寓;2張床" "1間臥室;1張床" ...
    ##  $ bathroom_num: chr  "1間衛浴" "1間衛浴" "1間衛浴" "1間衛浴" ...
    ##  $ amenities   : chr  "無線網路, 廚房, 洗衣機" "無線網路, 廚房, 洗衣機" "無線網路, 廚房, 洗衣機" "無線網路, 廚房, 洗衣機" ...
    ##  $ type        : chr  "整套房子／公寓" "整套房子／公寓" "整套房子／公寓" "整套房子／公寓" ...
    ##  $ rating      : num  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ price       : chr  "每晚$2118起" "每晚$2855起" "每晚$3561起" "每晚$2026起" ...

> 利用 `tidyr` `dplyr` `stringr` package進行整理

### R Crawling Result

``` r
montreal_airbnb
```

    ## # A tibble: 18 x 9
    ##    names district guest_num bedroom bathroom_num amenities type  rating
    ##    <chr> <chr>    <chr>     <chr>   <chr>        <chr>     <chr>  <dbl>
    ##  1 Rela~ Downtow~ 4位       1間臥室;2~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ##  2 Urba~ Downtow~ 3位       套房公寓;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ##  3 The ~ Old Port 5位       套房公寓;2~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ##  4 Loge~ Notre-D~ 3位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ##  5 Walk~ Old Mon~ 2位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ##  6 Indu~ Old Port 5位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ##  7 Amaz~ Downtow~ 3位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ##  8 Loft~ Not Giv~ 4位       2間臥室;2~ 1間衛浴      建築物內免費停車~ 整套房子~      5
    ##  9 Luxu~ Downtow~ 4位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## 10 Mid-~ Ville-M~ 4位       1間臥室;2~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## 11 Loft~ Downtow~ 4位       1間臥室;2~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## 12 Expl~ Griffin~ 7位       2間臥室;2~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## 13 Styl~ Gay Vil~ 2位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## 14 Quir~ Le Plat~ 4位       2間臥室;3~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## 15 Brig~ Saint-H~ 2位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## 16 Soph~ Gay Vil~ 4位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## 17 Pent~ Saint-H~ 4位       2間臥室;2~ 1間衛浴      建築物內免費停車~ 整套房子~      5
    ## 18 Appa~ Downtow~ 3位       1間臥室;1~ 1間衛浴      無線網路, 廚房~ 整套房子~      5
    ## # ... with 1 more variable: price <chr>

FAQ
---

1.  Airbnb網頁因每頁廣告所擺放的位置不同，導致每一頁的搜尋結果不一定都是被拆成兩個list儲存，這部分目前還想不到解決方式

2.  最後輸出的部分排版似乎有些跑掉，但如果另存成 `csv`檔至本機目的地檢視似乎沒問題，這部分目前也不知道是什麼原因所造成
