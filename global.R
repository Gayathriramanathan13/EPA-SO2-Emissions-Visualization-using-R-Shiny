#Code to check if required packages are installed,
#if one or more packages are not installed, they are automatically installed
list.of.packages <- c("ggplot2", "shiny","shinydashboard","dplyr",
                      "tidyr","plotly","googleVis","xlsx")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Loading the libraries
library(googleVis)
library(shiny)
library(shinydashboard)
library(plotly)
library(xlsx)
library(dplyr)
library(tidyr)


#Loading up the data
filename <- file.path("data", "2014_emissions_reductions_so2_data.xlsx")
if (file.exists(filename)) {
  sd0<- read.xlsx(filename, 2, stringsAsFactors = TRUE)
}
filename <- file.path("data", "2014_emissions_reductions_so2_data.xlsx")
if (file.exists(filename)) {
  sd1<- read.xlsx(filename, 1, stringsAsFactors = TRUE)
}
filename <- file.path("data", "2014_emissions_reductions_so2_data.xlsx")
if (file.exists(filename)) {
  sd2<- read.xlsx(filename, 3, stringsAsFactors = TRUE)
}
colnames(sd0)<-c("State","1990","2000","2005","2014")
state.years.so2.tdy <- sd0 %>% 
  gather("Year", "Emission", 2:5)
state.years.so2.tdy<-state.years.so2.tdy[!(state.years.so2.tdy$State=='SO2 values are shown as tons.'),]
state.years.so2.tdy<-state.years.so2.tdy[!(state.years.so2.tdy$State=='Source: EPA, 2016'),]
sd1$NA.<-NULL
sd1<-sd1[!(sd1$year=='SO2 values are shown as millions of tons.'),]
sd1<-sd1[!(sd1$year=='Source: EPA, 2016'),]
