### Star wars 1

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




