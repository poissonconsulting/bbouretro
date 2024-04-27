
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- # Copyright 2024 Province of Alberta -->
<!-- # -->
<!-- # Licensed under the Apache License, Version 2.0 (the "License"); -->
<!-- # you may not use this file except in compliance with the License. -->
<!-- # You may obtain a copy of the License at -->
<!-- # -->
<!-- # http://www.apache.org/licenses/LICENSE-2.0 -->
<!-- # -->
<!-- # Unless required by applicable law or agreed to in writing, software -->
<!-- # distributed under the License is distributed on an "AS IS" BASIS, -->
<!-- # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. -->
<!-- # See the License for the specific language governing permissions and -->
<!-- # limitations under the License. -->

# bbouretro

<!-- badges: start -->

[![R-CMD-check](https://github.com/poissonconsulting/bbouretro/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/bbouretro/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/poissonconsulting/bbouretro/branch/main/graph/badge.svg?token=y99t6ttYNS)](https://app.codecov.io/gh/poissonconsulting/bbouretro?branch=main)
<!-- badges: end -->

## Introduction

The goal of bbouretro is to provide the ability to calculate survival,
recruitment and population growth using the classical methods.

## Installation

To install the latest development version from
[GitHub](https://github.com/poissonconsulting/bbouretro)

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/bbouretro")
```

or alternatively using pak

``` r
# install.packages("pak")
pak::pak("poissonconsulting/bbouretro")
```

## Example

``` r
set.seed(101)

library(bbouretro)
library(bboudata)

# generate recruitment estimate for each year
recruitment_est <-
  bbr_recruitment(
    bbourecruit_c,
    p_females = 0.65,
    sex_ratio = 0.5,
    variance = "bootstrap"
  )
bbr_plot_recruitment(recruitment_est)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

``` r

# generate survival estimate for each year
survival_est <-
  bbr_survival(
    bbousurv_c,
    mort_type = "total",
    variance = "greenwood"
  )
bbr_plot_survival(survival_est)
```

<img src="man/figures/README-unnamed-chunk-4-2.png" width="100%" />

``` r

# calculate lambda now that both recruitment and survival have been calculated
growth_est <- bbr_growth(survival_est, recruitment_est)
summary <- bbr_growth_summarize(growth_est)
summary
#> # A tibble: 9 × 13
#>   PopulationName  Year     S     R estimate     se  lower  upper prop_lgt1
#>   <chr>          <int> <dbl> <dbl>    <dbl>  <dbl>  <dbl>  <dbl>     <dbl>
#> 1 C               2004 0.096 0.867    0.722  0.76   0.213  2.69      0.328
#> 2 C               2005 0.08  0.832    0.476  0.381  0.164  1.61      0.111
#> 3 C               2006 0.068 1      Inf     NA     NA     NA        NA    
#> 4 C               2007 0.059 0.458    0.109  0.128  0.024  0.514     0.001
#> 5 C               2008 0.083 0.941    1.41   3.23   0.249 12.1       0.637
#> 6 C               2009 0.14  1      Inf     NA     NA     NA        NA    
#> 7 C               2010 0.158 0.926    2.13   2.37   0.615  9.52      0.868
#> 8 C               2011 0.112 0.96     2.8    6.18   0.458 20.9       0.863
#> 9 C               2012 0.133 0.924    1.75   1.9    0.507  7.54      0.793
#> # ℹ 4 more variables: mean_sim_survival <dbl>, mean_sim_recruitment <dbl>,
#> #   mean_sim_growth <dbl>, median_sim_growth <dbl>
bbr_plot_growth(growth_est)
```

<img src="man/figures/README-unnamed-chunk-4-3.png" width="100%" />

``` r
bbr_plot_growth_distributions(growth_est)
```

<img src="man/figures/README-unnamed-chunk-4-4.png" width="100%" />

## bbou Suite

`bbouretro` is part of the bbou suite of tools. Other packages in this
suite include:

- [bboudata](https://github.com/poissonconsulting/bboudata)
- [bboutools](https://github.com/poissonconsulting/bboutools)
- [bboushiny](https://github.com/poissonconsulting/bboushiny)
- [bbousims](https://github.com/poissonconsulting/bbousims)

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/bbouretro/issues).

[Pull requests](https://github.com/poissonconsulting/bbouretro/pulls)
are always welcome.

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
