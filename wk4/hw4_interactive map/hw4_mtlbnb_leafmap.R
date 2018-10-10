
## Read In Data
house = read.csv("./wk3/Montreal_Airbnb.csv")
attach(house)
names(house) ### check col in the data

house$price = as.character(house$price) ### transform to character for popup use
house$person = as.factor(house$person) ### transform to factor for legend use

### add new column for icon group
for(i in 1:54) {
  if(person[i] == 1) {
    house$person.index[i] = "one"
  } else if(person[i] == 2) {
    house$person.index[i] = "two"
  } else if(person[i] == 3) {
    house$person.index[i] = "three"
  } else if(person[i] == 4) {
    house$person.index[i] = "four"
  } else if(person[i] == 5) {
    house$person.index[i] = "five"
  } else {
    house$person.index[i] = "six"
  }
}


## Plot on Map
library(leaflet)

## Create icon list 
person.icon = iconList(
  one = makeIcon("./wk4/icons/person1.png", "./wk4/icon/person1.png", 25, 25), 
  two = makeIcon("./wk4/icons/person2.png", "./wk4/icon/person2.png", 25, 25), 
  three = makeIcon("./wk4/icons/person3.png", "./wk4/icon/person2.png", 25, 25), 
  four = makeIcon("./wk4/icons/person4.png", "./wk4/icon/person2.png", 25, 25), 
  five = makeIcon("./wk4/icons/person5.png", "./wk4/icon/person2.png", 25, 25), 
  six = makeIcon("./wk4/icons/person6.png", "./wk4/icon/person2.png", 25, 25)
)

## Creat Legend Color
pal = colorFactor(c("green", "blue", "yellow", "red", "skyblue", "black"), 
                    domain = person)

## Plot
m = leaflet() %>% setView(lat = 45.50, lng = -73.573, zoom = 11) %>% addTiles() %>% 
  addMarkers(data = house, lat = ~lat, lng = ~lng, icon = person.icon[person.index], label = ~price, popup = ~title) %>%
  addLegend(data = house, pal = pal, values = ~person, opacity = 1)

print(m)
