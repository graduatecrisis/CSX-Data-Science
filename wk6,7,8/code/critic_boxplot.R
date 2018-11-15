library(dplyr)
library(ggplot2)

# 2014
dragon.critic = read.csv("./wk6,7,8/2014/Dragon Age_critics.csv", stringsAsFactors = F)
dragon.critic.score = dragon.critic$score
bayonetta.critic = read.csv("./wk6,7,8/2014/Bayonetta 2_critics.csv", stringsAsFactors = F)
bayonetta.critic.score = bayonetta.critic$score
darksoul.critic = read.csv("./wk6,7,8/2014/Dark Souls 2_critics.csv", stringsAsFactors = F)
darksoul.critic.score = darksoul.critic$score
hearthstone.critic = read.csv("./wk6,7,8/2014/hearthstone_critics.csv", stringsAsFactors = F)
hearthstone.critic.score = hearthstone.critic$score
middleearth.critic = read.csv("./wk6,7,8/2014/middleearth_critics.csv", stringsAsFactors = F)
middleearth.critic.score = middleearth.critic$score
name =  c(rep("Dragon Age: Inquisition", 43), rep("Bayonetta 2", 80), rep("Dark Souls 2", 36), rep("Hearthstone", 42), rep("Middle-Earth", 85))
total.score = c(dragon.critic.score, bayonetta.critic.score, darksoul.critic.score, hearthstone.critic.score, middleearth.critic.score)
critic.2014 = data_frame(year = rep(2014, 286), game = name, score = total.score)

sb.2014 = ggplot(critic.2014, aes(x=game, y=score, fill=game)) +
  geom_boxplot() +
  guides(fill = FALSE) +
  xlab("") +
  ylab("") +
  ggtitle("Review Score Comparison - Critics", subtitle = "2014") +
  coord_flip() +
  theme(axis.text.y = element_text(face = "bold", size = 11), title = element_text(size = 15))

# 2013
bioshock.critic = read.csv("./wk6,7,8/2013/Bioshock Infinite_critics.csv", stringsAsFactors = F)
bioshock.critic.score = bioshock.critic$score
gta5.critic = read.csv("./wk6,7,8/2013/GTA 5_critics.csv", stringsAsFactors = F)
gta5.critic.score = gta5.critic$score
mario3d.critic = read.csv("./wk6,7,8/2013/Super Mario 3D_critics.csv", stringsAsFactors = F)
mario3d.critic.score = mario3d.critic$score
last.critic = read.csv("./wk6,7,8/2013/The Last of Us_critics.csv", stringsAsFactors = F)
last.critic.score = last.critic$score
tomb.critic = read.csv("./wk6,7,8/2013/Tomb Raider_critics.csv", stringsAsFactors = F)
tomb.critic.score = tomb.critic$score
total.score.2013 = c(bioshock.critic.score, gta5.critic.score, mario3d.critic.score, last.critic.score, tomb.critic.score)
name = c(rep("Bioshock Infinite", 68), rep("GTA 5", 58), rep("Super Mario 3D", 83), rep("The Last of Us", 98), rep("Tomb Raider", 70))
critic.2013 = data_frame(year = rep(2013, 377), game = name, score = total.score.2013)

sb.2013 = ggplot(critic.2013, aes(x=game, y=score, fill=game)) +
  geom_boxplot() +
  guides(fill = FALSE) +
  xlab("") +
  ylab("") +
  ggtitle("Review Score Comparison - Critics", subtitle = "2013") +
  coord_flip() +
  theme(axis.text.y = element_text(face = "bold", size = 11), title = element_text(size = 15))

# 2015
bloodborne.critic = read.csv("./wk6,7,8/2015/bloodborne_critics.csv", stringsAsFactors = F)
bloodborne.critic.score = bloodborne.critic$score
fallout4.critic = read.csv("./wk6,7,8/2015/fallout4_critics.csv", stringsAsFactors = F)
fallout4.critic.score = fallout4.critic$score
mariomaker.critic = read.csv("./wk6,7,8/2015/mariomaker_critics.csv", stringsAsFactors = F)
mariomaker.critic.score = mariomaker.critic$score
metalgear5.critic = read.csv("./wk6,7,8/2015/metalgear5_critics.csv", stringsAsFactors = F)
metalgear5.critic.score = metalgear5.critic$score
witcher3.critic = read.csv("./wk6,7,8/2015/witcher3_critics.csv", stringsAsFactors = F)
witcher3.critic.score = witcher3.critic$score
total.score.2015 = c(bloodborne.critic.score, fallout4.critic.score, mariomaker.critic.score, metalgear5.critic.score, witcher3.critic.score)
name = c(rep("Bloodborne", 100), rep("Fallout4", 58), rep("Super Mario Maker", 85), rep("Metal Gear Solid 5", 86), rep("Witcher 3", 79))
critic.2015 = data_frame(year = rep(2015, 408), game = name, score = total.score.2015)

sb.2015 = ggplot(critic.2015, aes(x=game, y=score, fill=game)) +
  geom_boxplot() +
  guides(fill = FALSE) +
  xlab("") +
  ylab("") +
  ggtitle("Review Score Comparison - Critics", subtitle = "2015") +
  coord_flip() +
  theme(axis.text.y = element_text(face = "bold", size = 11), title = element_text(size = 15))

# 2016
doom.critic = read.csv("./wk6,7,8/2016/Doom_critics.csv", stringsAsFactors = F)
doom.critic.score = doom.critic$score
inside.critic = read.csv("./wk6,7,8/2016/INSIDE_critics.csv", stringsAsFactors = F)
inside.critic.score = inside.critic$score
overwatch.critic = read.csv("./wk6,7,8/2016/overwatch_critics.csv", stringsAsFactors = F)
overwatch.critic.score = overwatch.critic$score
titanfall2.critic = read.csv("./wk6,7,8/2016/Titanfall 2_critics.csv", stringsAsFactors = F)
titanfall2.critic.score = titanfall2.critic$score
uncharted4.critic = read.csv("./wk6,7,8/2016/Uncharted 4_critics.csv", stringsAsFactors = F)
uncharted4.critic.score = uncharted4.critic$score
total.score.2016 = c(doom.critic.score, inside.critic.score, overwatch.critic.score, titanfall2.critic.score, uncharted4.critic.score)
name = c(rep("DOOM", 61), rep("INSIDE", 87), rep("Overwatch", 64), rep("Titanfall 2", 61), rep("Uncharted 4", 113))
critic.2016 = data_frame(year = rep(2016, 386), game = name, score = total.score.2016)

sb.2016 = ggplot(critic.2016, aes(x=game, y=score, fill=game)) +
  geom_boxplot() +
  guides(fill = FALSE) +
  xlab("") +
  ylab("") +
  ggtitle("Review Score Comparison - Critics", subtitle = "2016") +
  coord_flip() +
  theme(axis.text.y = element_text(face = "bold", size = 11), title = element_text(size = 15))
  

# 2017
horizon.critic = read.csv("./wk6,7,8/2017/horizon_critics.csv", stringsAsFactors = F)
horizon.critic.score = horizon.critic$score
persona5.critic = read.csv("./wk6,7,8/2017/persona5_critics.csv", stringsAsFactors = F)
persona5.critic.score = persona5.critic$score
pubg.critic = read.csv("./wk6,7,8/2017/pubg_critics.csv", stringsAsFactors = F)
pubg.critic.score = pubg.critic$score
marioodyssey.critic = read.csv("./wk6,7,8/2017/Super Mario Odyssey_critics.csv", stringsAsFactors = F)
marioodyssey.critic.score = marioodyssey.critic$score
zeldawild.critic = read.csv("./wk6,7,8/2017/Zelda Wild_critics.csv", stringsAsFactors = F)
zeldawild.critic.score = zeldawild.critic$score
total.score.2017 = c(horizon.critic.score, persona5.critic.score, pubg.critic.score, marioodyssey.critic.score, zeldawild.critic.score)
name = c(rep("Horizon Zero Down", 115), rep("Persona 5", 97), rep("PlayerUnknown's Battleground", 46), rep("Super Mario Odyssey", 113), rep("The Legend of Zelda: Breath of the Wild ", 109))
critic.2017 = data_frame(year = rep(2017, 480), game = name, score = total.score.2017)

sb.2017 = ggplot(critic.2017, aes(x=game, y=score, fill=game)) +
  geom_boxplot() +
  guides(fill = FALSE) +
  xlab("") +
  ylab("") +
  ggtitle("Review Score Comparison - Critics", subtitle = "2017") +
  coord_flip() +
  theme(axis.text.y = element_text(face = "bold", size = 11), title = element_text(size = 15))

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


multiplot(sb.2013,sb.2014,sb.2015,sb.2016,sb.2017,cols = 1)
?multiplot()
