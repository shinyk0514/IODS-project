# Young Kyu Shin, November 11, 2019 data for regression and model validation #

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14)

str(lrn14)

lrn14$Attitude / 10
lrn14$attitude <- lrn14$Attitude / 10

library(dplyr)


## Scaling variables to the original scales ##
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)


## Keeping columns needed for analysis ##
keep_columns <- c("gender", "Age", "attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))
str(learning2014)

## Modifying column names ##
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
learning2014 <- filter(learning2014, points > 0)

str(learning2014)