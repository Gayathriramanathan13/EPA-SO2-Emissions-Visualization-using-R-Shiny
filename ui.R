library(shiny)
library(shinydashboard)
dashboardPage(
  dashboardHeader(title = "SO2 Emission Trends", titleWidth = 250),
  dashboardSidebar(
    width = 250,
    sidebarMenu(id="menu1",
      menuItem("State by State SO2 Emissions", tabName = "statebystate", icon = icon("map")),
      conditionalPanel(
      condition="input.menu1=='statebystate'",
      radioButtons("col","Switch Plot",
                   choices = c("Chloropleth Map", "Bar Chart"),
                   selected = "Chloropleth Map")
    )
    #menuItem("So2 Emission Trends", tabName = "trends", icon = icon("line-chart"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName="statebystate",
        fluidPage(
        conditionalPanel(
        condition = "input.col == 'Chloropleth Map'",
        box(
          title = "Chloropleth Map of SO2 Emissions by Year"
          ,width = 12
          ,status = "primary"
          ,solidHeader = TRUE
          ,collapsible = TRUE
          ,plotlyOutput("stateEmission")
          ,radioButtons("radio" 
                        ,"Year" 
                        ,choices =as.character(unique(state.years.so2.tdy$Year)),
                        inline = TRUE)
        )),
        conditionalPanel(
          condition = "input.col == 'Bar Chart'", 
          box(
            title = "Bar Chart of So2 Emissions by State"
            ,width = 12
            ,status = "primary"
            ,solidHeader = TRUE
            ,collapsible = TRUE
            ,plotlyOutput("stateEmission1")
            ,selectInput("stateselect" 
                          ,"Select States(One or More)" 
                          ,choices =as.character(unique(state.years.so2.tdy$State))
                          ,selected = as.character("IN")
                          ,multiple = TRUE)
            ))
      )
    )
)
)
)