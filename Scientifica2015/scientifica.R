# Generate a "languages as light" world map as used for Scientifica 2015 by the Department of Comparartive Linguistics, University of Zurich
# Steven Moran <steven.moran@uzh.ch>
#
# Language data points come from the Glottolog, cite as:
# Hammarström, Harald & Forkel, Robert & Haspelmath, Martin & Bank, Sebastian. 2015. Glottolog 2.6. Leipzig: Max Planck Institute for Evolutionary Anthropology. Available online at http://glottolog.org.

library(dplyr)
library(ggplot2)
library(maps)
library(mapdata)
library(TypDB)

###################################################################
# Get the Glottolog language's latitude and longitude coordinates #
###################################################################

df <- glottolog %>% select(Glottolog, latitude, longitude) %>% na.omit() %>% arrange(Glottolog)
x <- df$longitude
y <- df$latitude

##################
# Plot some maps #
##################

# White points on gray ocean and gray landmass with no country boundaries
mp <- NULL
mapWorld <- borders("world", colour="gray50", fill="gray50") # create a layer of borders
mp <- ggplot() + mapWorld
mp <- mp + geom_point(aes(x=x, y=y), color="white", size=1) 
mp <- mp + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) # comment to add grid lines
mp

# White points on gray ocean and black landmass with no country boundaries
mp <- NULL
mapWorld <- borders("world", colour="black", fill="black") # create a layer of borders
mp <- ggplot() + mapWorld
mp <- mp + geom_point(aes(x=x, y=y), color="white", size=1) 
mp <- mp + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) # comment to add grid lines
mp

# White points on black background (this is a horrible hack -- sorry!)
png("plot.png", height= 9700, width=14550)
# pdf("plot.pdf")
mp <- NULL
mapWorld <- borders("world", colour="black", fill="black") # create a layer of borders
mp <- ggplot() + mapWorld
mp <- mp + geom_point(aes(x=x, y=y), color="white", size=15) 
# mp <- mp + labs(title = "Languages as light")
mp <- mp + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
mp <- mp + theme(panel.background = element_rect(fill = 'black', colour = 'black'))
mp <- mp + theme(axis.line=element_blank(),axis.text.x=element_blank(),
axis.text.y=element_blank(),axis.ticks=element_blank(),
axis.title.x=element_blank(),
axis.title.y=element_blank(),legend.position="none",panel.border=element_blank(),panel.grid.major=element_blank())
mp
dev.off()

