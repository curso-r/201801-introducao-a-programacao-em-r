# install.packages("devtools")
# install.packages("tidyr")
# install.packages("dplyr")
# devtools::install_github("rstudio/EDAWR")

library(EDAWR)
?storms
?cases
?pollution
?tb

# formas de acessar variáveis de um df
storms$storm
storms[,1]
storms[["storm"]]  

# tidyr
library(tidyr)
?gather
?spread



