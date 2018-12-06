# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# Print out summaries of the variables
summary(BPRS)

#In this BPRS data set 40 male subjects were randomly assigned to one of two treatment groups 
#and each subject was rated on the brief psychiatric rating scale (BPRS) measured before 
#treatment began (week 0) and then at weekly intervals for eight weeks. The BPRS assesses 
#the level of 18 symptom constructs such as hostility, suspiciousness, hallucinations and 
#grandiosity; each of these is rated from one (not present) to seven (extremely severe). 
#The scale is used to evaluate patients suspected of having schizophrenia.

# Read the RATS data
RATS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",header = T,sep = "\t")

# Look at the (column) names of RATS
names(RATS)

# Look at the structure of RATS
str(RATS)

# Print out summaries of the variables
summary(RATS)

#RATS data set comes from a nutrition study conducted in three groups of rats. The groups
#were put on different diets, and each animal's body weight (grams) was recorded repeatedly 
#(approximately weekly, except in week seven when two recordings were taken) over 
#a 9-week period. 

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Factor treatment & subject in BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor treatment & subject in RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$week,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse the data
glimpse(RATSL)

#As a biologist I most often work with data in the long form. I have individuals animals 
#or populations that are measured repeatedly over a period of time (sometimes over decades).
#Every measurement has to be one supposedly "independent" observation and on the dataset 
#it has to correspond to one row only. This requires that some variable values (measurements 
#that do not change during the course of time, such as sex) are repeated on each row. 
#Of course the measurements are not independent if they are taken from the same individual 
#or population. This is where mixed modelling and its random component are useful.
#In ecological data there is usually also either spatial or temporal correlation. 
#Observations that are timely or spatially are more resembling and therefore correlated and 
#not truly independent.

#save the data
write.csv(RATSL, "rats.csv", header=T)
