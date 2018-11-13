#Sirke Piirainen
#12.11.2018
#exercise 3, creating alc
#data from: https://archive.ics.uci.edu/ml/datasets/Student+Performance

#read in data
mat<-read.csv("student-mat.csv",header = T, sep = ";")
por<-read.csv("student-por.csv",header = T, sep = ";")

#check structure and dimensions of the data
str(mat)
str(por)
#in Rstudio I can see dimensions of the data from the environment window also
dim(mat)
dim(por)

##############################################################################################
#joining datasets

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(mat, por, by = join_by,suffix=c(".math",".por"))

#check structure
str(math_por)
#dimensions
dim(math_por)

#####################################################################################
#combining duplicated answers

# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)
