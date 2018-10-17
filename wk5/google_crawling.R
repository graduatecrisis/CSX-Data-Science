library(rvest)
library(stringr)

google.news = read_html("https://news.google.com/search?q=google&hl=en-US&gl=US&ceid=US%3Aen")

google.news


html_nodes(google.news, "#yDmH0d > c-wiz > div > div.ajwQHc.BL5WZb.RELBvb > div > main > c-wiz > div.lBwEZb.BL5WZb.xP6mwf > div:nth-child(100) > div > article > div.mEaVNd > div > h3 > a > span") %>% html_text()


css = c()
for(i in 1:100) {
  css[i] = str_c("#yDmH0d > c-wiz > div > div.ajwQHc.BL5WZb.RELBvb > div > main > c-wiz > div.lBwEZb.BL5WZb.xP6mwf > div:nth-child(", i, ") > div > article > div.mEaVNd > div > h3 > a > span")
}


titles = c()

for(i in 1:100) {
  titles[i] = html_nodes(google.news, css[i]) %>% html_text()
}

titles[100]
titles[1:20]

writeLines(titles, file("Googlenews_1017.txt"))
