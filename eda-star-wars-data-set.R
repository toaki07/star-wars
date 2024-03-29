## ----message=FALSE, warning=FALSE----
# Load libraries
library(tidyverse)
library(knitr)
library(grid)
# library(magick)

# Read data
starwars_data <- starwars


## ----message=FALSE, warning=FALSE----
# First rows
head(starwars_data)


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Density plot of character heights
starwars_data %>%
  # mutate_at(vars(gender), factor) %>%
  # mutate(gender=recode(gender, female="Female",
  #                      male="Male",
  #                      hermaphrodite="Hermaphrodite",
  #                      none="None")) %>%
  # replace_na(list(gender="None"))  %>%
  ggplot(aes(x=height, fill=gender)) +
  geom_density(alpha=0.5, size=0.7) +
  labs(title="Star Wars characters",
       subtitle="Density plot of character heights",
       x="Height (cm)", y="Density") +
  theme_light() +
  theme(legend.position="bottom",
        legend.title=element_text(face="bold"),
        plot.title=element_text(size=15, face="bold"),
        axis.title=element_text(size=12),
        axis.line=element_line(size=1.01, color="grey35"),
        legend.box.background=element_rect(color="grey75", size=1)) +
  scale_fill_discrete(name="Gender") 
  ggsave(filename="PATH TO SAVE THE PLOT")
## 
## # Now call back the plot
## background <- image_read("READ THE SAVED PLOT")
## 
## # And bring in a logo
## logo_raw <- image_read("https://media.giphy.com/media/3og0ILdD4AWjibwIFO/giphy.gif")
## 
## # Combine and flatten frames
## frames <- image_composite(background, logo_raw, offset="+1100+275")
## 
## # Turn frames into animation
## animation <- image_animate(frames, fps=10, optimize=TRUE)
## print(animation)


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Who are the tallest characters in the Star Wars movies?
## starwars1 <- starwars_data %>%
##   drop_na(height) %>%
##   select(name, height) %>%
##   arrange(desc(height))
## 
## rbind(head(starwars1, n=10), tail(starwars1, n=10)) %>%
##   ggplot(aes(x=reorder(name, -height), y=height)) +
##   geom_bar(stat="identity", aes(fill=height), colour="black", show.legend=FALSE) +
##   scale_fill_gradient(low="darkolivegreen1", high="darkolivegreen4") +
##   geom_label(aes(label=height)) +
##   labs(title="Star Wars characters",
##        subtitle="Who are the tallest and shortest characters in the Star Wars movies?",
##        caption="Reference: https://www.deviantart.com/pxlflx/art/Yoda-Empire-577027799",
##        y="Height (cm)") +
##   theme_light() +
##   theme(axis.text.x=element_text(angle=45, hjust=1),
##         axis.title.x=element_blank(),
##         plot.title=element_text(size=15, face="bold"),
##         axis.title=element_text(size=12),
##         axis.line=element_line(size=1.01, color="grey35")) +
##   geom_vline(xintercept=10.5, linetype="dashed", color="red") +
##   ylim(0, 400) +
##   annotate("text", x=5.5, y=370, label="Top 10 tallest characters", color="red") +
##   annotate("text", x=15.5, y=370, label="Top 10 shortest characters", color="red") +
##   annotate(geom="curve", xend=19, yend=170, x=20, y=82,
##            curvature=0.3, arrow=arrow(length=unit(2, "mm"))) +
##   annotate("text", x=16, y=200, label='"Size matters not. Look at me.',
##            size=3, fontface="italic") +
##   annotate("text", x=16, y=185, label='Judge me by my size, do you? Hmm? Hmm"',
##            size=3, fontface="italic")
## 
## # Image in the visualization
## image <- image_read("PATH TO THE IMAGE")
## grid.raster(image, x=0.785, y=0.68, height=0.17)


## ----fig.align='center', message=FALSE, warning=FALSE----
# Mean height by homeworld
starwars2 <- starwars_data %>%
  group_by(homeworld) %>%
  summarise(height=round(mean(height), 1)) %>%
  arrange(desc(height)) %>%
  na.omit(height)

rbind(head(starwars2, n=10), tail(starwars2, n=10)) %>%
  ggplot(aes(x=reorder(homeworld, -height), y=height)) +
  geom_bar(stat="identity", aes(fill=height), colour="black", show.legend=FALSE) +
  scale_fill_gradient(low="darkolivegreen1", high="darkolivegreen4") +
  geom_label(aes(label=height), size=3) +
  labs(title="Star Wars characters",
       subtitle="Mean height by homeworld",
       y="Mean height (cm)") +
  theme_light() +
  theme(axis.text.x=element_text(angle=45, hjust=1),
        axis.title.x=element_blank(),
        plot.title=element_text(size=15, face="bold"),
        axis.title=element_text(size=12),
        axis.line=element_line(size=1.01, color="grey35")) +
  geom_vline(xintercept=10.5, linetype="dashed", color="red") +
  ylim(0, 335) +
  annotate("text", x=6, y=310, label="Top 10 tallest homeworlds", color="red") +
  annotate("text", x=15.5, y=310, label="Top 10 shortest homeworlds", color="red")


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Mean height by species
## starwars3 <- starwars_data %>%
##   group_by(species) %>%
##   summarise(height=round(mean(height), 1)) %>%
##   arrange(desc(height)) %>%
##   na.omit(height)
## 
## rbind(head(starwars3, n=10), tail(starwars3, n=10)) %>%
##   ggplot(aes(x=reorder(species, -height), y=height)) +
##   geom_bar(stat="identity", aes(fill=height), colour="black", show.legend=FALSE) +
##   scale_fill_gradient(low="darkolivegreen1", high="darkolivegreen4") +
##   geom_label(aes(label=height), size=3) +
##   labs(title="Star Wars characters",
##        subtitle="Mean height by species",
##        caption="Reference: http://img1.joyreactor.com/pics/post/StarWars-fandoms-pixel-art-yoda-3216663.png",
##        y="Mean height (cm)") +
##   theme_light() +
##   theme(axis.text.x=element_text(angle=45, hjust=1),
##         axis.title.x=element_blank(),
##         plot.title=element_text(size=15, face="bold"),
##         axis.title=element_text(size=12),
##         axis.line=element_line(size=1.01, color="grey35")) +
##   geom_vline(xintercept=10.5, linetype="dashed", color="red") +
##   ylim(0, 345) +
##   annotate("text", x=6, y=320, label="Top 10 tallest species", color="red") +
##   annotate("text", x=16, y=320, label="Top 10 shortest species", color="red")
## 
## # Images in the visualization
## image <- image_read("PATH TO THE IMAGE")
## grid.raster(image, x=0.88, y=0.46, height=0.15)
## 
## image <- image_read("PATH TO THE IMAGE")
## grid.raster(image, x=0.155, y=0.73, height=0.15)


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Density plot of character weights
## starwars_data %>%
##   ggplot(aes(x=mass)) +
##   geom_density(alpha=0.5, fill="mistyrose1", size=0.7) +
##   labs(title="Star Wars characters",
##        subtitle="Density plot of character weights",
##        caption="Reference: http://img1.joyreactor.com/pics/post/StarWars-fandoms-pixel-art-yoda-3216663.png",
##        x="Weight (kg)", y="Density") +
##   theme_light() +
##   annotate(geom="curve", x=1200, y=0.005, xend=1350, yend=0.0015,
##            curvature=-0.3, arrow=arrow(length=unit(2, "mm"))) +
##   theme(plot.title=element_text(size=15, face="bold"),
##         axis.title=element_text(size=12),
##         axis.line=element_line(size=1.01, color="grey35")) +
##   annotate("text", x=1075, y=0.005, label="Jabba the Hutt") +
##   annotate("text", x=1075, y=0.004, label='"You weak minded fool!', size=3, fontface="italic") +
##   annotate("text", x=1075, y=0.0032, label='He’s using an old data scientist trick.',
##            size=3,fontface="italic") +
##   annotate("text", x=1075, y=0.0024, label='I am not that fat!"', size=3, fontface="italic")
## 
## # Image in the visualization
## image <- image_read("PATH TO THE IMAGE")
## grid.raster(image, x=0.778, y=0.43, height=0.17)


## ----fig.align='center', message=FALSE, warning=FALSE----
# Density plot of character weights (without Jabba the Hutt)
starwars_data %>%
  mutate_at(vars(gender), factor) %>%
  mutate(gender=recode(gender, female="Female",
                       male="Male",
                       hermaphrodite="Hermaphrodite",
                       none="None")) %>%
  replace_na(list(gender="None"))  %>%
  filter(mass<1000) %>%
  ggplot(aes(x=mass, fill=gender)) +
  geom_density(alpha=0.5, size=0.7) +
  labs(title="Star Wars characters",
       subtitle="Density plor of character weights (without Jabba the Hutt)",
       x="Weight (kg)", y="Density") +
  theme_light() +
  theme(legend.position="bottom",
        legend.title=element_text(face="bold"),
        plot.title=element_text(size=15, face="bold"),
        axis.title=element_text(size=12),
        axis.line=element_line(size=1.01, color="grey35"),
        legend.box.background=element_rect(color="grey75", size=1)) +
  scale_fill_discrete(name="Gender")


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Who are the heaviest and least heavy characters in the Star Wars movies?
## starwars4 <- starwars_data %>%
##   drop_na(mass) %>%
##   select(name, mass) %>%
##   arrange(desc(mass)) %>%
##   filter(name!="Jabba Desilijic Tiure")
## 
## rbind(head(starwars4, n=10), tail(starwars4, n=10)) %>%
##   ggplot(aes(x=reorder(name, -mass), y=mass)) +
##   geom_bar(stat="identity", aes(fill=mass), colour="black", show.legend=FALSE) +
##   scale_fill_gradient(low="mistyrose", high="mistyrose4") +
##   geom_label(aes(label=mass)) +
##   labs(title="Star Wars characters",
##        subtitle="Who are the heaviest and least heavy characters in the Star Wars movies?",
##        y="Weight (km)") +
##   ylim(0, 250) +
##   theme_light() +
##   theme(axis.text.x=element_text(angle=45, hjust=1),
##         axis.title.x=element_blank(),
##         plot.title=element_text(size=15, face="bold"),
##         axis.title=element_text(size=12),
##         axis.line=element_line(size=1.01, color="grey35")) +
##   geom_vline(xintercept=10.5, linetype="dashed", color="red") +
##   annotate("text", x=5.5, y=250, label="Top 10 heaviest characters", color="red") +
##   annotate("text", x=15.5, y=250, label="Top 10 least heavy characters", color="red") +
##   annotate(geom="curve", x=3, y=150, xend=5, yend=175,
##            curvature=-0.3, arrow=arrow(length=unit(2, "mm"))) +
##   annotate("text", x=10.8, y=200, label='"Come to the dark side...', size=4, fontface="italic") +
##   annotate("text", x=10.8, y=185, label='we have cookies"', size=4, fontface="italic")
## 
## # Image in the visualization
## image <- image_read("PATH TO THE IMAGE")
## grid.raster(image, x=0.35, y=0.7, height=0.22)


## ----fig.align='center', message=FALSE, warning=FALSE----
# Mean weight by homeworld
starwars5 <- starwars_data %>%
  group_by(homeworld) %>%
  summarise(weight=round(mean(mass), 1)) %>%
  arrange(desc(weight)) %>%
  na.omit(weight) %>%
  filter(homeworld!="Nal Hutta")

rbind(head(starwars5, n=10), tail(starwars5, n=10)) %>%
  ggplot(aes(x=reorder(homeworld, -weight), y=weight)) +
  geom_bar(stat="identity", aes(fill=weight), colour="black", show.legend=FALSE) +
  scale_fill_gradient(low="mistyrose", high="mistyrose4") +
  geom_label(aes(label=weight), size=3) +
  labs(title="Star Wars characters",
       subtitle="Mean weight by homeworld",
       y="Mean weight (kg)") +
  theme_light() +
  theme(axis.text.x=element_text(angle=45, hjust=1),
        axis.title.x=element_blank(),
        plot.title=element_text(size=15, face="bold"),
        axis.title=element_text(size=12),
        axis.line=element_line(size=1.01, color="grey35")) +
  geom_vline(xintercept=10.5, linetype="dashed", color="red") +
  annotate("text", x=6, y=175, label="Top 10 heaviest homeworlds", color="red") +
  annotate("text", x=15.5, y=175, label="Top 10 least heavy homeworlds", color="red")


## ----fig.align='center', message=FALSE, warning=FALSE----
# Mean weight by species
starwars6 <- starwars_data %>%
  group_by(species) %>%
  summarise(weight=round(mean(mass), 1)) %>%
  arrange(desc(weight)) %>%
  na.omit(weight) %>%
  filter(species!="Hutt")

rbind(head(starwars6, n=10), tail(starwars6, n=10)) %>%
  ggplot(aes(x=reorder(species, -weight), y=weight)) +
  geom_bar(stat="identity", aes(fill=weight), colour="black", show.legend=FALSE) +
  scale_fill_gradient(low="mistyrose", high="mistyrose4") +
  geom_label(aes(label=weight), size=3) +
  labs(title="Star Wars characters",
       subtitle="Mean weight by species",
       y="Mean weight (kg)") +
  theme_light() +
  theme(axis.text.x=element_text(angle=45, hjust=1),
        axis.title.x=element_blank(),
        plot.title=element_text(size=15, face="bold"),
        axis.title=element_text(size=12),
        axis.line=element_line(size=1.01, color="grey35")) +
  geom_vline(xintercept=10.5, linetype="dashed", color="red") +
  annotate("text", x=6, y=175, label="Top 10 heaviest species", color="red") +
  annotate("text", x=15.5, y=175, label="Top 10 least heavy species", color="red")


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Correlation between height and weight
## starwars_data %>%
##   ggplot(aes(x=height, y=mass)) +
##   geom_point() +
##   geom_smooth(method="lm", se=TRUE) +
##   labs(title="Star Wars characters",
##        subtitle="Correlation between height and weight",
##        caption="Reference: http://img1.joyreactor.com/pics/post/StarWars-fandoms-pixel-art-yoda-3216663.png",
##        x="Height (cm)", y="Weight (kg)") +
##   theme_light() +
##   theme(plot.title=element_text(size=15, face="bold"),
##         axis.title=element_text(size=12),
##         axis.line=element_line(size=1.01, color="grey35")) +
##   annotate("text", x=220, y=1000, label="Jabba the Hutt") +
##   annotate("text", x=220, y=935, label='"Are you calling me fat again?', fontface="italic",
##            size=3) +
##   annotate("text", x=220, y=885, label='There will be no bargain, young data scientist.',
##            fontface="italic", size=3) +
##   annotate("text", x=220, y=835, label='I will not upvote this notebook."', fontface="italic",
##            size=3) +
##   annotate(geom="curve", x=200, y=1000, xend=175, yend=1320,
##            curvature=-0.3, arrow=arrow(length=unit(2, "mm")))
## 
## # Image in the visualization
## image <- image_read("PATH TO THE IMAGE")
## grid.raster(image, x=0.77, y=0.775, height=0.17)


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Correlation between height and weight (without Jabba the Hutt)
## starwars_data %>%
##   filter(mass<1000) %>%
##   ggplot(aes(x=height, y=mass)) +
##   geom_point() +
##   geom_smooth(method="lm", se=TRUE) +
##   labs(title="Star Wars characters",
##        subtitle="Correlation between height and weight (without Jabba the Hutt)",
##        caption="Reference: http://img1.joyreactor.com/pics/post/StarWars-fandoms-pixel-art-yoda-3216663.png",
##        x="Height (cm)", y="Weight (kg)") +
##   theme_light() +
##   theme(plot.title=element_text(size=15, face="bold"),
##         axis.title=element_text(size=12),
##         axis.line=element_line(size=1.01, color="grey35")) +
##   annotate("text", x=125, y=86, label="Jabba the Hutt") +
##   annotate("text", x=125, y=79, label='"Just put me around here,', fontface="italic",
##            size=3) +
##   annotate("text", x=125, y=73, label='you Jedi scum!"', fontface="italic",
##            size=3)
## 
## # Image in the visualization
## image <- image_read("PATH TO THE IMAGE")
## grid.raster(image, x=0.415, y=0.635, height=0.17)


## ----fig.align='center', message=FALSE, warning=FALSE----
# Correlation between height and weight (with labels)
starwars_data %>%
  filter(mass<1000) %>%
  ggplot(aes(x=height, y=mass)) +
  geom_smooth(method="lm", se=TRUE) +
  geom_text(check_overlap=TRUE, aes(label=name), size=2.5) +
  labs(title="Star Wars characters",
       subtitle="Correlation between height and weight (with labels)",
       x="Height (cm)", y="Weight (kg)") +
  theme_light() +
  theme(plot.title=element_text(size=15, face="bold"),
        axis.title=element_text(size=12),
        axis.line=element_line(size=1.01, color="grey35")) 


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Pie chart - Gender (%)
## starwars_data %>%
##   mutate(gender=recode(gender, female="Female",
##                        male="Male",
##                        hermaphrodite="Hermaphrodite",
##                        none="None")) %>%
##   replace_na(list(gender="None"))  %>%
##   count(gender) %>%
##   mutate(Percentage=paste0(round(n/sum(n)*100, 2), "%")) %>%
##   ggplot(aes(x=factor(1), y=Percentage, fill=gender)) +
##   geom_bar(stat="identity", width=1, size=1, color="white") +
##   geom_text(aes(label=Percentage), position=position_stack(vjust=0.5)) +
##   coord_polar(theta="y") +
##   labs(title="Star Wars characters",
##        subtitle="Gender (%)",
##        caption="Reference: https://media.giphy.com/media/s79yB2EkYahfG/giphy.gif") +
##   theme_void() +
##   theme(legend.position="right",
##         legend.title=element_text(face="bold"),
##         plot.title=element_text(size=15, face="bold"),
##         legend.box.background=element_rect(color="grey75", size=1)) +
##   scale_fill_discrete(name="Gender") +
##   ggsave(filename="PATH TO SAVE THE PLOT")
## 
## # Now call back the plot
## background <- image_read("READ THE SAVED PLOT")
## 
## # And bring in a logo
## logo_raw <- image_read("https://media.giphy.com/media/s79yB2EkYahfG/giphy.gif")
## 
## # Combine and flatten frames
## frames <- image_composite(background, logo_raw, offset="+700+1500")
## 
## # Turn frames into animation
## animation <- image_animate(frames, fps=10, optimize=TRUE)
## print(animation)


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Gender by species (%)
## starwars_data %>%
##   filter(!is.na(species)) %>%
##   mutate(gender=recode(gender, female="Female",
##                        male="Male",
##                        hermaphrodite="Hermaphrodite",
##                        none="None")) %>%
##   replace_na(list(gender="None"))  %>%
##   count(gender, species) %>%
##   ggplot(aes(x=reorder(species, n, sum), y=n, fill=gender)) +
##   geom_col(colour="black", position="fill") +
##   scale_y_continuous(labels=scales::percent) +
##   labs(subtitle="Gender by species (%)", title="Star Wars characters") +
##   theme_light() +
##   theme(legend.position="bottom",
##         legend.title=element_text(face="bold"),
##         plot.title=element_text(size=15, face="bold"),
##         axis.title=element_text(size=12),
##         axis.line=element_line(size=1.01, color="grey35"),
##         legend.box.background=element_rect(color="grey75", size=1),
##         axis.title.y=element_blank(),
##         axis.title.x=element_blank(),
##         axis.text.x=element_text(angle=45, hjust=1)) +
##   scale_fill_discrete(name="Gender")  +
##   ggsave(filename="PATH TO SAVE THE PLOT")
## 
## # Now call back the plot
## background <- image_read("READ THE SAVED PLOT")
## 
## # And bring in a logo
## logo_raw <- image_read("https://media.giphy.com/media/JrMyqcNznjfx8g5sr2/giphy.gif")
## 
## # Combine and flatten frames
## frames <- image_composite(background, logo_raw, offset="+300+1300")
## 
## # Turn frames into animation
## animation <- image_animate(frames, fps=10, optimize=TRUE)
## print(animation)


## ----fig.align='center', message=FALSE, warning=FALSE----
# Gender by homeworld (%)
starwars_data %>%
  filter(!is.na(homeworld)) %>%
  mutate(gender=recode(gender, female="Female",
                       male="Male",
                       hermaphrodite="Hermaphrodite",
                       none="None")) %>%
  replace_na(list(gender="None"))  %>%
  count(gender, homeworld) %>% 
  ggplot(aes(x=reorder(homeworld, n, sum), y=n, fill=gender)) + 
  geom_col(colour="black", position="fill") + 
  scale_y_continuous(labels=scales::percent) +
  labs(subtitle="Gender by homeworld (%)", title="Star Wars characters") +
  theme_light() +
  theme(legend.position="bottom",
        legend.title=element_text(face="bold"),
        plot.title=element_text(size=15, face="bold"),
        axis.title=element_text(size=12),
        axis.line=element_line(size=1.01, color="grey35"),
        legend.box.background=element_rect(color="grey75", size=1),
        axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_text(angle=45, hjust=1)) +
  scale_fill_discrete(name="Gender")


## ----eval=FALSE, fig.align='center', message=FALSE, warning=FALSE----
## # Empty vector
## appearances <- vector()
## 
## # Character appearances
## for(i in 1:nrow(starwars_data)){
## 
##   appearances[i] <- length(starwars_data$films[[i]])
## 
## }
## 
## # New appearances column added to the data set
## starwars_data2 <- cbind(starwars_data, appearances)
## 
## # Visualization
## starwars_data2 %>%
##   select(name, appearances) %>%
##   arrange(desc(appearances)) %>%
##   head(n=20) %>%
##   ggplot(aes(x=reorder(name, appearances), y=appearances)) +
##   geom_bar(stat="identity", aes(fill=appearances), colour="black", show.legend=FALSE) +
##   scale_fill_gradient(low="lavenderblush1", high="lavenderblush3") +
##   geom_label(aes(label=appearances)) +
##   labs(title="Star Wars characters",
##        subtitle="Characters with more appearances",
##        y="Appearances") +
##   coord_flip() +
##   theme_light() +
##   theme(axis.title.y=element_blank(),
##         plot.title=element_text(size=15, face="bold"),
##         axis.title=element_text(size=12),
##         axis.line=element_line(size=1.01, color="grey35")) +
##   ggsave(filename="PATH TO SAVE THE PLOT")
## 
## # Now call back the plot
## background <- image_read("READ THE SAVED PLOT")
## 
## # And bring in a logo
## logo_raw <- image_read("https://media.giphy.com/media/fxIGoB2RfCkNWLImzZ/giphy.gif")
## 
## # Combine and flatten frames
## frames <- image_composite(background, logo_raw, offset="+1600+1600")
## 
## # Turn frames into animation
## animation <- image_animate(frames, fps=10, optimize=TRUE)
## print(animation)

