# load packages -----------------------------------------------------------

library(fs)
library(tidyverse)

dir_info(".", type = 'file', regexp = '\\.R?md$') %>% 
    filter(!path %>% str_detect('README|NEWS')) %>% 
    mutate(
        mv = map(path, file_move, new_path = "analysis")
    )

dir_delete("sql")

wflow_status()