% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot-growth.R
\name{bbr_plot_growth}
\alias{bbr_plot_growth}
\title{Plot population growth}
\usage{
bbr_plot_growth(growth)
}
\arguments{
\item{growth}{A data frame generated by \code{bbr_growth()}.}
}
\value{
A ggplot object.
}
\description{
A plot of population growth (\eqn{\lambda}) estimates is given for the
population unit.
}
\examples{
\dontrun{
recruitment_est <- bbr_recruitment(bboudata::bbourecruit_a)
survival_est <- bbr_survival(bboudata::bbousurv_a)
growth_est <- bbr_growth(survival_est, recruitment_est)

bbr_plot_growth(growth_est)
}
}
