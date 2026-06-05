# Traditional Methods for Estimating Survival, Recruitment, and Population Growth

## Survival

The Heisey and Fuller (1985) method is a generalization of the basic
approach of Mayfield (1961) and Trent and Rongstad (1974) to determine
unbiased estimates of cause-specific mortality rates. Heisey and Fuller
(1985) also developed a computer program MICROMORT to perform the
calculations.

The Heisey and Fuller (1985) method can be described by the following
equations where the subscript i\\ (i = 1, 2, ..., I) indicates the ith
interval being considered. The maximum likelihood estimate for survival
in the ith interval (\hat{s}\_i) is given by the following equation
where x_i is the total number of transmitter days (number of collar
animals multiplied by the number of days) and y_i is the total number of
deaths

\hat{s}\_i = \frac{x_i - y_i}{x_i}

Where L_i is the length of days in the interval then the estimated
survival rate (\hat{S}\_i) for the ith interval is

\hat{S}\_{i} = \hat{s}\_{i}^{L\_{i}} The total survival rate, S^{\*},
over all, I, intervals is simply the product of the \hat{S}\_{i}’s

\hat{S}^{\*} = \prod\_{i=1}^{I}{\hat{S}\_{i}}

The standard error is calculated using the Taylor series approximation
method. The sampling distribution of \hat{S}^{\*} is quite skewed
therefore the 95% Wald confidence interval (Millar 2011) is calculated
on the log scale (before being back-transformed)

\log(\hat{S}^\*) \pm 1.96 \\ \hat{S}^{\*-1} \\ \text{SE}(\hat{S}^{\*})

The nonparametric staggered entry Kaplan-Meier, which uses discrete time
steps, is defined algebraically below (Pollock et al. 1989). The
probability of surviving in the ith timestep is given by the equation

\hat{S}\_i = 1 - \frac{d_i}{r_i}

where d_i is the number of mortalities during the period and r_i is the
number of collared individuals at the start of period. The estimated
survival for any arbitrary time period t is given by

\hat{S}(t) = \prod\_{i=1}{(\hat{S}\_{i,t})} where \hat{S}\_{i,t} is the
survival during the ith timestep of the tth period.

One method to estimate the standard error (Cox and Oakes 1984) uses
Greenwood’s formula

\text{SE}(\hat{S}(t)) = \sqrt{\[\hat{S}(t)\]^2
\sum{\frac{d\_{i}}{r\_{i}(r\_{i} - d\_{i})}}}

However they also propose a simpler alternative estimate “which is
better in the tails of the distribution” (Pollock et al. 1989)

SE(\hat{S}(t)) = \sqrt{ \frac{\[\hat{S}(t)\]^2 - \[1 -
\hat{S}(t)\]}{r(t)}}

Although Pollock et al. (1989) proposed calculating 95% Wald confidence
intervals (Millar 2011) this formulation can result in lower confidence
limits below zero or upper confidence limits above one when using the
standard equation

\hat{S}(t) \pm 1.96 \\ \text{SE} (\hat{S}(t)) Confidence intervals were
also computed using bootstrapping with 1,000 (McLoughlin et al. 2003) or
10,000 replicates (Hervieux et al. 2013).

To account for censoring DeCesare et al. (2012) estimated female
survival with nonparametric methods and “then adjusted the input annual
sample sizes of animals and survival events to produce equivalent mean
and variance estimates using a binomial variance estimator (Morris and
Doak 2002)” (DeCesare et al. 2012).

There are other less used methods like the Skalski staggered entry
equation (Skalski et al. 2005) and the known fate binomial model in
program MARK. The known fate model provides a similar estimate to the
Kaplan-Meier estimator when it is constrained to estimate yearly
survival from the product of monthly survival rates. The advantage of
the known fate approach is it allows comparison of alternative models
with, for example, constant survival vs yearly and/or monthly variation.
As well as the Heisey and Fuller method, Edmonds (1988) also used the
method described by Gasaway et al. (1983) to provide estimates and
confidence intervals.

## Recruitment

The mean ratio, \hat{R}, can be calculated from, \bar{y}, the mean
number of calves and, \bar{c}, the mean number of cows (Cochran 1977;
Thompson 1992; Krebs 1999)

\hat{R} = \frac{\bar{y}}{\bar{c}} Recruitment rates were adjusted by
DeCesare et al. (2012) to provide an estimate of recruitment that
assumes the calves surveyed in the March surveys have recruited to
adults. DeCesare et al. (2012) argued uncorrected calf-cow ratios did
not account for recruits at year end and therefore provide an
overoptimistic estimate of recruitment and subsequent population trend.
In the equation derived by DeCesare et al. (2012), the age ratio, X, is
commonly estimated as the number of calves, n\_{j}, per adult female,
n\_{af}, observed at the end of a measured year, such that

X = \frac{n\_{j}}{n\_{af}} and \frac{X}{2} = \frac{n\_{jf}}{n\_{af}}

where X/2 estimates the number of female calves (n\_{jf}) per adult
female assuming a 50:50 sex ratio, proper adjustments of X/2 to a
calves/(calves + adults) ratio is necessary according to

R\_{RM} = \frac{n\_{jf}}{n\_{f}} = \frac{ \frac{X}{2} }{1 + \frac{X}{2}}

Where n\_{f} = n\_{jf} + n\_{af}, or the total number of females of all
age classes, including calves, counted at the end of the measurement
year.

The standard error of R as defined by the ratio (x/y) is given by

SE(\hat{R}) = \frac{\sqrt{1-f}}{\sqrt{n}y}
\sqrt{\frac{(1-f)(\sum{x^{2}-2\hat{R}}
\sum{xy+\hat{R}^{2}\sum{y^{2}}})}{n-1}}

Where f is the sampling fraction n/N, n is the sample size, N is the sum
of the sample sizes, and \bar{y} is the observed mean of Y measurement
(denominator of ratio) (Cochran 1977; Thompson 1992; Krebs 1999).

Bootstrapping was used to generate confidence intervals using 1,000
(McLoughlin et al. 2003) and 10,000 replicates (Hervieux et al. 2013,
2014).

A binomial distribution was used by Rettie and Messier (1998).

## Population Growth

The three main methods used for calculating, \lambda, population growth
are the original recruitment-mortality R/M formula described by Hatter
and Bergerud (1991) using raw calf cow ratios of R; the adjusted
recruitment R\_{RM} formula of DeCesare et al. (2012) and a Lefkovich
matrix model (Fryxell et al. 2020)

The original recruitment-mortality formula of Hatter and Bergerud (1991)

\lambda = \frac{S}{1-R}

The adjusted recruitment rate of DeCesare et al. (2012) will provide a
better estimate of \lambda then using uncorrected calf-cow ratios from
spring surveys (as discussed in the recruitment section).

A Lefkovich matrix (Fryxell et al. 2020) which estimates lambda based on
the maximum eigenvalue of a Lefkovich matrix of stage-based survival and
birth rates. Where the matrix-based population viability analysis (PVA)
model used population-wide estimate of annual survival of adult and
yearling females (S) and successful offspring recruitment (S \times B,
where B is birth rate of female offspring) in each study area to fill
the elements of a Lefkovich matrix (L) where B\_{j} is offspring
recruitment rate stemming from age class j, and S\_{j} is the annual
survival rate of age class j, where j=0,1 and a for new-born calves,
yearlings, and adults (Fryxell et al. 2020).

L = \left\[\begin{array}{ccc} 0 & S_1 \times B_1 & S_a \times B_a \\ S_0
& 0 & 0 \\ 0 & S_1 & S_a \end{array} \right\]

DeCesare et al. (2012) also considered stage-based matrix models and
provides discussion on how matrix models relate to the standard S/(1-R)
equation.

Confidence intervals for population growth were calculated through
simulation. One way was through Monte Carlo simulations by randomly
drawing from the annual survival and recruitment distributions (Rettie
and Messier 1998; Hervieux et al. 2013, 2014) using programs like
Excel’s MATLAB or Poptools. Another method was through bootstrapping
(McLoughlin et al. 2003).

## References

Cochran, William Gemmell. 1977. *Sampling Techniques*. 3rd ed. Wiley
Series in Probability and Mathematical Statistics. Wiley.

Cox, D. R., and David Oakes. 1984. *Analysis of Survival Data*.
Monographs on Statistics and Applied Probability. Chapman; Hall.

DeCesare, Nicholas J., Mark Hebblewhite, Mark Bradley, Kirby G. Smith,
David Hervieux, and Lalenia Neufeld. 2012. “Estimating Ungulate
Recruitment and Growth Rates Using Age Ratios.” *The Journal of Wildlife
Management* 76 (1): 144–53. <https://doi.org/10.1002/jwmg.244>.

Edmonds, E. Janet. 1988. “Population Status, Distribution, and Movements
of Woodland Caribou in West Central Alberta.” *Canadian Journal of
Zoology* 66 (4): 817–26. <https://doi.org/10.1139/z88-121>.

Fryxell, John M., Tal Avgar, Boyan Liu, et al. 2020. “Anthropogenic
Disturbance and Population Viability of Woodland Caribou in Ontario.”
*The Journal of Wildlife Management* 84 (4): 636–50.
<https://doi.org/10.1002/jwmg.21829>.

Gasaway, William, Robert Stephenson, James Davis, Peter Shepherd, and
Oliver Burris. 1983. *Interrelationships of Wolves, Prey and Man in
Interior Alaska*. 84: 1–50.

Hatter, Ian, and Wendy Bergerud. 1991. *Moose Recuriment Adult Mortality
and Rate of Change*. 27: 65–73.

Heisey, Dennis M., and Todd K. Fuller. 1985. “Evaluation of Survival and
Cause-Specific Mortality Rates Using Telemetry Data.” *The Journal of
Wildlife Management* 49 (3): 668. <https://doi.org/10.2307/3801692>.

Hervieux, D., Mark Hebblewhite, Dave Stepnisky, Michelle Bacon, and Stan
Boutin. 2014. “Managing Wolves (Canis Lupus) to Recover Threatened
Woodland Caribou (Rangifer Tarandus Caribou) in Alberta.” *Canadian
Journal of Zoology* 92 (12): 1029–37.
<https://doi.org/10.1139/cjz-2014-0142>.

Hervieux, D., M. Hebblewhite, N. J. DeCesare, et al. 2013. “Widespread
Declines in Woodland Caribou ( *Rangifer* *Tarandus* *Caribou* )
Continue in Alberta.” *Canadian Journal of Zoology* 91 (12): 872–82.
<https://doi.org/10.1139/cjz-2013-0123>.

Krebs, Charles J. 1999. *Ecological Methodology*. 2nd ed.
Benjamin/Cummings.

Mayfield, Harold. 1961. “Nesting Success Calculated from Exposure.” *THE
WILSON BULLETIN* 73 (3): 7.

McLoughlin, Philip D., Elston Dzus, Bob Wynes, and Stan Boutin. 2003.
“Declines in Populations of Woodland Caribou.” *The Journal of Wildlife
Management* 67 (4): 755. <https://doi.org/10.2307/3802682>.

Millar, R. B. 2011. *Maximum Likelihood Estimation and Inference: With
Examples in R, SAS, and ADMB*. Statistics in Practice. Wiley.

Morris, William F., and Daniel F. Doak. 2002. *Quantitative Conservation
Biology: Theory and Practice of Population Viability Analysis*. Sinauer
Associates.

Pollock, Kenneth H., Scott R. Winterstein, Christine M. Bunck, and Paul
D. Curtis. 1989. “Survival Analysis in Telemetry Studies: The Staggered
Entry Design.” *The Journal of Wildlife Management* 53 (1): 7.
<https://doi.org/10.2307/3801296>.

Rettie, W James, and François Messier. 1998. *Dynamics of Woodland
Caribou Populations at the Southern Limit of Their Range in
Saskatchewan*. 76: 9.

Skalski, J. R., Kristen E. Ryding, and Joshua J. Millspaugh. 2005.
*Wildlife Demography: Analysis of Sex, Age, and Count Data*. Elsevier
Academic Press.

Thompson, Steven K. 1992. *Sampling*. Wiley Series in Probability and
Mathematical Statistics. Wiley.

Trent, Tracey T., and Orrin J. Rongstad. 1974. “Home Range and Survival
of Cottontail Rabbits in Southwestern Wisconsin.” *The Journal of
Wildlife Management* 38 (3): 459. <https://doi.org/10.2307/3800877>.
