### Star wars 1 Análisis Exploratorio de Datos (EDA)

## Código re-elaborado por Toaki Hoz Canabal con base en title: "**EDA - Star Wars data set**" de author: "Xavier Vivancos García"

## Análisis cuantitativo 1 del dataset dplyr::starwars

# In this kernel we are going to do an exploratory data analysis using a 
# [Star Wars data set](https://rdrr.io/cran/dplyr/man/starwars.html). 
# This data comes from [SWAPI](https://swapi.co/), the Star Wars API. I've tried to include some original details into the visualizations, like GIFs or images. I hope you like it!

# knitr::purl("02_codigo/1. star wars_cuantitativo/eda-star-wars-data-set.Rmd")#--> Este funciona para pasar de rmarckdown a script

# setup------
Sys.setlocale("LC_ALL", "es_ES.UTF-8") # Cambiar locale para prevenir problemas con caracteres especiales

options(scipen=999) #para prvenir notación científica


# cargamos paquetes -------------------------------------------------------

if(!require('pacman')) install.packages('pacman')

pacman::p_load(grid, lubridate, tidyverse, janitor, scales)

# Cargamos bases de datos ----------------------------------------------
starwars_data <- starwars


### Analizamos dataset
summary(starwars_data)
glimpse(starwars_data)
str(starwars_data)

### Empezamos con el género y sexo------------------
starwars_data %>%
  replace_na(list(gender = "none",
                  sex = "none")) %>% 
  ggplot(aes(x=height, fill=gender)) +
  geom_density(alpha=0.5, size=0.7) +
  scale_fill_manual(name = "Género",
                    labels = c("Femenino", "Masculino", "Ninguno"),
                    values = c("orange", "green", "black")) +
  labs(title="Personajes de Star wars",
       subtitle="Grafica de densidad de la altura de los personajes",
       x="Altura (cm)", y="Desnsidad") +
  theme_light() +
  theme(legend.position="bottom",
        legend.title=element_text(face="bold"),
        plot.title=element_text(size=15, face="bold",
                                hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title=element_text(size=12),
        axis.line=element_line(size=1.01, color="grey35"),
        legend.box.background=element_rect(color="grey75", size=1))

