# Young Kyu Shin, November 18, 2019 data for exercise 3: logistic regression #

### Data source: Paulo Cortez, University of Minho, GuimarÃ£es, Portugal, http://www3.dsi.uminho.pt/pcortez ###


## Task 3: Reading both student-mat.csv and student-por.csv and exploring the data ##

ex3_math <- read.csv("C:\\Users\\Young Shin\\Documents\\IODS-project\\data\\student-mat.csv", sep = ";")
ex3_math
str(ex3_math)
dim(ex3_math)

ex3_por <- read.csv("C:\\Users\\Young Shin\\Documents\\IODS-project\\data\\student-por.csv", sep = ";")
str(ex3_por)
dim(ex3_por)


## Task 4: Joining 2 datasets ##

#### access the dplyr library ####
library(dplyr) 

#### Joining by using common columns ####
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
ex3 <- inner_join(ex3_math, ex3_por, by = join_by, suffix = c(".math", ".por"))
colnames(ex3)
glimpse(ex3)

#### Keeping only the students present in both datasets ####
alc <- select(ex3, one_of(join_by))
str(alc)
dim(alc)


## Task 5: Combining the 'duplicated' answers in the joined data ##

#### columns that were not used for joining the data ####
notjoined_columns <- colnames(ex3_math)[!colnames(ex3_math) %in% join_by]

#### print out the columns not used for joining ####
notjoined_columns

#### for every column name not used for joining...####
for(column_name in notjoined_columns) {
  two_columns <- select(ex3, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
      alc[column_name] <- round(rowMeans(two_columns))
} else
      alc[column_name] <- first_column
}

#### glimpse at the new combined data ####
glimpse(alc)


## Task 6: Creating a new column 'alc_use and 'high_use' ##

#### defining a new column alc_use by combining weekday and weekend alcohol use ####
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#### define a new logical column 'high_use' ####
alc <- mutate(alc, high_use = alc_use > 2)


## Task 7: Glimpsing and saving the modified data ##

#### Glimsing ####
glimpse(alc)

#### saving ####
write.table(alc)
write.csv(alc, "C:\\Users\\Young Shin\\Documents\\IODS-project\\data\\alc.csv")
