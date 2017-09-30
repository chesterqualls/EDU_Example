library(tidyverse)
library(stringr)
library(dplyr)
library(sqldf)
library(Deducer)

dAssess <- read.csv(file.choose(),header = TRUE,
      na = c("NULL", "NA"))
dDiscipline <- read.csv(file.choose(),header = TRUE)

summary(dAssess)
summary (dAssess$DistrictName)

names (dAssess)

#dAssess <- dAssess %>%
  filter (Score != "NA" & Score != "NULL")

attach (dAssess)

summary(Score)

NumScore <- as.numeric(Score)


summary (NumScore)

mean (NumScore)
hist(Score)
box()

# Playing with dplr vs SQL to create a dataframe of mean scores by school.


#SDbySchool_dplyr <- dAssess %>%  
#  group_by(SCHOOL_NAME) %>%
#  summarize(Score_SD = sd(Score,na.rm=TRUE))

#SchoolScores_SQL <- sqldf("SELECT dAssess.SCHOOL_NAME, dAssess.Score, Count(dAssess.Score) AS CountOfScore 
#                      FROM dAssess 
#                      GROUP BY dAssess.SCHOOL_NAME, dAssess.Score;")

Mean_SD_bySchool_dplyr <- dAssess %>%
  group_by(SCHOOL_NAME) %>%
  summarize(Score_Mean = mean(Score,na.rm=TRUE), Score_SD = sd(Score,na.rm=TRUE))

Mean_SD_bySchool_SQL <- sqldf("SELECT dAssess.SCHOOL_NAME, 
  avg(Case When dAssess.Score='NA' Or dAssess.Score='NULL' Then dAssess.Score = Null Else 
    dAssess.Score End) as AVGScore,
  stdev(Case When dAssess.Score='NA' Or dAssess.Score='NULL' Then dAssess.Score = Null Else 
    dAssess.Score End) as SDScore
  FROM dAssess 
  GROUP BY dAssess.SCHOOL_NAME;")


summary(MeanbySchool_dplyr)
hist(MeanbySchool_dplyr$Score_Mean)

getwd()

write.csv(cohort1_all, file = "JW_cohort1_all.csv")
write.csv(all_grades, file="JW_CoursesIdentifiedAsIA.csv")
