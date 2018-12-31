library(dplyr)

display = read.csv("./final/display_data_12-14.csv", stringsAsFactors = F)
display = display[-451, ]
row.names(display) = display$Appid

dummy = read.csv("./final/dummy_data_v2.csv", stringsAsFactors = F)
dummy.1 = dummy

print("This function displays basic information for the game")
display.list = setNames(split(display, seq(nrow(display))), rownames(display))
ent = readline(prompt = "Please enter ID number:")
str(display.list[ent])


print("This part will demo the recommendation workflow")
print("Please rank the following criteria: Price, Playtime or Scores")
criteria1 = readline("First considered factor:")
criteria2 = readline("Second considered factor:")
criteria3 = readline("Third considered factor:")
print(paste("Weighting:", criteria1, "x4", criteria2, "x3", criteria3, "x2"))
  
if(criteria1 == "price") {
  dummy.1$PriceRange = dummy.1$PriceRange * 4
} else if(criteria1 == "playtime") {
  dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *4
} else if(criteria1 == "score") {
  dummy.1$Index = dummy.1$Index *4
}
  
if(criteria2 == "price") {
  dummy.1$PriceRange = dummy.1$PriceRange * 3
} else if(criteria2 == "playtime") {
  dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *3
} else if(criteria2 == "score") {
  dummy.1$Index = dummy.1$Index *3
}
  
if(criteria3 == "price") {
  dummy.1$PriceRange = dummy.1$PriceRange * 2
} else if(criteria3 == "playtime") {
  dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *2
} else if(criteria3 == "score") {
  dummy.1$Index = dummy.1$Index *2
}

select.game = as.numeric(readline("Please enter the id of your game:"))
a = as.vector(dummy.1[dummy.1$Appid == select.game, 4:326])
cosine.value = c()

print("Top 20 Similar Games (Need 2-3 minutes to run)")

for(i in 1:2498) {
  b = as.vector(dummy.1[i, 4:326])
  cosine.cal = sum(a*b)/sqrt(sum(a^2)*sum(b^2))
  cosine.value = c(cosine.value, cosine.cal)
}

recommend.list = data_frame(Name = dummy.1$Game, Similarity = cosine.value)
print(head(arrange(recommend.list, desc(Similarity)), 20))
