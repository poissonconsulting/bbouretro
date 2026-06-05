# Estimate Calf-Cow Ratio.

Estimate Calf-Cow Ratio.

## Usage

``` r
bbr_calf_cow_ratio(
  x,
  adult_female_proportion = 0.65,
  sex_ratio = 0.5,
  variance = "bootstrap",
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

  Calf-Cow ratio estimate

- lower:

  Confidence limit

- upper:

  Confidence limit

- groups:

  Groups sampled

- female_calves:

  Estimated female calves

- females:

  Estimated adult females

## Arguments

- x:

  A data frame that has recruitment data.

- adult_female_proportion:

  Assumed or estimated proportion of females in the population used to
  assign unknown sex caribou. Values must be between 0 and 1. Can be set
  to 0 to exclude unknown sex caribou from recruitment estimates. The
  default is set at 0.65.

- sex_ratio:

  Sex ratio of caribou at birth used to assign calves and yearlings as
  male or female. Sex ratio is defined as the proportion females at
  birth. Values must be between 0 and 1. The default is set at 0.5.

- variance:

  Estimate variance using "binomial" or "bootstrap". The default is set
  as "bootstrap".

- year_start:

  A whole number between 1 and 12 indicating the month of the start of
  the caribou (i.e., biological) year. By default, April is set as the
  start of the caribou year.

## Value

A data frame. The columns are listed in the format section.

## Details

`x` needs to be formatted in a certain manner. To confirm the input data
frame is in the right format you can use the
[`bbd_chk_data_recruitment`](https://poissonconsulting.github.io/bboudata/reference/bbd_chk_data_recruitment.html)
function. See the `vignette("methods", package = "bbouretro")` for the
equations used in this function.

User’s can input the assumed proportion of females in the population (to
estimate females from adult caribou that have unknown sex) as well as
sex ratio at birth.

## Examples

``` r
calfcow_est <- bbr_calf_cow_ratio(
  bboudata::bbourecruit_a,
  adult_female_proportion = 0.65,
  sex_ratio = 0.5,
  variance = "binomial"
)
calfcow_est <- bbr_calf_cow_ratio(
  bboudata::bbourecruit_a,
  adult_female_proportion = 0.60,
  sex_ratio = 0.65,
  variance = "bootstrap"
)
```
