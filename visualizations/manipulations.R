# Import data
var <- read.csv("variants_long_table.csv")

# To view the first 6 rows
head(var)

# To view the last 6 rows
tail(var)

# To preview the data in spreadsheet-style
View(var)

# Explore the file and data structure
## To check the dimension of the data
dim(var) # The data contains 153 entries (lines/rows) and 16 columns as individual variables

## To check the number of rows and columns
nrow(var)
ncol(var)

## To display the structure of the data
str(var)

# Generate summary statistics of the data
## For the whole table
summary(var)

## For non-numerical data
summary(var$SAMPLE)
summary(var$DP)

## To check the class of the data
class(var)

## To check the class of an object
class(var$CHROM)
# or
typeof(var$CHROM)

library(dplyr)
library(tidyverse)

#1. Filtering columns

# Check columns name
colnames(var)

# Select columns
var[c(1, 4, 5), c(1, 4, 5)]

select(var, SAMPLE, REF, ALT)

select(var, SAMPLE, REF, ALT) %>% head(3)

select(var, -CALLER) %>% head(3)

# Using tibble
var_tb <- as_tibble(var)
select(var_tb, SAMPLE, REF, ALT) %>% head(3)

#2. FILTERING ROWS
var_tb[var_tb$SAMPLE == "SRR13500958",]

# Using dplyr function
filter(var_tb, SAMPLE == "SRR13500958") %>% head(3)

# Filter Columns and Rows
var_tb %>% filter(SAMPLE == "SRR13500958") %>% select(CHROM, POS, REF, ALT) %>% head(3)

# Select only values for which DP>=500 for the same sample
var_tb %>% filter(SAMPLE == "SRR13500958" & DP >= 1000) %>% select(CHROM, POS, REF, ALT, DP)


# COunt number of rows associated with each sample in the dataset
var_tb %>% count(SAMPLE, GENE, sort = TRUE)

# Basic Maths
## Maximum, minimum, and mean value of column DP
max(var_tb$DP)
min(var_tb$DP)
mean(var_tb$DP)

# Compute a LOG2 transformation on the DP values
var_tb_log <- var_tb %>% mutate(DP_log2 = log2(DP))
select(var_tb_log, SAMPLE, REF, ALT, DP, DP_log2) %>% head()

# Show the maximum value of DP for each sample
var_tb %>% group_by(SAMPLE) %>% summarize(max(DP))

# Show the minimum value of DP for each sample
var_tb %>% group_by(SAMPLE) %>% summarize(min(DP))