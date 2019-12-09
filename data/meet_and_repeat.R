# Young Kyu Shin, December 9, 2019 data for exercise 6: analysis of longitudianl data #

## Reading the datasets ##

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

library(dplyr)
library(tidyr)

write.table(BPRS)
write.table(RATS)
write.csv(BPRS, file = "C:\\Users\\Young Shin\\Documents\\IODS-project\\data\\bprs.csv")
write.csv(RATS, file = "C:\\Users\\Young Shin\\Documents\\IODS-project\\data\\rats.csv")


## Taking a look at the data sets ##
names(BPRS)
names(RATS)
str(BPRS)
str(RATS)

## Converting categorical variables to factors ##
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)


## Converting to long form and adding week and time variables ##
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,5)))
BPRSL <- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) %>% mutate(weeks = as.integer(substr(weeks,5,5)))


## Checking the variables and structure of the data sets ##
names(BPRSL)
names(RATSL)
str(BPRSL)
str(RATSL)
glimpse(RATSL)
glimpse(BPRSL)


## Saving the data sets ##
write.csv(BPRSL, file = "C:\\Users\\Young Shin\\Documents\\IODS-project\\data\\bprslong.csv")
write.csv(RATSL, file = "C:\\Users\\Young Shin\\Documents\\IODS-project\\data\\ratslong.csv")
