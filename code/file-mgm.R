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

wflow_git_commit("analysis/about.Rmd", message = "1. update about")

wflow_publish("analysis/param-rmd.Rmd", message = "1. update")
wflow_publish("analysis/*", message = "add 参数化RMarkdown 文档", all = T)

wflow_open('analysis/rmd-template.Rmd')

# custom ------------------------------------------------------------------

wflow_open('analysis/about.Rmd')
wflow_open('README.Rmd', project = NULL)
