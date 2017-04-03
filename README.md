# EPA-SO2-Emissions-Visualization-using-R-Shiny
A shiny app that visualizes SO2 Emissions in the United States using Data from the EPA

The data used has been uploaded as an .xlsx file to the repo
SOURCE: EPA , catalog.data.gov

It also allows users to visualize a chloropleth map of emissions by year(selected using radio buttons)

The app provides users with the option to visualize a dodge bar chart using ggplot2 by state or states(selected from a dropdown) where each bar represents a year and the Y axis represents the emissions.

Further features and charts to visualize trends and emission rates using scatter plots and line plots to be developed. 

It is advised to download ui.R, server.R and glopbal.R into the same directory to get the "run App" feature in R shiny. Please not that the user should also put the data inside a subdirectory within the same directory named "data".
