在 Rmd 中使用 SQL
================
李家翔
2019-02-06

参考[bookdown](https://bookdown.org/yihui/rmarkdown/language-engines.html#sql)

``` r
library(DBI)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(con, "mtcars", mtcars)
library(glue)
tbl <- "mtcars"
```

``` sql
SELECT * FROM `mtcars` where gear IN (3, 4)
```

|  mpg | cyl |  disp |  hp | drat |    wt |  qsec | vs | am | gear | carb |
| ---: | --: | ----: | --: | ---: | ----: | ----: | -: | -: | ---: | ---: |
| 21.0 |   6 | 160.0 | 110 | 3.90 | 2.620 | 16.46 |  0 |  1 |    4 |    4 |
| 21.0 |   6 | 160.0 | 110 | 3.90 | 2.875 | 17.02 |  0 |  1 |    4 |    4 |
| 22.8 |   4 | 108.0 |  93 | 3.85 | 2.320 | 18.61 |  1 |  1 |    4 |    1 |
| 21.4 |   6 | 258.0 | 110 | 3.08 | 3.215 | 19.44 |  1 |  0 |    3 |    1 |
| 18.7 |   8 | 360.0 | 175 | 3.15 | 3.440 | 17.02 |  0 |  0 |    3 |    2 |
| 18.1 |   6 | 225.0 | 105 | 2.76 | 3.460 | 20.22 |  1 |  0 |    3 |    1 |
| 14.3 |   8 | 360.0 | 245 | 3.21 | 3.570 | 15.84 |  0 |  0 |    3 |    4 |
| 24.4 |   4 | 146.7 |  62 | 3.69 | 3.190 | 20.00 |  1 |  0 |    4 |    2 |
| 22.8 |   4 | 140.8 |  95 | 3.92 | 3.150 | 22.90 |  1 |  0 |    4 |    2 |
| 19.2 |   6 | 167.6 | 123 | 3.92 | 3.440 | 18.30 |  1 |  0 |    4 |    4 |

Displaying records 1 - 10