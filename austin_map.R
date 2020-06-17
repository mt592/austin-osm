
###Austin Map

library(tidyverse)
library(osmdata)
library(sf)

#setwd()
getbb("Austin Texas")

streets <- getbb("Austin Texas")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()
streets


small_streets <- getbb("Austin Texas")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway")) %>%
  osmdata_sf()

river <- getbb("Austin Texas")%>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()


ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .3,
          alpha = .8) +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "#7fc0ff",
          size = .4,
          alpha = .5) +
  geom_point(shape=16, color="white", size=4, aes(x = -97.74, y = 30.27))+
  coord_sf(xlim = c(-97.93677, -97.56053), 
           ylim = c(30.09846, 30.51663),
           expand = FALSE) +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "#282828")
  )

ggsave("austin_map.png", width = 6, height = 6)

