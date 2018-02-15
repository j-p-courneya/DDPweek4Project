##Data Wrangling of the Maryland Manure Dataset

##Load libraries to wrangle data

library(dplyr)
library(tidyr)
library(data.table)

## Data Selection and Data Information
##
##This data was chosen because it was openly available from 
##(https://data.maryland.gov/Agriculture/MDAg-Manure-Transport-Tons/b6bj-ur57), 
##and interesting.
##The data is of Manure Transport cost-shared tonnage for fiscal years 2005-2017, 
##by county. Tonnage transported for non-land application is shown as "alternative use" 
##(e.g. Perdue AgriRecycle). The amount of manure is recorded per county to determine what 
##fraction of the state budget goes to covering the cost of transporting manure per county
##in Maryland and from what types of animals. 

##Data Download 
manureDataURL <- "https://data.maryland.gov/api/views/b6bj-ur57/rows.csv?accessType=DOWNLOAD"
manureDataDownload <-  fread(manureDataURL)
##Confirm the data is a data.frame
class(manureDataDownload)
##Subset variables for analysis
manureDataTrim <- select(manureDataDownload,'Fiscal Year', 'Extent', 'Animal Primary Type')
##Rename Animal.Primary.Type
manureDataTrim<- rename(manureDataTrim, Animal = 'Animal Primary Type')
manureDataTrim<- rename(manureDataTrim, Year = 'Fiscal Year')
##Group the data to calculate the sum of manure for each animal per year
manureLong <- manureDataTrim %>%
            group_by(Year, Animal) %>%
            summarise(Extent = sum(Extent))
##create a spread dataset with variables of animal(s) and year with amount of manure 
##per year as observations. This will be the source data for the shinyApp 
manureDF <- spread(manureLong, Animal, Extent)
##create a matrix which will be used for the ShinyApp
manureMatrix <- as.matrix(manureDF[2:5])
rownames(manureMatrix) <- manureDF$Year
colnames(manureMatrix) <- colnames(manureDF[2:5])
##Save the data as Rds for use in the app
saveRDS(manureMatrix, file = "../week4ProjectRepo/week4ShinyAppJPC/data/MD_manureData2.rds")
