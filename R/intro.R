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
<<<<<<< HEAD
head(da1, 15)
# Create the cumulative wrs (to represent a stock). this comes from 
# https://stackoverflow.com/questions/34756081/apply-function-for-each-subgroup
# split the data into la_code groups
da1_temp <- split(da1$wrs, f = da1$la_code)
# apply the cumulative sum
results <- lapply(da1_temp, function(x) cumsum(x))
# push the results back to the dataframe.
da1$cwrs <- unlist(results)
#=======================================
# Create the additional variables (from BFM_Code.do
da1$adult_pop <- da1$totalpop-da1$pop014
da1$asylum_pop <- (da1$dispsMF+da1$subsMF)/da1$adult_pop
da1$asylum_dispersal_pop <- da1$dispsMF/da1$adult_pop
da1$asylum_pop_males <- da1$dispsM+da1$subsM/da1$adult_pop
da1$asylum_pop_females <- da1$asylum_pop-da1$asylum_pop_males
da1$asylum_disp_males <- da1$dispsM/da1$adult_pop
da1$asylum_disp_females <- (da1$dispsMF-da1$dispsM)/da1$adult_pop
da1$a8_pop <- da1$cwrs/da1$adult_pop
da1$young_share <- da1$pop1524/da1$adult_pop
da1$benefit_claimants <- da1$benclaim/da1$adult_pop
da1$lnpop <- log(da1$adult_pop)
da1$a8_iv <- da1$SP_A8/da1$adult_pop
da1$viol_crime_rate <- da1$viol/da1$adult_pop
da1$prop_crime <- da1$burg+da1$rob+da1$tomv+da1$tfmv
da1$prop_crime_rate <- da1$prop_crime/da1$adult_pop
da1$total_crime_rate <- (da1$viol+da1$prop_crime)/da1$adult_pop
#===========================================
# Also need to estimate a time trend and the mean population age by panel
# Estimate the basic model 
eq1 <- plm(diff(viol_crime_rate) ~ diff(asylum_pop) + diff(a8_pop) + diff(lnpop), da1p, 
           model = "within") 
eq2 <- plm(diff(prop_crime_rate) ~ diff(asylum_pop) + diff(a8_pop) + diff(lnpop), da1p, 
           model = "within") 
summary(eq1)          
summary(eq2)          
# need to add the control variables and the time trend. 

#==============
=======
head(da1, n = 10)
da1$cwrs <- 0
ifelse(da1$year == 1994, da1$cwrs <- da1$wrs, da1$cwrs <- da1$wrs + lag(da1$cwrs, -1))
>>>>>>> origin/master
da2 <- read.dta('./Data/police_arrests.dta')
head(da2)
# The description of the data is in ./Data/README.rtf
da1p <- pdata.frame(da1, index = c('la_code', 'year'), drop.index = TRUE, row.names = TRUE)
head(da1p)
<<<<<<< HEAD



head(da1, 20)


=======
summary(da1p)
# To create the matrix that will hold the wrs data prior to cumulating. 
tempmatrix <- t(as.matrix(da1p$wrs))
head(tempmatrix)
>>>>>>> origin/master
