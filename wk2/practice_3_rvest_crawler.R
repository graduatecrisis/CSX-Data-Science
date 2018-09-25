## Practice 3
## Rvest Crawler Example

library(rvest)

## One-time crawler
url = "https://store.steampowered.com/search/?term=assassin%27s%20creed"
res = read_html(url)

res_title = html_nodes(res, ".title")
res_date = html_nodes(res, ".search_result_row .col.search_released")
res_price = html_nodes(res, ".col.search_price:not(.discounted)")

titles = html_text(res_title)
date = html_text(res_date)
price = html_text(res_price)

### Tidy price
library(stringr)
price_1 = str_remove(price, "\r\n\t\t\t\t\t\t\t")
price_1 = str_remove_all(price_1, "\t")

assassin = data.frame(titles, date, price_1)


## Add for loop

url = 1:4
Temp = list()
Assassing = data.frame()


for(i in 1:2) {
  
  url[i] = print(paste("https://store.steampowered.com/search/?term=assassin%27s%20creed&page=",i, sep = ""))
  
  res = read_html(url[i])

  res_title = html_nodes(res, ".title")
  res_date = html_nodes(res, ".search_result_row .col.search_released")
  res_price = html_nodes(res, ".col.search_price:not(.discounted)")
  
  titles = html_text(res_title)
  date = html_text(res_date)
  price = html_text(res_price)
  
  ### Tidy price
  price_1 = str_remove(price, "\r\n\t\t\t\t\t\t\t")
  price_1 = str_remove_all(price_1, "\t")
  
  Temp[[i]] = data.frame(titles, date, price_1)
  
  Assassing = rbind.data.frame(Assassing, Temp[[i]])
}

Assassing

