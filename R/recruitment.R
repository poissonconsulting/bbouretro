#' Calculate recruitment
#'
#' This function generates estimates of recruitment from the Recruitment data
#' frame with confidence limits.   User’s can input the assumed proportion of
#' females in the population (to estimate females from adult caribou that have
#' unknown sex) as well as sex ratio at birth. Variance can be estimated using a
#' few different approaches.
#'
#' @param x input recruitment data frame
#' @param pFemales Assumed or estimated proportion females in the population
#'   used to assign unknown sex caribou (see details).  Can be set to 0 to
#'   exclude unknown sex caribou from recruitment estimates
#' @param sexratio Sex ratio of caribou at birth used to assign calves and
#'   yearlings as male or female (see details).  Sex ratio is defined as the
#'   proportion females at birth.  Usually this is set at 0.5.
#' @param variance Estimate variance using “binomial” or “bootstrap”
#'
#' @details Estimation of recruitment follows methods of (DeCesare et al. 2012).
#' From Pearson et al (2022) we summarize the following equations: The age
#' ratio, \eqn{X}, is commonly estimated as the number of calves,\eqn{n_j} ,
#' per adult female, \eqn{n_af}, observed at the end of a measured year, such
#' that \eqn{X = n_j / n_af} where \eqn{X * sexratio} estimates the number of
#' female calves \eqn{(n_jf)} per adult female. Recruitment is estimated using
#' the equation below which accounts for recruitment of calves into the
#' yearling/adult age class at the end of the caribou year. \eqn{R_RM = X *
#' sexration / a + X * sexratio} Variance is estimated using a bootstrap
#' approach or the binomial method.    The bootstrap approach randomly resamples
#' groups for 1000 iterations to create 1000 estimates of calf cow ratio and
#' recruitment.   Percentile-based 95% confidence limits are then estimated from
#' the 1000 estimates.  For the binomial method, variance is estimated as
#' \eqn{R_m * (1 - R_rm)/n)} where \eqn{n} is the number of adult females
#' sampled during each yearly survey.  Logit-based confidence limits are
#' estimated assuming that values of recruitment are constrained between 0 and
#' 1.  The bootstrap method is recommended as the most robust approach to obtain
#' variance estimates. A full summary of methods is given in (Pearson et al.
#' 2022).
#'
#' @return An output data frame with the columns.
#'
#' @format A tibble with columns:
#' \describe{
#' \item{PopulationName}{Population name}
#' \item{Year}{Year sampled}
#' \item{R}{Recruitment estimate }
#' \item{R_SE}{SE}
#' \item{R_CIL}{Confidence limit}
#' \item{R_CIU}{Confidence limit}
#' \item{groups}{Groups sampled}
#' \item{FemaleCalves}{Estimated female calves}
#' \item{Females}{Estimated adult females}
#' \item{sexratio}{Input sex ratio}
#' \item{pFemales}{Input proportion adult females}
#' }
#' @export
#'
#' @references DeCesare, N. J., M. Hebblewhite, M. Bradley, K. G. Smith, D.
#' Hervieux, and L. Neufeld. 2012. Estimating ungulate recruitment and growth
#' rates using age ratios. The Journal of Wildlife Management 76:144-153.
#' Pearson, A., J. Boulanger, and J. L. Thorley. 2022. Boreal Caribou Monitoring
#' – Literature Review of Current and Historical Data Collection and Analysis
#' Methods Used to Estimate Survival, Recruitment, and Population Growth.
#'
#' @examples
#' recruitment_estimate <- recruitment(bboudata::bbourecruit_a, pFemales = 0.65, sexratio = 0.5, variance <- "binomial")
recruitment <- function(x, pFemales, sexratio, variance) {
  # Estimate total females based on pFemales and sexratio
  x <- transform(
    x,
    Females = Cows + UnknownAdults * pFemales + Yearlings * sexratio,
    FemaleCalves = Calves * sexratio
  )

  # summarize by population and year
  Compfull <- ddply(
    x,
    c("PopulationName", "Year"),
    summarize,
    Females = sum(Females),
    FemaleCalves = sum(FemaleCalves),
    Calves = sum(Calves),
    UnknownAdults = sum(UnknownAdults),
    Bulls = sum(Bulls),
    Yearlings = sum(Yearlings),
    groups = length(Year)
  )

  # Estimate recruitment based on full data set.
  # Calf cow based on male/female calves
  Compfull$CalfCow <- Compfull$Calves / Compfull$Females
  # Calf cow for female calves is 1/2 of CC with female/male calves
  Compfull$CalfCowF <- Compfull$CalfCow * sexratio
  # Recruitment using DeCesare correction
  Compfull$R <- Compfull$CalfCowF / (1 + Compfull$CalfCowF)

  # variance estimation-in progress.....
  # simple binomial variance estimate-right now uses females but may not be statistically correct!
  if (variance == "binomial") {
    Compfull$BinVar <- (Compfull$R * (1 - Compfull$R)) / Compfull$Females
    Compfull$R_SE <- Compfull$BinVar^0.5

    # logit-based confidence limits assuing R is constrained between 0 and 1.
    Compfull <- transform(
      Compfull,
      logits = log(R / (1 - R)),
      varlogit = BinVar / (R^2 * ((1 - R)^2))
    )
    Compfull$R_CIU <- 1 / (1 + exp(-1 * (Compfull$logits + 1.96 * (Compfull$varlogit**0.5))))
    Compfull$R_CIL <- 1 / (1 + exp(-1 * (Compfull$logits - 1.96 * (Compfull$varlogit**0.5))))
  }

  # bootstrap approach...in progress....
  if (variance == "bootstrap") {
    # a function to bootrap
    RecCalc <- function(C, indices) {
      d <- C[indices, ]
      CCF <- sum(d$FemaleCalves) / sum(d$Females)
      Rec <- CCF / (1 + CCF)
      return(Rec)
    }

    # use ddply to bootstrap by Population and year
    boot <- dlply(x, c("PopulationName", "Year"), function(x) boot(data = x, RecCalc, R = 1000))
    # need to write a way to extract SE and percentile CI's from boot list.....
  }

  # add in other formula with finite correction??  To do this would need data frame of f values......

  # An abbreviated output data set.
  CompfullR <- cbind(Compfull[c("PopulationName", "Year", "R", "R_SE", "R_CIL", "R_CIU", "groups", "FemaleCalves", "Females")], sexratio, pFemales)
  CompfullR[c(3:6)] <- round(CompfullR[c(3:6)], 3)

  CompfullR
}
