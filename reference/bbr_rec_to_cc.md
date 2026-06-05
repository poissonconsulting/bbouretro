# Recruitment to Calf Cow Ratio

Converts the female recruitment rate to the calf cow ratio. For further
information see
[`bbr_cc_to_rec()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_cc_to_rec.md).

## Usage

``` r
bbr_rec_to_cc(x, sex_ratio = 0.5)
```

## Arguments

- x:

  A numeric vector of the recruitment rate

- sex_ratio:

  A

## Value

A numeric vector of the equivalent calf:cow ratio

## See also

[`bbr_cc_to_rec()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_cc_to_rec.md)

## Examples

``` r
bbr_rec_to_cc(c(0, 1, 0.5, NA))
#> [1]    0 -Inf    2   NA
```
