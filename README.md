
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

SsampsC <- bboudata::bbousurv_c
RsampsC <- bboudata::bbourecruit_c

CO<-Recruitment(RsampsC,pFemales=0.65,sexratio=0.5,variance="binomial") 
S<-KMsurvival(SsampsC,MortType="Total",variance="Pollock")
PlotRecruitment(CO)
PlotSurvival(S)
Lambdadat<-LambdaSim(CO,S)
Summary<-SummarizeLambda(Lambdadat)
plotLambda(Lambdadat)
plotLambdaDistributions(Lambdadat,"C")
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
