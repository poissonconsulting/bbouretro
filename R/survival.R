# Copyright 2024 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Estimate survival
#'
#' Estimate survival rates based on the Kaplan-Meier survival rate estimator
#' (Pollock et al. 1989).
#'
#' @param x A data frame that has survival data.
#' @param mort_type Mortality data to be included. Values can be `"total"` which
#'   would be all mortalities (MortalitiesCertain and MortalitiesUncertain) or
#'   only `"certain"` mortalities (MortalitiesCertain). The default is
#'   `"total"`.
#' @param variance Variance type to estimate. Can be the Greenwood estimator
#'   `"greenwood"` or Cox Oakes estimator `"cox_oakes"`. The default is
#'   "greenwood".
#' @param year_start A whole number between 1 and 12 indicating the month of the
#'   start of the caribou (i.e., biological) year. By default, April is set as
#'   the start of the caribou year.
#'
#' @details `x` needs to be formatted in a certain manner. To confirm the input
#'   data frame is in the right format you can use the
#'   [`bbd_chk_data_survival`](https://poissonconsulting.github.io/bboudata/reference/bbd_chk_data_survival.html)
#'   function. See the `vignette("methods", package = "bbouretro")` for the
#'   equations used in this function.
#'
#' @return A data frame. The columns are listed in the format section.
#' @export
#'
#' @format The return object has these columns:
#' \describe{
#' \item{PopulationName}{Population name}
#' \item{Year}{Year sampled}
#' \item{estimate}{Survival estimate }
#' \item{se}{SE}
#' \item{lower}{Confidence limit}
#' \item{upper}{Confidence limit}
#' \item{mean_monitored}{Mean number of caribou monitored each month}
#' \item{sum_dead }{Total number of mortalities in a year}
#' \item{sum_alive}{Total number of caribou-months in a year}
#' \item{status}{Indicates less than 12 months monitored or if there were 0 mortalities in a given year}
#' }
#'
#' @references Pollock, K. H., S. R. Winterstein, C. M. Bunck, and P. D. Curtis.
#'   1989. Survival analysis in telemetry studies: the staggered entry design.
#'   Journal of Wildlife Management 53:7-15.
#'
#' @examples
#' survival_est <- bbr_survival(
#'   bboudata::bbousurv_a,
#'   mort_type = "total",
#'   variance = "greenwood"
#' )
#' survival_est <- bbr_survival(
#'   bboudata::bbousurv_b,
#'   mort_type = "certain",
#'   variance = "cox_oakes"
#' )
bbr_survival <- function(x, mort_type = "total", variance = "greenwood", year_start = 4L) {
  x <- bboudata::bbd_chk_data_survival(x)
  chk::chk_string(mort_type)
  chk::chk_string(variance)
  chk::chk_whole_number(year_start)
  chk::chk_range(year_start, c(1, 12))

  # make sure data set is sorted properly
  x <- dplyr::arrange(x, .data$Year, .data$Month)
  # Tally total mortalities.
  x$TotalMorts <- x$MortalitiesCertain + x$MortalitiesUncertain

  # mort_type can be "total" or "certain"
  x$mort_type <- mort_type
  x$Morts <- ifelse(x$mort_type == "total", x$TotalMorts, x$MortalitiesCertain)

  # Months with 0 collars monitored are removed but this is noted to user later
  # and estimates scaled appropriately
  x <- subset(x, x$StartTotal > 0)

  # set caribou year
  x$Year <- caribou_year(x$Year, x$Month, year_start = year_start)

  # calculate monthly components of survival and variance
  LiveDeadCount <- dplyr::mutate(
    x,
    Smonth = (1 - (.data$Morts / .data$StartTotal)),
    Smonth_varj = .data$Morts / (.data$StartTotal * (.data$StartTotal - .data$Morts))
  )

  YearSurv <-
    LiveDeadCount |>
    dplyr::group_by(.data$Year) |>
    dplyr::summarise(
      S = prod(.data$Smonth),
      S_var1 = sum(.data$Smonth_varj),
      Survmean = mean(.data$Smonth),
      sum_alive = sum(.data$StartTotal),
      sum_dead = sum(.data$Morts),
      meanalive = mean(.data$StartTotal),
      minalive = min(.data$StartTotal),
      maxalive = max(.data$StartTotal),
      monthcount = length(.data$Year)
    ) |>
    dplyr::ungroup()

  YearSurv$VarType <- variance

  # Variance estimate using the Greenwood formula for variance
  YearSurv$S_Var_Green <- YearSurv$S^2 * YearSurv$S_var1
  # Variance estimate using the Pollock et al 1989 method
  YearSurv$S_Var_Pollock <- (YearSurv$S^2 * (1 - YearSurv$S)) / YearSurv$sum_alive
  YearSurv$S_Var <- ifelse(
    YearSurv$VarType == "cox_oakes",
    YearSurv$S_Var_Pollock,
    YearSurv$S_Var_Green
  )

  # Put note in output if there are no mortalities or less than 12 years.
  # Zero mortalities causes variance to be 0
  YearSurv$Status1 <- ifelse(
    YearSurv$monthcount == 12,
    "",
    paste("Only", YearSurv$monthcount, "months monitored")
  )
  YearSurv$Status2 <- ifelse(
    YearSurv$sum_dead == 0,
    "No Mortalities all year (SE=0)",
    ""
  )
  YearSurv$status <- paste(YearSurv$Status1, "-", YearSurv$Status2)

  # scale estimates to a year if less than 12 months monitored
  YearSurv$S <- YearSurv$S^(12 / YearSurv$monthcount)
  YearSurv$S_Var <- YearSurv$S_Var^(12 / YearSurv$monthcount)
  YearSurv$S_SE <- YearSurv$S_Var^0.5

  # logit-based confidence intervals--formulas based on program MARK.
  YearSurv <- dplyr::mutate(
    YearSurv,
    logits = logit(.data$S),
    selogit = logit_se(.data$S_SE, .data$S)
  )
  YearSurv$S_CIU <- ilogit(wald_cl(YearSurv$logits, YearSurv$selogit, upper = TRUE))
  YearSurv$S_CIL <- ilogit(wald_cl(YearSurv$logits, YearSurv$selogit, upper = FALSE))

  # round estimates for table.
  YearSurv$mean_monitored <- round(YearSurv$meanalive, 1)
  YearSurv$S <- round(YearSurv$S, 3)
  YearSurv$S_SE <- round(YearSurv$S_SE, 3)
  YearSurv$S_CIL <- round(YearSurv$S_CIL, 3)
  YearSurv$S_CIU <- round(YearSurv$S_CIU, 3)

  YearSurv <-
    YearSurv |>
    dplyr::mutate(
      PopulationName = unique(x$PopulationName)
    ) |>
    dplyr::select(
      "PopulationName",
      "CaribouYear" = "Year",
      "estimate" = "S",
      "se" = "S_SE",
      "lower" = "S_CIL",
      "upper" = "S_CIU",
      "mean_monitored",
      "sum_dead",
      "sum_alive",
      "status"
    ) |>
    tibble::tibble()

  YearSurv
}
