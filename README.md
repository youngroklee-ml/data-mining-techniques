# data-mining-techniques

## Folders

- `data`: locate data files (e.g. .csv)
- `original`: original R scripts written by each author
- `revised`: revised R scripts with reformatting and refactoring
- `chapters`: add quarto documents to render html files that contains R code results

## Environment

- `R`: version 4.3.2
- Packaages
  + `{renv}`: version 1.0.3
  + other packages: from [Posit Public Package Manager](https://packagemanager.posit.co/client/#/)'s CRAN snapshot as of 2024-01-12. Set repository address to be https://packagemanager.posit.co/cran/2024-01-12 with the following R script: 

```
renv::init(repos = https://packagemanager.posit.co/cran/2024-01-12)
```
