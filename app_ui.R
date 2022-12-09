##1. packages
library("shiny")
library("dplyr")
library("leaflet")
library("plotly")
library("ggplot2")
##2. load data
getwd()
data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

##3. ui.R----
ui <- navbarPage("Ferryn Drake Co2 Emissions",
                 tabPanel("Introduction", uiOutput('page1')),
                 tabPanel("Interactive Visualization", uiOutput('page2'))
)

