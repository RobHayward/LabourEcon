# Basic work on the data
#install.package('foreign')
# There is some discussion of how to use it 
# https://www.statmethods.net/input/importingdata.html
requuire('foreign')
da1 <- read.dta('./Data/crime_immig.dta')
head(da1)
da2 <- read.dta('./Data/police_arrests.dta')
head(da2)
# The description of the data is in ./Data/README.rtf
