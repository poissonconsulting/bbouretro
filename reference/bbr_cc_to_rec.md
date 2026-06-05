# Calf Cow Ratio to Recruitment

The calf cow ratios is simply the number of calves divided by the number
of cows. As described by DeCesare et al. (2012) in order to convert the
calf cow ratio to the female recruitment rate it is necessary to
multiple the calf cow ratio by the sex ratio to get the female calf to
cow ratio and then divide that number by itself plus 1 to get the female
recruitment rate ie female calves divided by all females. To perform the
inverse conversion see
[`bbr_rec_to_cc()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_rec_to_cc.md)

## Usage

``` r
bbr_cc_to_rec(x, sex_ratio = 0.5)
```

## Arguments

- x:

  A numeric vector of the calf:cow ratio

- sex_ratio:

  A

## Value

A numeric vector of the equivalent recruitment rate

## See also

[`bbr_rec_to_cc()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_rec_to_cc.md)

## Examples

``` r
bbr_cc_to_rec(c(0, 1, 0.5, NA))
#> [1] 0.0000000 0.3333333 0.2000000        NA
```
