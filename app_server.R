
server <- function(input, output) {
  
  
  #----------page 1----------------- 
  
  
  ##Which country has the highest co2_per_capita in 2021?
  country_highest_co2_capita <- data %>%
    filter(year == max(year, na.rm = TRUE)) %>%
    filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>%
    pull(country, co2_per_capita)
  
  
  #make the first ui for component 1
  output$page1 <- renderUI({
    fluidPage(
      titlePanel("Introduction: CO2 Emissions"),  # Add a title panel
      h2("My three chosen variables"),
      p("The first variable I chose to analyze was what country had the highest co2
        per capita in the year 2021. I chose to analyze this varaible because I believe that 
        it is important to take note of which country is currently contributing the most
        to Co2 emmissions. After writing the code to find the value, I found that Qatar
        had the most Co2 emissions per capita out of every country in the year 2021."),
      mainPanel( # Inside the sidebarLayout, add a mainPanel
        p("The second variable that I chose to analyze is the increase in global CO2 
          emmisions overtime. I believe that this an important varaible to analyze because
          looking at overall and generalized data about C02 emmisions can bring about theories
          involving climate change. By looking at the graph below, it is clear that CO2 
          emissions have drastically increased overtime"),
        plotOutput("plot1"),
        p("The last variable that I wanted to look at was the mean, median, max, standard deviation, 
        the minimum of co2 emissions and the maximum. I chose these variables because I again
        I believe they are good summarizing varaibles for analyzing complex and long data. Below is
        table analyzing those numbers."),
        tableOutput("table1")
        
      )  
    )
  })
  
  #make a plot
  output$plot1 <- renderPlot(
    ggplot(data, aes(x=year, y= co2, fill=country), fill="black")+
      geom_col()+
      theme_bw()+
      ggtitle("Global CO2 emissions over time")+
      theme(legend.position = "none")
  )
  #make a table 
  output$table1 <- renderTable(data%>%
                                 filter(year==2021) %>%
                                 summarise("Mean"=mean(co2, na.rm=TRUE),
                                           "Median"=median(co2,  na.rm=TRUE),
                                           "SD"=sd(co2,  na.rm=TRUE),
                                           "Min"=min(co2,  na.rm=TRUE),
                                           "Max"=max(co2,  na.rm=TRUE)))
  
  #----------page 2-----------------    
  
  output$page2 <- renderUI({  
    fluidPage(
      titlePanel("CO2 Emissions Interactive Visualization"),
      p("What can be learned from the interactive visualization and
           the multiple widgets is the Co2 Emissions over time per country per varaible
           For example, you could research the emissions over time in Canada based on gas CO2 emissions
           or the cummulative oil usage over time in Canada. This visualization allows the user
           to analyze specific varibale based on specific countries. And for visual purpose,
           I also added the option to choose which color you would like to view the data in."),
      sidebarLayout( 
        sidebarPanel(
          selectInput(inputId = "country", 
                      label = "1. Select Country", 
                      choices = unique(data$country), selected = "Botswana"),
          selectInput(inputId = "variable",
                      label = "2. Select Variable",
                      choices=unique(colnames(data)), selected="co2"),
          selectInput(inputId = "color", 
                      label = "3. Select barplot color", 
                      choices = c("blue","green","red","purple","yellow"), selected = "blue")),
        mainPanel( # Inside the sidebarLayout, add a mainPanel
          plotOutput("plot2")),
        
      )
    )
  })  
  
  #make a plot
  
  
  output$plot2 <- renderPlot({
    
    ggplot(data)+
      geom_col(data=data[data$country==input$country,], 
               aes(x=year, y=data[data$country==input$country,][[input$variable]]),fill=input$color)+
      theme_bw()+
      ggtitle("Global CO2 emissions over time")+
      theme(legend.position = "none")+
      labs(y=input$variable)
  })  
  
  
}

