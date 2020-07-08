
# libraries & setup -------------------------------------------------------

library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(scales)
library(DT)

workers <- read_csv("data/jobs_gender.csv")

yellow_theme <- theme(
  panel.background = element_rect(fill="lightgrey"),
  plot.background = element_rect(fill="lightyellow"),
  panel.grid.minor.x = element_blank(),
  panel.grid.major.x = element_blank(),
  panel.grid.minor.y = element_blank(),
  text = element_text(color="red"),
  axis.text = element_text(color="blue")
  )


# data tidying ------------------------------------------------------------

workers <- workers %>% 
  drop_na(total_earnings_male, total_earnings_female) %>% 
  mutate(percent_male = 100 - percent_female)