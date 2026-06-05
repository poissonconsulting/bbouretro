# Methods used in \`bbouretro\` for Estimating Survival, Recruitment, and Population Growth

There are multiple ways cited in literature to calculate survival,
recruitment, and population growth. The traditional or **retro** methods
used in bbou**retro** are outlined below.

## Survival

The
[`bbr_survival()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_survival.md)
function uses the staggered entry Kaplan-Meier method.

The staggered entry Kaplan-Meier, which uses discrete time steps, is
defined algebraically below (Pollock et al. 1989). The probability of
surviving in the ith time step (usually month) is given by the equation
below

\hat{S}\_{i} = 1 - \frac{d\_{i}}{r\_{i}}

where d\_{i} is the number of mortalities during the period and r\_{i}
is the number of collared individuals at the start of period. The
estimated survival for any arbitrary time period t (usually year) is
given by

\hat{S}(t) = \prod\_{i=1}(\hat{S}\_{i,t})

where S is the survival during the ith time step of the tth period.

Standard error is estimated using the Greenwood’s formula (Cox and Oakes
1984).

SE(\hat{S}(t)) = \sqrt{\[\hat{S}(t)\]^2 \sum
\frac{d\_{i}}{r\_{i}(r\_{i} - d\_{i})}}

Cox and Oakes (1984) propose a simple binomial variance formula “which
is better in the tails of the distribution” (Pollock et al. 1989).

SE(\hat{S}(t)) = \sqrt{ \frac{\[\hat{S}(t)\]^2 -
\[1-\hat{S}(t)\]}{r(t)}}

Logit-based confidence limits are estimated using the Wald method.
Further details on the Kaplan-Meier approach as applied in boreal
caribou studies are given in `vignette("previous-methods")`.

## Recruitment

The
[`bbr_recruitment()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_recruitment.md)
function estimates recruitment using the following method.

Estimation of recruitment follows methods of DeCesare et al. (2012).

The age ratio, X, is commonly estimated as the number of calves, n{\_j},
per adult female, n\_{af}, observed at the end of a measured year, such
that

X = \frac{n_j}{n\_{af}}

where X \cdot sex\\ratio estimates the number of female calves (n\_{jf})
per adult female.

Recruitment is estimated using the equation below which accounts for
recruitment of calves into the yearling/adult age class at the end of
the caribou year.

R\_{RM} = \frac{X \cdot sex\\ratio}{1 + X \cdot sex\\ratio}

Variance is estimated using a bootstrap approach or the binomial method.

The bootstrap approach randomly resamples groups for 1000 iterations to
create 1000 estimates of calf cow ratio and recruitment.
Percentile-based 95% confidence limits are then estimated from the 1000
estimates.

For the binomial method, variance is estimated as (R_m \cdot (1 -
R\_{rm})/n) where n is the number of adult females sampled during each
yearly survey.

It is assumed that both survival and recruitment are independently
distributed on the logit scale therefore bounding each value between 0
and 1. The bootstrap method is recommended as the most robust approach
to obtain variance estimates (Manly 1997).

## Population Growth

For
[`bbr_growth()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_growth.md)
function uses the basic Hatter-Bergerud method (Hatter and Bergerud
1991).

The basic Hatter-Bergerud equation used to estimate \lambda is given
below.

\lambda = \frac{(S)}{(1 - R)}

The standard errors on estimates of survival and recruitment are then
used to create simulated distributions of S and R and derive a
distribution of \lambda based on the simulated values. It is assumed
both survival and recruitment are distributed on the logit scale
therefore bounding each value between 0 and 1.

One thousand simulations are conducted. Percentile-based confidence
limits are then derived. Also, the proportion of simulations where
\lambda is greater than 1 is tabulated to provide a p-value for the
hypothesis test (Ho: \lambda \>= 1, Ha: \lambda \< 1).

Output summaries also include mean values simulated for S, R, as well as
mean and median \lambda values from the simulation.

Users can generate plots of simulated lambda values using the
[`bbr_plot_growth_distributions()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_plot_growth_distributions.md)
or yearly estimates using
[`bbr_plot_growth()`](https://poissonconsulting.github.io/bbouretro/reference/bbr_plot_growth.md).

## References

Cox, D. R., and David Oakes. 1984. *Analysis of Survival Data*.
Monographs on Statistics and Applied Probability. Chapman; Hall.

DeCesare, Nicholas J., Mark Hebblewhite, Mark Bradley, Kirby G. Smith,
David Hervieux, and Lalenia Neufeld. 2012. “Estimating Ungulate
Recruitment and Growth Rates Using Age Ratios.” *The Journal of Wildlife
Management* 76 (1): 144–53. <https://doi.org/10.1002/jwmg.244>.

Hatter, Ian, and Wendy Bergerud. 1991. *Moose Recuriment Adult Mortality
and Rate of Change*. 27: 65–73.

Manly, B. F. J. 1997. *Randomization and Monte Carlo Methods in
Biology*. Chapman; Hall.

Pollock, Kenneth H., Scott R. Winterstein, Christine M. Bunck, and Paul
D. Curtis. 1989. “Survival Analysis in Telemetry Studies: The Staggered
Entry Design.” *The Journal of Wildlife Management* 53 (1): 7.
<https://doi.org/10.2307/3801296>.
