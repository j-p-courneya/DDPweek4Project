library(shiny)
manure <- readRDS("data/MD_ManureData2.rds")

# Define UI for application that draws a histogram
shinyUI(fluidPage(    
    
    # Give the page a title
    titlePanel("Tons of Manure transported per fiscal year by animal"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("animal", "Animal:", 
                    choices=colnames(manure)),
        hr(),
        helpText("Data from MDAgriculture - Manure Transport Tons.")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("manurePlot")  
      )
      
    )
  )
)  