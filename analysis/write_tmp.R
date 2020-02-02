library(fs)
library(tidyverse)

ignore_list <-
    read_lines("cookbook.Rmd") %>%
    str_subset("\\.Rmd") %>%
    str_subset("child") %>%
    str_remove("```\\{r,child=\"") %>%
    str_remove("\"\\}")

# analysis ----------------------------------------------------------------

rmd_path_list <- dir_ls("analysis", regexp = "\\.Rmd$") %>% 
    setdiff(ignore_list)
    # length()
output <-
    data.frame(path = rmd_path_list) %>%
    mutate(
        title = path %>% as.character() %>% basename() %>% str_remove("\\.Rmd$") %>% 
            str_replace_all("-|_", " ") %>% str_to_title(),
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


rmd_path_list <- dir_ls("template", regexp = "\\.Rmd$") %>% 
    setdiff(ignore_list)
output <-
    data.frame(path = rmd_path_list) %>%
    mutate(
        title = path %>% as.character() %>% basename() %>% str_remove("\\.Rmd$") %>% 
            str_replace_all("-|_", " ") %>% str_to_title(),
        text = glue::glue(
            '

# <<title>>

```{r, comment=""}
xfun::file_string("../<<path>>")
```',
            .open = "<<",
            .close = ">>"
        )
    ) %>%
    summarise(rmd_child = str_flatten(text, "\n"))


output$rmd_child %>%
    write_file("tmp/line_list.Rmd")
