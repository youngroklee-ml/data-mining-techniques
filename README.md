# data-mining-techniques

## Folders

- *data*: locate data files (e.g. .csv)
- *original*: original R scripts written by each author
- *revised*: revised R scripts with reformatting and refactoring
- *chapters*: add quarto documents to render html files that contains R code results

## Environment

- `R`: version 4.3.2
- Packages
  + `{renv}`: version 1.0.3
  + other packages: from [Posit Public Package Manager](https://packagemanager.posit.co/client/#/)'s CRAN snapshot as of 2024-01-12. Set repository address to be https://packagemanager.posit.co/cran/2024-01-12 with the following R script: 

```
renv::init(repos = "https://packagemanager.posit.co/cran/2024-01-12")
```

## Reformatting process

1. Copy R script file from *original* to *revised*
2. Run `styler::style_file()` with the file in *revised* folder. Use default `tidyverse_style`.
3. Remove code that creates side-effect, including but not limited to followings:
    1. `setwd()` to set work directory; all paths will be relative path starting from project directory as a root
    1. `install.packages()` to install packages; we will assume that required packages have been installed
4. Ensure that each R code does not miss any dependencies to include (e.g. file, library)
5. If it is possible and makes sense, remove dependency on `{tidyverse}`.
    1. If it makes sense to keep using `{tidyverse}`, minimize the use of `{tidyverse}` and provide a specific comment per each use if possible.
