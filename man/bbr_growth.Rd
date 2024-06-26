% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/growth.R
\name{bbr_growth}
\alias{bbr_growth}
\title{Simulate population growth}
\usage{
bbr_growth(survival, recruitment)
}
\arguments{
\item{survival}{A data frame generated by \code{bbr_survival()}.}

\item{recruitment}{A data frame generated by \code{bbr_recruitment()}.}
}
\value{
A data.frame.
}
\description{
This function uses the output of \code{bbr_survival()} and \code{bbr_recruitment()} to
estimate population growth (\eqn{\lambda}) using the Hatter-Bergerud equation
(Hatter and Bergerud, 1991). Monte Carlo simulation is used to generate
confidence limits.
}
\details{
See the \code{vignette("methods", package = "bbouretro")} for
descriptions of the equations used. The raw_values can be plotted using
\code{bbr_plot_growth_distributions()} and the summary data frame can be output
using \code{bbr_growth_summarize()} or plotted using \code{bbr_plot_growth()}.
}
\examples{
\dontrun{
recruitment_est <- bbr_recruitment(bboudata::bbourecruit_a)
survival_est <- bbr_survival(bboudata::bbousurv_a)

growth_est <- bbr_growth(survival_est, recruitment_est)
}
}
\references{
Hatter, Ian, and Wendy Bergerud. 1991. “Moose Recruitment, Adult
Mortality and Rate of Change” 27: 65–73.
}
