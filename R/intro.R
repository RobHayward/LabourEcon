# Basic work on the data
#install.packages('foreign')
#install.packages('plm')
# There is some discussion of how to use it 
# https://www.statmethods.net/input/importingdata.html
# to download stata files
require('foreign')
# to use panel methods
require('plm')
da1 <- read.dta('./Data/crime_immig.dta')
head(da1, n = 10)
da1$cwrs <- 0
ifelse(da1$year == 1994, da1$cwrs <- da1$wrs, da1$cwrs <- da1$wrs + lag(da1$cwrs, -1))
da2 <- read.dta('./Data/police_arrests.dta')
head(da2)
# The description of the data is in ./Data/README.rtf
da1p <- pdata.frame(da1, index = c('la_code', 'year'), drop.index = TRUE, row.names = TRUE)
head(da1p)
summary(da1p)
# To create the matrix that will hold the wrs data prior to cumulating. 
tempmatrix <- t(as.matrix(da1p$wrs))
head(tempmatrix)
