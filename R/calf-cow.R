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

#' Estimate Calf-Cow Ratio.
#' 
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
#' @param year_start A whole number between 1 and 12 indicating the month of the start of the caribou (i.e., biological) year. By default, April is set as the start of the caribou year.
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
#' \item{estimate}{Calf-Cow ratio estimate}
#' \item{lower}{Confidence limit}
#' \item{upper}{Confidence limit}
#' \item{groups}{Groups sampled}
#' \item{female_calves}{Estimated female calves}
#' \item{females}{Estimated adult females}
#' }
#' @export
#'
#' @examples
#' calfcow_est <- bbr_calf_cow_ratio(
#'   bboudata::bbourecruit_a,
#'   p_females = 0.65,
#'   sex_ratio = 0.5,
#'   variance = "binomial"
#' )
#' calfcow_est <- bbr_calf_cow_ratio(
#'   bboudata::bbourecruit_a,
#'   p_females = 0.60,
#'   sex_ratio = 0.65,
#'   variance = "bootstrap"
#' )
bbr_calf_cow_ratio <- function(x, p_females = 0.65, sex_ratio = 0.5, variance = "bootstrap", year_start = 4L) {
  x <- bboudata::bbd_chk_data_recruitment(x)
  chk::chk_range(p_females)
  chk::chk_range(sex_ratio)
  chk::chk_string(variance)
  chk::chk_whole_number(year_start)
  chk::chk_range(year_start, c(1, 12))
  
  rec <- bbr_recruitment(x, 
                         p_females = p_females, 
                         sex_ratio = sex_ratio, 
                         variance = variance,
                         year_start = year_start)
  
  ccr <- 
    rec |> 
    dplyr::mutate(dplyr::across(c("estimate", "lower", "upper"), function(.x) {
      round(bbr_rec_to_cc(.x, sex_ratio = sex_ratio), 3)
    }))
  
  # SE no longer valid - can't convert from recruitment
  ccr$se <- NULL
  tibble::as_tibble(ccr)
}
