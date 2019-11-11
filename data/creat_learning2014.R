# Young Kyu Shin, November 11, 2019 data for regression and model validation #


## Data wrangling ##
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14)

str(lrn14)

lrn14$Attitude / 10
lrn14$attitude <- lrn14$Attitude / 10

library(dplyr)


### Scaling variables to the original scales ###
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)


### Keeping columns needed for analysis ###
keep_columns <- c("gender", "Age", "attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))
str(learning2014)

### Modifying column names ###
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
learning2014 <- filter(learning2014, points > 0)

str(learning2014)


## Data analysis ##
ex2 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)

### Exploring data ###
str(ex2)
dim(ex2)

### Graphical overview and summaries ###
library(ggplot2)
ggplot(ex2)
pairs(ex2[-1])

library(GGally)
library(ggplot2)

p <- ggpairs(ex2, mapping = aes(), lower = list(combo = wrap("facethist", bins = 20)))
p

summary(ex2)

### Fitting regression models ###
### explanatory variables: attitude, stra, surf
model1 <- lm(points ~ attitude + stra + surf, data = ex2)
summary(model)
model2 <- lm(points ~ attitude + stra, data = ex2)
summary(model)

### Producing diagnostic plots ###
#### Residuals vs Fitted Values, Normal QQ-plot and Residuals vs Leverage ####
par(mfrow = c(2,2))
plot(model2, which = c(1,2,5))
