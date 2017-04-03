library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(ggplot2)
library(googleVis)
library(xlsx)
library(plotly)


#Start of Server side code
shinyServer(
  function(input, output, session) {
    output$stateEmission<-renderPlotly({
      state.years.so2.tdy$hover <- with(state.years.so2.tdy, paste("State",State, '<br>',
                                                                   "So2 Emissions in Tons",
                                                                   Emission))
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
data <- reactive({
  # filter data according to user input
  plotdata <- state.years.so2.tdy %>%
    as.data.frame() %>%
    filter(
      Year %in% input$radio 
    )
  scalecalc <- plotdata %>%
    group_by(`Year`) %>%
    summarize(value = sum(Emission))
  
  
  scalemax <- max(scalecalc$value)
  scalesteps <- round(scalemax/5, digits = -1)
  
  list(plotdata = plotdata,
       scalemax = scalemax,
       scalesteps = scalesteps
  )
  
})
 plot_geo(data()$plotdata, locationmode = 'USA-states') %>%
  add_trace(
    z = ~Emission,key=~State, text = ~hover, locations = ~State,
    color = ~Emission, colors = 'Purples'
  ) %>%
  colorbar(title = "So2 Emissions in Tons") %>%
  layout(
    title = 'State wise S02 Emission by year<br>(Hover for emission value in tons)',
    geo = g
  )
})
    output$stateEmission1<-renderPlotly({
      data1 <- reactive({
        # filter data according to user input
        plotdata <- state.years.so2.tdy %>%
          as.data.frame() %>%
          filter(
            State %in% input$stateselect
          )
        scalecalc <- plotdata %>%
          group_by(`State`) %>%
          summarize(value = sum(`Emission`))
        
        
        scalemax <- max(scalecalc$value)
        scalesteps <- round(scalemax/5, digits = -1)
        
        list(plotdata = plotdata,
             scalemax = scalemax,
             scalesteps = scalesteps
        )
        
      })
      ggplot(data = data1()$plotdata, 
             aes(x=`State`, y=Emission,
                 fill=factor(`Year`,
                             levels = c("1990","2000","2005","2014")))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Emission") + 
        xlab("State") + theme(legend.position="bottom" 
                               ,plot.title = element_text(size=15, face="bold")) + 
        labs(fill = "Status")
    })
  
})