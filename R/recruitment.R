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

#' Estimate recruitment
#'
#' Estimate recruitment using DeCesare et al. (2012) methods.
#'
#' @param x A data frame that has recruitment data.
#' @param p_females Assumed or estimated proportion of females in the population
#'   used to assign unknown sex caribou. Values must be between 0
#'   and 1. Can be set to 0 to exclude unknown sex caribou from recruitment
#'   estimates. The default is set at 0.65.
#' @param sex_ratio Sex ratio of caribou at birth used to assign calves and
#'   yearlings as male or female.  Sex ratio is defined as the
#'   proportion females at birth. Values must be between 0 and 1. The default is
#'   set at 0.5.
#' @param variance Estimate variance using "binomial" or "bootstrap". The
#'   default is set as "bootstrap".
#' @param year_start A whole number between 1 and 12 indicating the start of the caribou (i.e., biological) year. By default, April is set as the start of the caribou year.
#'
#' @details `x` needs to be formatted in a certain manner. To confirm the input
#'   data frame is in the right format you can use the
#'   [`bbd_chk_data_recruitment`](https://poissonconsulting.github.io/bboudata/reference/bbd_chk_data_recruitment.html)
#'   function.  See the `vignette("methods", package = "bbouretro")` for the
#'   equations used in this function.
#'
#'   User’s can input the assumed proportion of females in the population (to
#'   estimate females from adult caribou that have unknown sex) as well as sex
#'   ratio at birth.
#'
#' @return A data frame. The columns are listed in the format section.
#'
#' @format The return object has these columns:
#' \describe{
#' \item{PopulationName}{Population name}
#' \item{Year}{Year sampled}
#' \item{esimate}{Recruitment estimate }
#' \item{se}{SE}
#' \item{lower}{Confidence limit}
#' \item{upper}{Confidence limit}
#' \item{groups}{Groups sampled}
#' \item{female_calves}{Estimated female calves}
#' \item{females}{Estimated adult females}
#' }
#' @export
#' @references
#'   DeCesare, Nicholas J., Mark Hebblewhite, Mark Bradley, Kirby G. Smith,
#'   David Hervieux, and Lalenia Neufeld. 2012 “Estimating Ungulate Recruitment
#'   and Growth Rates Using Age Ratios.” The Journal of Wildlife Management
#'   76 (1): 144–53 https://doi.org/10.1002/jwmg.244.
#'
#' @examples
#' recruitment_est <- bbr_recruitment(
#'   bboudata::bbourecruit_a,
#'   p_females = 0.65,
#'   sex_ratio = 0.5,
#'   variance = "binomial"
#' )
#' recruitment_est <- bbr_recruitment(
#'   bboudata::bbourecruit_a,
#'   p_females = 0.60,
#'   sex_ratio = 0.65,
#'   variance = "bootstrap"
#' )
bbr_recruitment <- function(x, p_females = 0.65, sex_ratio = 0.5, variance = "bootstrap", year_start = 4L) {
  x <- bboudata::bbd_chk_data_recruitment(x)
  chk::chk_range(p_females)
  chk::chk_range(sex_ratio)
  chk::chk_string(variance)
  chk::chk_whole_number(year_start)
  chk::chk_range(year_start, c(1, 12))
  
  # Estimate total females based on p_females and sex_ratio
  x <- dplyr::mutate(
    x,
    females = .data$Cows + .data$UnknownAdults * p_females + .data$Yearlings * sex_ratio,
    female_calves = .data$Calves * sex_ratio
  )
  
  # set caribou year
  x$Year <- caribou_year(x$Year, x$Month, year_start = year_start)

  # summarize by population and year
  Compfull <-
    x |>
    dplyr::group_by(.data$PopulationName, .data$Year) |>
    dplyr::summarize(
      females = sum(.data$females),
      female_calves = sum(.data$female_calves),
      Calves = sum(.data$Calves),
      UnknownAdults = sum(.data$UnknownAdults),
      Bulls = sum(.data$Bulls),
      Yearlings = sum(.data$Yearlings),
      groups = length(.data$Year)
    ) |>
    dplyr::ungroup()
  
  # Estimate recruitment based on full data set.
  # Calf cow based on male/female calves
  Compfull$CalfCow <- Compfull$Calves / Compfull$females
  # Calf cow for female calves is 1/2 of CC with female/male calves
  Compfull$CalfCowF <- Compfull$CalfCow * sex_ratio
  # Recruitment using DeCesare correction
  Compfull$R <- Compfull$CalfCowF / (1 + Compfull$CalfCowF)
  
  # variance estimation.
  # simple binomial variance estimate-right now uses females but may not be statistically correct!
  if (variance == "binomial") {
    Compfull$R_SE <- binomial_variance(Compfull$R, Compfull$females)^0.5

    # logit-based confidence limits assuing R is constrained between 0 and 1.
    Compfull <- dplyr::mutate(
      Compfull,
      logits = logit(.data$R),
      selogit = logit_se(.data$R_SE,  .data$R)
    )
    Compfull$R_CIU <- ilogit(wald_cl(Compfull$logits, Compfull$selogit, upper = TRUE))
    Compfull$R_CIL <- ilogit(wald_cl(Compfull$logits, Compfull$selogit, upper = FALSE))
  }
  
  # bootstrap approach 
  if (variance == "bootstrap") {
    # bootstrap by year
    boot <-
      split(x, x$Year) |>
      purrr::map(
        function(x) boot(data = x, rec_calc, R = 1000)
      )
      
    pc <- purrr::map_df(names(boot), function(x) {
      boots <- boot[[x]]$t
      year <- x
      quants <- quantile(boots, c(0.025, 0.5, 0.975))
      SE <- sd(boots)
      tibble::tibble(
        Year = year,
        medianboot = quants[2],
        R_SE = SE,
        R_CIL = quants[1],
        R_CIU = quants[3]
      )
    })
    
    Compfull <- merge(
      Compfull,
      pc[c("Year", "R_SE", "R_CIL", "R_CIU")],
      by = c("Year")
    )
  }
  
  # An abbreviated output data set.
  Compfull <- 
    Compfull |>
    dplyr::mutate(
      PopulationName = unique(x$PopulationName),
      dplyr::across(
        c("R", "R_SE", "R_CIL", "R_CIU"),
        ~ round(.x, 3)
      )
    ) |>
    dplyr::relocate(
      "PopulationName",
      .before = "Year"
    ) |>
    dplyr::select(
      "PopulationName", 
      "Year", 
      "estimate" = "R", 
      "se" = "R_SE", 
      "lower" = "R_CIL", 
      "upper" = "R_CIU", 
      "groups", 
      "female_calves", 
      "females"
    )
  
  tibble::as_tibble(Compfull)
}
