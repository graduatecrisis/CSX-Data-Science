library(ggplot2)

## Read in Data
house = read.csv("./wk3/Montreal_Airbnb.csv")
attach(house)
house$title = as.character(house$title)
house$person = as.factor(house$person)
str(house)


## Reconstruct Data
district.1 = as.character(unique(district))
mean.price = c()
max.price = c()

for(i in district.1) {
  mean.price = c(mean.price, mean(price[district == i])) 
  max.price = c(max.price, max(price[district == i]))
}

house2 = data.frame(district.1, mean.price, max.price)

for(i in 1:16) {
  if(mean.price[i] > mean(price)) {
    house2$mean.price.type[i] = "Above Average"
  } else {
    house2$mean.price.type[i] = "Below Average"
  } 
}

str(house2)

attach(house2)


district.count = 
  ggplot(data = house, aes(x = district)) +
  geom_bar(width = 0.5, aes(fill = person))+
  coord_flip() +
  theme_bw() +
  theme(legend.position = "bottom", 
        axis.text.x = element_text(size = 6)) +
  scale_fill_discrete(name = "Person Capacity",
                      guide = guide_legend(reverse = TRUE)) +
  scale_y_continuous(breaks = seq(1,15,1), name = "Count") +
  scale_x_discrete(name = "") +
  labs(title = "Montreal Airbnb House Listing Number", subtitle = "By Neighborhood")

print(district.count)


district.price = 
  ggplot(data = house2, aes(x = district.1, y = mean.price)) +
  geom_bar(stat = "identity", width = 0.5, fill = "skyblue") +
  coord_flip() +
  theme_bw() +
  scale_x_discrete(name = "") +
  scale_y_continuous(name = "Mean Price/Night (CAD)") +
  labs(title = "Montreal Airbnb House Listing Price", subtitle = "Avg. Price By Neighborhood")

print(district.price)


price.comparison = 
  ggplot(data = house2, aes(x = district.1, y = mean.price, label = round((mean.price), digits = 0))) +
  geom_point(aes(col = mean.price.type), size = 6) +
  coord_flip() +
  theme_bw() +
  scale_color_manual(name = "Mean Price Comparison", 
                     labels = c("Above Average", "Below Average"), 
                     values = c("Above Average" = "#FF9999", "Below Average" = "skyblue")) +
  geom_text(color = "#333333", size = 3) +
  scale_x_discrete(name = "") +
  theme(legend.position = "bottom") +
  geom_hline(yintercept = 1502,linetype = "dashed") +
  annotate("text", y = 1502, x = 1, label = "Ave. Price = $1502", size = 4) +
  scale_y_continuous(name = "Mean Price/Night (CAD)") +
  labs(title = "Montreal Airbnb House Listing Price", subtitle = "Avg. Price By Neighborhood")

print(price.comparison)



detach(house)
detach(house2)


library(OpenStreetMap)
mtl.map = openmap(c(lat = 45.5800, lon = -73.6500), c(lat = 45.4177, lon = -73.5290),
                  type = "osm", zoom = 12)
mtl.map.plot = autoplot(openproj(mtl.map))

mtl.airbnb.price = mtl.map.plot +
  geom_label(data = house, aes(x = lng, y = lat, label = price, fontface = 3), size = 3, hjust = 1, vjust = 0) +
  geom_point(data = house, aes(x = lng, y = lat, fill = person), size = 2, shape = 21) +
  scale_fill_manual(name = "Person Capacity", values = c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2")) +
  labs(title = "Montreal Airbnb Listings", x = "Longtitude", y = "Latitude") +
  theme(plot.title = element_text(face = "bold", size = 14))


print(mtl.airbnb.price)

