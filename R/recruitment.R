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

#' Calculate recruitment
#'
#' This function generates estimates of recruitment from the Recruitment data
#' frame with confidence limits. User’s can input the assumed proportion of
#' females in the population (to estimate females from adult caribou that have
#' unknown sex) as well as sex ratio at birth. Variance can be estimated using a
#' few different approaches.
#'
#' @param x input recruitment data frame.
#' @param p_females Assumed or estimated proportion females in the population
#'   used to assign unknown sex caribou (see details).  Can be set to 0 to
#'   exclude unknown sex caribou from recruitment estimates.
#' @param sexratio Sex ratio of caribou at birth used to assign calves and
#'   yearlings as male or female (see details).  Sex ratio is defined as the
#'   proportion females at birth.  Usually this is set at 0.5.
#' @param variance Estimate variance using “binomial” or “bootstrap”.
#'
#' @details
#' See the vignette Methods for description of equations used.
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
#' \item{p_females}{Input proportion adult females}
#' }
#' @export
#'
#' @examples
#' recruitment_est <- bbr_recruitment(
#'   bboudata::bbourecruit_a,
#'   p_females = 0.65,
#'   sexratio = 0.5,
#'   variance = "binomial"
#' )
#' recruitment_est <- bbr_recruitment(
#'   bboudata::bbourecruit_a,
#'   p_females = 0.60,
#'   sexratio = 0.65,
#'   variance = "bootstrap"
#' )
bbr_recruitment <- function(x, p_females, sexratio, variance) {
  x <- bboudata::bbd_chk_data_recruitment(x)
  chk::chk_range(p_females)
  chk::chk_range(sexratio)
  chk::chk_string(variance)

  # Estimate total females based on p_females and sexratio
  x <- dplyr::mutate(
    x,
    Females = .data$Cows + .data$UnknownAdults * p_females + .data$Yearlings * sexratio,
    FemaleCalves = .data$Calves * sexratio
  )

  # summarize by population and year
  Compfull <-
    x |>
    dplyr::group_by(.data$PopulationName, .data$Year) |>
    dplyr::summarize(
      Females = sum(.data$Females),
      FemaleCalves = sum(.data$FemaleCalves),
      Calves = sum(.data$Calves),
      UnknownAdults = sum(.data$UnknownAdults),
      Bulls = sum(.data$Bulls),
      Yearlings = sum(.data$Yearlings),
      groups = length(.data$Year)
    ) |>
    dplyr::group_by()

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
    Compfull <- dplyr::mutate(
      Compfull,
      logits = log(.data$R / (1 - .data$R)),
      varlogit = .data$BinVar / (.data$R^2 * ((1 - .data$R)^2))
    )
    Compfull$R_CIU <- 1 / (1 + exp(-1 * (Compfull$logits + 1.96 * (Compfull$varlogit**0.5))))
    Compfull$R_CIL <- 1 / (1 + exp(-1 * (Compfull$logits - 1.96 * (Compfull$varlogit**0.5))))
  }

  # bootstrap approach...in progress....
  if (variance == "bootstrap") {
    # bootstrap by Population and year
    boot_names <- expand.grid(unique(x$PopulationName), unique(x$Year))
    boot_names <- sort(sprintf("%s.%s", boot_names[, 1], boot_names[, 2]))
    boot <-
      x |>
      dplyr::group_split(
        .data$PopulationName, .data$Year
      ) |>
      purrr::set_names(boot_names) |>
      purrr::map(
        function(x) boot(data = x, RecCalc, R = 1000)
      )

    pc <- purrr::map_df(names(boot), function(x) {
      boots <- boot[[x]]$t
      year <- strsplit(x, split = "\\.")[[1]][2]
      pop <- strsplit(x, split = "\\.")[[1]][1]
      quants <- quantile(boots, c(0.025, 0.5, 0.975))
      SE <- sd(boots)
      tibble::tibble(
        PopulationName = pop,
        Year = year,
        medianboot = quants[2],
        R_SE = SE,
        R_CIL = quants[1],
        R_CIU = quants[3]
      )
    })

    Compfull <- merge(
      Compfull,
      pc[c("PopulationName", "Year", "R_SE", "R_CIL", "R_CIU")],
      by = c("PopulationName", "Year")
    )
  }


  # An abbreviated output data set.
  CompfullR <- cbind(
    Compfull[c("PopulationName", "Year", "R", "R_SE", "R_CIL", "R_CIU", "groups", "FemaleCalves", "Females")],
    sexratio,
    p_females
  )

  CompfullR[c(3:6)] <- round(CompfullR[c(3:6)], 3)

  CompfullR
}
