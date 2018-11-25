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
