#read in data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#explore data
str(gii)
str(hd)

dim(gii)
dim(hd)

summary(gii)
summary(hd)

#change various column names
colnames(gii)[1] <- "GII.r"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MMR"
colnames(gii)[5] <- "ABR"
colnames(gii)[6] <- "PARL"
colnames(gii)[7] <- "FEDU"
colnames(gii)[8] <- "MEDU"
colnames(gii)[9] <- "FLAB"
colnames(gii)[10] <- "MLAB"

colnames(hd)[1] <- "HDI.r"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "LEB"
colnames(hd)[5] <- "EYE"
colnames(hd)[6] <- "MYE"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI.HDI"

#count two new variables
gii$RAT.EDU<-gii$FEDU/gii$MEDU

gii$RAT.LAB<-gii$FLAB/gii$MLAB

#combine the two datasets with inner join by variable country
human<-merge(gii, hd, by = "Country")

#check the dimensions
dim(human)

#save as csv-file
write.csv(human, "human.csv",row.names = F)


#####################################################################################

#Exercise continued

human<-read.csv("human.csv",header = T)


# The data consists of several indicators that are thought to be important for
# a measure called human development index. This index is thought to measure the development
# of a country from a human perspective, so that a country's development would not be measured 
# only on economical terms. 

#"Country" = Country name
#GII.r= GII.Rank
#GII=gender inequality index
#MMR=maternal mortality ratio
#ABR=adolescent birth rate
#PARL=percent representation in parliament
#FEDU=population with secondary education, female
#MEDU=population with secondary education, male
#FLAB= labour force participation rate, female
#MLAB=labour force participation rate, male
#RAT.EDU=ratio fedu/medu
#RAT.LAB=ratio flab/mlab
#HDI.r=HDI rank
#HDI=human development index
#LEB=life expectancy at birth
#EYE=expected years of education
#MYE=mean years of education
#GNI= gross national income
#GNI.HDI= GNI per capita rank minus HDI rank

# look at the (column) names of human
names(human)

# look at the structure of human
str(human)

# print out summaries of the variables
summary(human)

# access the stringr package
library(stringr)

# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
human$GNI<-str_replace(human$GNI, pattern=",", replace ="")

#convert GNI into numeric
human$GNI<-(as.numeric(human$GNI))

#dpyr package
library(dplyr)

#keep only columns that refer to: "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", 
# "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"
keep_columns<-c("Country","RAT.EDU","RAT.LAB","EYE","LEB","GNI","MMR","ABR","PARL")
human<- select(human,one_of(keep_columns))

#keep only rows with no NAs
human<-human[complete.cases(human), ]

#remove the observations which relate to regions instead of countries
library(dplyr)    
human<-filter(human, Country != "World")
human<-filter(human, Country != "Arab States")
human<-filter(human, Country != "Sub-Saharan Africa")
human<-filter(human, Country != "South Asia")
human<-filter(human, Country != "Latin America and the Caribbean")
human<-filter(human, Country != "Europe and Central Asia")
human<-filter(human, Country != "East Asia and the Pacific")

# add countries as rownames
rownames(human) <- human$Country

# remove the Country variable
human <- select(human, -Country)

#save
write.csv(human,"human2.csv",row.names = T)
