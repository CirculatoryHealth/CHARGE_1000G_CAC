# CAC_1000G_Circ_Manhattan.R

##module load   gcc/7.1.0  openmpi/3.1.4 intel/18.0  intelmpi/18.0 R/3.6.3

##R

# formatting input file 

library(tidyr)
library(dplyr)
library(readr)
library(data.table)

# read data

data <- fread("/scratch/dw2vr/CAC_1000G_paintorv3/METAL.EA.AA.Filtered.13Apr16.txt", header=T)

head<-fread('/scratch/dw2vr/CAC_1000G_paintorv3/header', header=T)

colnames(head)->colnames(data)

#dat<-dat%>%dplyr::filter(type=="SNV")

# filter based on 4 cohorts

dat <- subset(data, ncohorts>=4)

# filter based on heterogeneity

dat <- subset(dat, dat$HetISq<70)

dim(data)


# create variables for ancestries

dat$AA <- substring(dat$Direction, 16, nchar(dat$Direction))

dat$EA <- substring(dat$Direction, 1, 15)

dat$AAsum <- nchar(as.character(gsub("\\?","",dat$AA)),type="chars") 

dat$EAsum <- nchar(as.character(gsub("\\?","",dat$EA)),type="chars")  

# filter based on both ancestries

dat <- subset(dat, dat$EAsum!=0 & dat$AAsum!=0)

write_delim(dat,"1000G_CAC_EA_AA_filtered_101221_new.txt", '\t' )
