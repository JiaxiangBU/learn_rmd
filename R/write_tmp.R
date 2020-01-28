write_tmp <- function() {
    library(fs)
    library(tidyverse)

    # analysis ----------------------------------------------------------------
    
    rmd_path_list <- dir_ls("analysis", regexp = "\\.Rmd$")
    output <-
        data.frame(path = rmd_path_list) %>%
        mutate(
            title = path %>% as.character() %>% basename() %>% str_remove("\\.Rmd$"),
            text = glue::glue(
                '

  # <<title>>

  ```{r,child="../<<path>>"}
  ```',
                .open = "<<",
                .close = ">>"
            )
        ) %>%
        summarise(rmd_child = str_flatten(text, "\n"))
    
    
    output$rmd_child %>%
        write_file("tmp/child_list.Rmd")


    # template ----------------------------------------------------------------

    
    rmd_path_list <- dir_ls("template", regexp = "\\.Rmd$")
    output <-
        data.frame(path = rmd_path_list) %>%
        mutate(
            title = path %>% as.character() %>% basename() %>% str_remove("\\.Rmd$"),
            text = glue::glue(
                '

  # <<title>>

  ```{r}
  readr::read_lines("../<<path>>")
  ```',
                .open = "<<",
                .close = ">>"
            )
        ) %>%
        summarise(rmd_child = str_flatten(text, "\n"))
    
    
    output$rmd_child %>%
        write_file("tmp/line_list.Rmd")
}
