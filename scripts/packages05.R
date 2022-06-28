################################################################################
#                                PACKAGES TO LOAD                              #
################################################################################

install.packages.auto("R.utils")

install.packages.auto("pander")
install.packages.auto("readr")
install.packages.auto("optparse")
install.packages.auto("tools")
install.packages.auto("dplyr")
install.packages.auto("tidyr")
install.packages.auto("naniar")

# To get 'data.table' with 'fwrite' to be able to directly write gzipped-files
# Ref: https://stackoverflow.com/questions/42788401/is-possible-to-use-fwrite-from-data-table-with-gzfile
# install.packages("data.table", repos = "https://Rdatatable.gitlab.io/data.table")
library(data.table)

install.packages.auto("tidyverse")
install.packages.auto("knitr")
install.packages.auto("DT")
install.packages.auto("eeptools")

install.packages.auto("haven")
install.packages.auto("tableone")
install.packages.auto("openxlsx")

install.packages.auto("BlandAltmanLeh")

# Install the devtools package from Hadley Wickham
install.packages.auto('devtools')
library(devtools) 

# for plotting
install.packages.auto("pheatmap")
install.packages.auto("forestplot")
install.packages.auto("ggplot2")
install.packages.auto("ggpubr")
install.packages.auto("UpSetR")

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

devtools::install_github("thomasp85/patchwork")

# For regional association plots
install_github("oliviasabik/RACER") 
library(RACER)

# Install ggrepel package if needed
install.packages.auto("ggrepel")
library(ggrepel)

# install ggsci
install.packages.auto("ggsci")

# plotly
# install.packages.auto("plotly")