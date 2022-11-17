################################################################################
#                                  LOCAL SYSTEM                                #
################################################################################

### Operating System Version
### MacBook Air
ROOT_loc = "/Users/slaan3"
STORAGE_loc = "/Users/slaan3"
CLOUD_loc = "/Users/slaan3/Library/Mobile Documents/com~apple~CloudDocs/"

# STORAGE_loc = "/Volumes/LaCie"

### Generic 
LAB_loc = paste0(CLOUD_loc, "/Genomics/LabBusiness")

GENOMIC_loc = paste0(ROOT_loc, "/Genomics")
AEDB_loc = paste0(GENOMIC_loc, "/Athero-Express/AE-AAA_GS_DBs")

### Genetic and genomic data
PLINK_loc=paste0(STORAGE_loc,"/PLINK")
GWAS_loc=paste0(PLINK_loc,"/_GWAS_Datasets/_CHARGE_CAC")

# genetic
AEGSQC_loc =  paste0(PLINK_loc, "/_AE_ORIGINALS/AEGS_COMBINED_QC2018")
MICHIMP_loc=paste0(PLINK_loc,"/_AE_ORIGINALS/AEGS_COMBINED_EAGLE2_1000Gp3v5HRCr11")

# sc rna
AESCRNA_loc = paste0(PLINK_loc, "/_AE_ORIGINALS/AESCRNA/prepped_data")

# bulk rna
AERNA_loc = paste0(PLINK_loc, "/_AE_ORIGINALS/AERNA")

### Project
PROJECT_loc = paste0(PLINK_loc, "/analyses/consortia/CHARGE_1000G_CAC")

# use this if there is relevant information here.
ifelse(!dir.exists(file.path(PROJECT_loc, "/targets")), 
       dir.create(file.path(PROJECT_loc, "/targets")), 
       FALSE)
TARGET_loc = paste0(PROJECT_loc,"/targets")

### SOME VARIABLES WE NEED DOWN THE LINE
TRAIT_OF_INTEREST = "CAC" # Phenotype
PROJECTNAME = "CAC"

cat("\nCreate a new analysis directories.\n")

cat("\n- general directory\n")
ifelse(!dir.exists(file.path(PROJECT_loc)), 
       dir.create(file.path(PROJECT_loc)), 
       FALSE)
ANALYSIS_loc = paste0(PROJECT_loc)

cat("\n- for plots\n")
ifelse(!dir.exists(file.path(ANALYSIS_loc, "/PLOTS")), 
       dir.create(file.path(ANALYSIS_loc, "/PLOTS")), 
       FALSE)
PLOT_loc = paste0(ANALYSIS_loc,"/PLOTS")

ifelse(!dir.exists(file.path(PLOT_loc, "/QC")), 
       dir.create(file.path(PLOT_loc, "/QC")), 
       FALSE)
QC_loc = paste0(PLOT_loc,"/QC")

cat("\n- for output of summary results\n")
ifelse(!dir.exists(file.path(ANALYSIS_loc, "/OUTPUT")), 
       dir.create(file.path(ANALYSIS_loc, "/OUTPUT")), 
       FALSE)
OUT_loc = paste0(ANALYSIS_loc, "/OUTPUT")

cat("\n- for baseline tables\n")
ifelse(!dir.exists(file.path(ANALYSIS_loc, "/BASELINE")), 
       dir.create(file.path(ANALYSIS_loc, "/BASELINE")), 
       FALSE)
BASELINE_loc = paste0(ANALYSIS_loc, "/BASELINE")

cat("\n- for genetic analyses\n")
ifelse(!dir.exists(file.path(ANALYSIS_loc, "/SNP")), 
       dir.create(file.path(ANALYSIS_loc, "/SNP")), 
       FALSE)
SNP_loc = paste0(ANALYSIS_loc, "/SNP")

cat("\n- for Cox regression results\n")
ifelse(!dir.exists(file.path(PLOT_loc, "/COX")), 
       dir.create(file.path(PLOT_loc, "/COX")), 
       FALSE)
COX_loc = paste0(PLOT_loc, "/COX")


setwd(paste0(PROJECT_loc))
getwd()
list.files()