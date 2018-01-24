library(magrittr)

chefe <- function(x) {
  
  if(length(x) > 1) {
    return("Por que você está fazendo isso?")
  }
  
  stringr::str_c("img/chefe_", x, ".jpg") %>% 
    knitr::include_graphics()
  
}