library(tidyverse)

setwd("C:/Users/Chester Qualls/Desktop/Customers/EDU_Example")

df_enroll_Cohort <- read_csv("CRI Student Data/A Mind_Cohort 1_Enrollment.csv",
                             na = c("NULL", "NA"),
                             col_types = cols(
                               GradeLevel = col_character(),
                               LocationID = col_character(),
                               DistrictCode = col_character(),
                               ResidentDistrictCode = col_character()
                             )
)

df_enroll_Comp <- read_csv("CRI Student Data/A Mind_Comp 1_Enrollment.csv",
                           na = c("NULL", "NA"),
                           col_types = cols(
                             GradeLevel = col_character(),
                             LocationID = col_character(),
                             DistrictCode = col_character(),
                             ResidentDistrictCode = col_character()
                           )
)

df_enroll_all <- full_join(df_enroll_Cohort, df_enroll_Comp)

rm(df_enroll_Cohort, df_enroll_Comp)

colnames(df_enroll_all) <- tolower(colnames(df_enroll_all))

df_enroll_all <- select(df_enroll_all, researchid, district_id:school_name, ayd_ia_c1_comp:ayd__ia_cohort_1, schoolyear, gradelevel, gender, disabilityflag, 
                      isstudentimmigrant, primarylanguage, federalethracerollupcode, federalethracerollupname, expectedgradyear, cumulativegpa:numdayspresent) %>%
    arrange(researchid, schoolyear)
