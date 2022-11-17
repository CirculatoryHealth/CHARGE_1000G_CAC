################################################################################
#                                PACKAGES TO LOAD                              #
################################################################################

# Sometimes you get the following:
# devtools::install_github("thomasp85/patchwork")
# Using github PAT from envvar GITHUB_PAT
# Error: Failed to install 'unknown package' from GitHub:
#   HTTP error 401.
#   Bad credentials
# 
#   Rate limit remaining: 55/60
#   Rate limit reset at: 2022-06-28 17:12:31 UTC

# To solve this, do this:
library(credentials)
# Found git version 2.32.1 (Apple Git-133)
# Supported HTTPS credential helpers: cache, store
# Found OpenSSH_8.6p1, LibreSSL 3.3.6
# Default SSH key: /Users/swvanderlaan/.ssh/id_rsa_github
credentials::set_github_pat()
# If prompted for GitHub credentials, enter your PAT in the password field
# Using GITHUB_PAT from Sander W. van der Laan (credential helper: osxkeychain)

# Packages needed for tabulating results, parsing data, or making graphics
install.packages.auto("devtools")
library(devtools) 

install.packages.auto("readr")
install.packages.auto("optparse")
install.packages.auto("tools")
install.packages.auto("dplyr")
install.packages.auto("tidyr")
install.packages.auto("tidylog")
library("tidylog", warn.conflicts = FALSE)
install.packages.auto("naniar")

# To get 'data.table' with 'fwrite' to be able to directly write gzipped-files
# Ref: https://stackoverflow.com/questions/42788401/is-possible-to-use-fwrite-from-data-table-with-gzfile
# install.packages("data.table", repos = "https://Rdatatable.gitlab.io/data.table")
install.packages.auto("data.table")

install.packages.auto("tidyverse")
install.packages.auto("knitr")
install.packages.auto("DT")
install.packages.auto("eeptools")

install.packages.auto("haven")
install.packages.auto("tableone")

install.packages.auto("ggpubr")

# Install ggrepel package if needed
install.packages.auto("ggrepel")
library(ggrepel)

# install ggsci
install.packages.auto("ggsci")

devtools::install_github("thomasp85/patchwork")

# For regional association plots
install_github("oliviasabik/RACER") 
library(RACER)

# TwoSample MR
# devtools::install_github("MRCIEU/TwoSampleMR")
library("TwoSampleMR")
