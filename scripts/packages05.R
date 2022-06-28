################################################################################
#                                PACKAGES TO LOAD                              #
################################################################################

install.packages.auto("R.utils")

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