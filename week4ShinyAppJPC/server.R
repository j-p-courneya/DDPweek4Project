library(shiny)

# Define server logic required to make a slider
shinyServer(function(input, output) {
   
  output$text1 = renderText(input$slider2)
    
})