# load packages -----------------------------------------------------------

library(fs)
library(tidyverse)


# move -------------------------------------------------------------------

dir_info(".", type = 'file', regexp = '\\.R?md$') %>% 
    filter(!path %>% str_detect('README|NEWS')) %>% 
    mutate(
        mv = map(path, file_move, new_path = "analysis")
    )

dir_delete("sql")


# wflow -------------------------------------------------------------------

wflow_status()

wflow_git_commit("analysis/*", message = "transfer all into analysis", all = TRUE)

wflow_publish('analysis/*', message = "publish all", all = TRUE)
