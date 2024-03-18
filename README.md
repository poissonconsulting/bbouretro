
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbouretro

<!-- badges: start -->

[![R-CMD-check](https://github.com/poissonconsulting/bbouretro/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/bbouretro/actions/workflows/R-CMD-check.yaml)
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

recruitment_est <- recruitment(bbourecruit_c, pFemales = 0.65, sexratio = 0.5, variance = "binomial") 
plot_recruitment(recruitment_est)
#> Warning: Removed 9 rows containing missing values or values outside the scale range
#> (`geom_point()`).
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

``` r

survival_est <- km_survival(bbousurv_c, MortType = "Total", variance = "Pollock")
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
#> Warning in mean.default(.data$Smonth): argument is not numeric or logical:
#> returning NA
#> Warning in mean.default(.data$StartTotal): argument is not numeric or logical:
#> returning NA
#> Warning in min(.data$StartTotal): no non-missing arguments to min; returning
#> Inf
#> Warning in max(.data$StartTotal): no non-missing arguments to max; returning
#> -Inf
plot_survival(survival_est)
```

<img src="man/figures/README-unnamed-chunk-4-2.png" width="100%" />

``` r

# TODO turn on when not erroring
#lambda_est <- lambda_sim(recruitment_est, survival_est)
#summary <- SummarizeLambda(lambda_est)
#plot_lambda(lambda_est)
#plot_lambda_distributions(lambda_est, "C")
```

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/bbouretro/issues).

[Pull requests](https://github.com/poissonconsulting/bbouretro/pulls)
are always welcome.

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
