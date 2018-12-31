library(dplyr)
library(stringr)


# Read in data
display = read.csv("./final/complete/display_data_12-14.csv", stringsAsFactors = F)
dummy = read.csv("./final/complete/dummy_data_v2.csv", stringsAsFactors = F)
tag.relation = read.csv("./final/complete/tag_calculation.csv", stringsAsFactors = F)
## copy dummy dataset for calculation
dummy.1 = dummy[-451, ]
tag.relation.1 = tag.relation

## restructure column names
for(i in 1:326) {
  names(dummy.1)[i] = str_replace_all(names(dummy.1[i]), "\\.", " ")
}

# Page 1: display the basic data
print("This function displays basic information for the game")
row.names(display) = display$Appid
display.list = setNames(split(display, seq(nrow(display))), rownames(display))
ent = readline(prompt = "Please enter ID number:")
target.list = display.list[[ent]]
str(target.list)

# Page 2: Criteria Selection 
print("This part will demo the recommendation workflow")

## First category ranking: price, playtime and score
print("Please rank the following criteria: Price, Playtime or Scores")
criteria1 = readline("First considered factor:")
criteria2 = readline("Second considered factor:")
criteria3 = readline("Third considered factor:")
print(paste("Weighting:", criteria1, "x4", criteria2, "x3", criteria3, "x2"))

## Second category ranking: Main Tags
### select the main function according to its main tag
print(paste("please rank the following crteria:", target.list$MainTags))
consider1 = readline("First considered factor:")
consider2 = readline("Second considered factor:")
consider3 = readline("Third considered factor:")
print(paste("Weighting:", consider1, "x4", consider2, "x3", consider3, "x2"))


# Assign weight

## First category - Criteria1
if(criteria1 == "price") {
  dummy.1$PriceRange = dummy.1$PriceRange * 4
} else if(criteria1 == "playtime") {
  dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *4
} else if(criteria1 == "score") {
  dummy.1$Index = dummy.1$Index *4
}
## First category - Criteria2
if(criteria2 == "price") {
  dummy.1$PriceRange = dummy.1$PriceRange * 3
} else if(criteria2 == "playtime") {
  dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *3
} else if(criteria2 == "score") {
  dummy.1$Index = dummy.1$Index *3
}
## First category - Criteria3
if(criteria3 == "price") {
  dummy.1$PriceRange = dummy.1$PriceRange * 2
} else if(criteria3 == "playtime") {
  dummy.1$PlayTimeRange = dummy.1$PlayTimeRange *2
} else if(criteria3 == "score") {
  dummy.1$Index = dummy.1$Index *2
}

## Second category
maintag.vector = unlist(strsplit(target.list$MainTags, ","))

### retrieve index
sub.tagprob = tag.relation.1 %>% subset(Tag1 == consider1 | Tag1 == consider2 | Tag1 == consider3)
sub.tagprob[sub.tagprob$Tag1 == consider1, 3] = sub.tagprob[sub.tagprob$Tag1 == consider1, 3] * 4
sub.tagprob[sub.tagprob$Tag1 == consider2, 3] = sub.tagprob[sub.tagprob$Tag1 == consider1, 3] * 3
sub.tagprob[sub.tagprob$Tag1 == consider3, 3] = sub.tagprob[sub.tagprob$Tag1 == consider1, 3] * 2

sub.tagprob = sub.tagprob %>% group_by(Tag2) %>% summarise(Accuprob = sum(value))

### assign weight
for(i in 9:326) {
  if(colnames(dummy.1)[i] == consider1) {
    dummy.1[ ,i] = dummy.1[ ,i] * 4
  } else if(colnames(dummy.1)[i] == consider2) {
    dummy.1[ ,i] = dummy.1[ ,i] * 3
  } else if(colnames(dummy.1)[i] == consider3) {
    dummy.1[ ,i] = dummy.1[ ,i] * 2
  } else if(colnames(dummy.1)[i] %in% sub.tagprob$Tag2) {
    multiply = sub.tagprob[sub.tagprob$Tag2 == colnames(dummy.1)[i], ]$Accuprob
    dummy.1[ ,i] = dummy.1[ ,i] * multiply
  }
}


# Consine Calculation
a = as.vector(dummy.1[dummy.1$Appid == target.list$Appid, 4:326])
cosine.value = c()

print("Top 20 Similar Games (Need 2-3 minutes to run)")

for(i in 1:2497) {
  b = as.vector(dummy.1[i, 4:326])
  cosine.cal = sum(a*b)/sqrt(sum(a^2)*sum(b^2))
  cosine.value = c(cosine.value, cosine.cal)
}

recommend.list = data_frame(Game = dummy.1$Game, ID = dummy.1$Appid, Publisher = display$Publisher, PlayerOption = display$PlayerOption, VisualOption = display$VisualOption, TraitOption = display$TraitOption, Similarity = cosine.value)
print(arrange(recommend.list,desc(Similarity), VisualOption))
