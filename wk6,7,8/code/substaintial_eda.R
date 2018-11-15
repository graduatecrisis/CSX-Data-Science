library(dplyr)
library(ggplot2)

# substantial
games = read.csv("goty_data.csv", stringsAsFactors = FALSE)
games$Year = as.ordered(games$Year)
games$winner = as.factor(games$winner)
games$Publisher_index = as.factor(games$Publisher_index)
games$Sequel = as.factor(games$Sequel)


# studio plot
ggplot(games, aes(Developer, fill = Developer)) + geom_bar() +
  guides(fill = FALSE) +
  xlab("") +
  ylab("") +
  coord_flip() +
  ggtitle("Nominated Studios", subtitle = "2008 - 2017") +
  theme(title = element_text(face = "bold", size = 12))

# publisher plot
ggplot(games, aes(Publisher, fill = Publisher)) + geom_bar() +
  guides(fill = FALSE) +
  xlab("") +
  ylab("") +
  scale_y_continuous(breaks = c(1:12)) +
  coord_flip() +
  ggtitle("Nominated Publishers", subtitle = "2008 - 2017") +
  theme(title = element_text(face = "bold", size = 12))

# game time plot

normal.time = ggplot(games, aes(x = Year, y = Gametime_main.extra, color = winner)) +
  geom_point() +
  scale_color_discrete() +
  theme_bw() +
  ggtitle("Gametime Comparison: Main+Extra Content") +
  ylab("Gametime for Main+Extra Content") +
  xlab("") 

extra.time = ggplot(games, aes(x = Year, y = time.diff, color = winner)) +
  geom_point() +
  scale_color_discrete() +
  theme_bw() +
  ggtitle("Gametime Comparison: Extra Content") +
  ylab("Gametime for Extra Content") +
  xlab("") 
  


