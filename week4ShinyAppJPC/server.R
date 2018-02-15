library(shiny)
library(ggplot2)
manure <- readRDS("data/MD_ManureData2.rds")

# Define server logic required to make a slider
shinyServer(function(input, output) {
  selectedData <- reactive({
    manure
  }) 
  output$manurePlot = renderPlot({
      
    barplot(manure[,input$animal],
          main=input$Animal,
          ylab="Tons of Manure",
          xlab="Year")
})
})