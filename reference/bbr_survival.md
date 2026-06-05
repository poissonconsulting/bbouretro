# Estimate survival

Estimate survival rates based on the Kaplan-Meier survival rate
estimator (Pollock et al. 1989).

## Usage

``` r
bbr_survival(
  x,
  include_uncertain_morts = TRUE,
  variance = "greenwood",
  year_start = 4L
)
```

## Format

The return object has these columns:

- PopulationName:

  Population name

- Year:

  Year sampled

- estimate:

  Survival estimate

- se:

  SE

- lower:

  Confidence limit

- upper:

  Confidence limit

- mean_monitored:

  Mean number of caribou monitored each month

- sum_dead :

  Total number of mortalities in a year

- sum_alive:

  Total number of caribou-months in a year

- status:

  Indicates less than 12 months monitored or if there were 0 mortalities
  in a given year

## Arguments

- x:

  A data frame that has survival data.

- include_uncertain_morts:

  A flag indicating whether to include uncertain mortalities in total
  mortalities. The default value is TRUE.

- variance:

  Variance type to estimate. Can be the Greenwood estimator
  `"greenwood"` or Cox Oakes estimator `"cox_oakes"`. The default is
  "greenwood".

- year_start:

  A whole number between 1 and 12 indicating the month of the start of
  the caribou (i.e., biological) year. By default, April is set as the
  start of the caribou year.

## Value

A data frame. The columns are listed in the format section.

## Details

`x` needs to be formatted in a certain manner. To confirm the input data
frame is in the right format you can use the
[`bbd_chk_data_survival`](https://poissonconsulting.github.io/bboudata/reference/bbd_chk_data_survival.html)
function. See the `vignette("methods", package = "bbouretro")` for the
equations used in this function.

## References

Pollock, K. H., S. R. Winterstein, C. M. Bunck, and P. D. Curtis. 1989.
Survival analysis in telemetry studies: the staggered entry design.
Journal of Wildlife Management 53:7-15.

## Examples

``` r
survival_est <- bbr_survival(
  bboudata::bbousurv_a,
  include_uncertain_morts = TRUE,
  variance = "greenwood"
)
survival_est <- bbr_survival(
  bboudata::bbousurv_b,
  include_uncertain_morts = FALSE,
  variance = "cox_oakes"
)
```
