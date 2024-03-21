
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbouretro

<!-- badges: start -->

[![R-CMD-check](https://github.com/poissonconsulting/bbouretro/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/bbouretro/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/poissonconsulting/bbouretro/branch/main/graph/badge.svg)](https://app.codecov.io/gh/poissonconsulting/bbouretro?branch=main)
<!-- badges: end -->

## Introduction

The goal of bbouretro is to …

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

This is a basic example which shows you how to solve a common problem:

``` r
library(bbouretro)
library(bboudata)

recruitment_est <- 
  bbr_recruitment(
    bbourecruit_c, 
    pFemales = 0.65, 
    sexratio = 0.5, 
    variance = "binomial"
)
bbr_plot_recruitment(recruitment_est)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

``` r

survival_est <- 
  bbr_km_survival(
    bbousurv_c,
    MortType = "Total", 
    variance = "Pollock"
  )
bbr_plot_survival(survival_est)
```

<img src="man/figures/README-unnamed-chunk-4-2.png" width="100%" />

``` r

lambda_est <- bbr_lambda_sim(recruitment_est, survival_est)
summary <- bbr_summarize_lambda(lambda_est)
summary
#> # A tibble: 9 × 13
#>   PopulationName  Year     S     R Lambda SE_Lambda Lambda_LCL Lambda_UCL
#>   <chr>          <int> <dbl> <dbl>  <dbl>     <dbl>      <dbl>      <dbl>
#> 1 C               2005 0.832 0.096  0.92      0.051      0.84       1.04 
#> 2 C               2006 1     0.08   1.09     NA         NA         NA    
#> 3 C               2007 0.524 0.068  0.562     0.037      0.502      0.652
#> 4 C               2008 0.824 0.059  0.876     0.123      0.799      1.25 
#> 5 C               2009 1     0.083  1.09     NA         NA         NA    
#> 6 C               2010 0.926 0.14   1.08      0.065      0.99       1.23 
#> 7 C               2011 0.96  0.158  1.14      0.107      1.03       1.44 
#> 8 C               2012 0.963 0.112  1.08      0.054      1.01       1.20 
#> 9 C               2013 0.512 0.133  0.591     0.027      0.553      0.657
#> # ℹ 5 more variables: Prop_LGT1 <dbl>, meanSimSurv <dbl>, meanRsim <dbl>,
#> #   meanSimLambda <dbl>, medianSimLambda <dbl>
bbr_plot_lambda(lambda_est)
```

<img src="man/figures/README-unnamed-chunk-4-3.png" width="100%" />

``` r
bbr_plot_lambda_distributions(lambda_est, "C")
```

<img src="man/figures/README-unnamed-chunk-4-4.png" width="100%" />

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/bbouretro/issues).

[Pull requests](https://github.com/poissonconsulting/bbouretro/pulls)
are always welcome.

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
