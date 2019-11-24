# Young Kyu Shin, November 24, 2019 data for exercise 5: Dimensionality reduction techniques #

## Reading the datasets ##

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


## Exploring the datasets ##

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)


## Renaming the variables ##

colnames(hd)[1] <- "hdi_rank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "hdi"
colnames(hd)[4] <- "life_expectancy"
colnames(hd)[5] <- "schooling_yrs"
colnames(hd)[6] <- "mean_schooling_yrs"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "rank_GNI-HDI"

colnames(hd)

colnames(gii)[1] <- "gii_rank"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "gii"
colnames(gii)[4] <- "maternal_mortal"
colnames(gii)[5] <- "adol_birthrate"
colnames(gii)[6] <- "parliamentF"
colnames(gii)[7] <- "edu2F"
colnames(gii)[8] <- "edu2M"
colnames(gii)[9] <- "labourF"
colnames(gii)[10] <- "labourM"

colnames(gii)


## Mutating and creating variables ##

library(dplyr)

gii <- mutate(gii, edu2F_M = edu2F / edu2M)

gii <- mutate(gii, labourF_M = labourF / labourM)


## Joining the datasets by the variable country ##

join_by <- c("country")
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))
colnames(human)
glimpse(human)


## Saving ##

write.table(human)
write.csv(human, "C:\\Users\\Young Shin\\Documents\\IODS-project\\data\\human.csv")



