library(rvest)
library(stringr)

facebook.news = read_html("https://news.google.com/search?q=facebook&hl=en-US&gl=US&ceid=US%3Aen")

facebook.news

css = c()
for(i in 1:100) {
  css[i] = str_c("#yDmH0d > c-wiz > div > div.ajwQHc.BL5WZb.RELBvb > div > main > c-wiz > div.lBwEZb.BL5WZb.xP6mwf > div:nth-child(", i, ") > div > article > div.mEaVNd > div > h3 > a > span")
}



titles = c()

for(i in 1:100) {
  titles[i] = html_nodes(facebook.news, css[i]) %>% html_text()
}

titles[100]
titles[1:20]

writeLines(titles, file("Facebooknews_1017.txt"))
