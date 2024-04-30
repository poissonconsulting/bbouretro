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

#' Recruitment to Calf Cow Ratio
#' 
#' Converts the female recruitment rate to the calf cow ratio.
#' For further information see [bbr_cc_to_rec()].
#'
#' @param x A numeric vector of the recruitment rate
#' @param sex_ratio A 
#'
#' @return A numeric vector of the equivalent calf:cow ratio
#' @seealso [bbr_cc_to_rec()]
#' @export
#'
#' @examples
#' bbr_rec_to_cc(c(0, 1, 0.5, NA))
bbr_rec_to_cc <- function(x, sex_ratio = 0.5) {
  chk_numeric(x)
  chk_range(x)
  chk_number(sex_ratio)
  chk_range(sex_ratio)
  
  x2 <- - x / (x - 1)
  x2 / sex_ratio
}

#' Calf Cow Ratio to Recruitment
#' 
#' The calf cow ratios is simply the number of calves divided by the number of cows.
#' As described by DeCesare et al. (2012) in order to convert the 
#' calf cow ratio to the female recruitment rate it is necessary to 
#' multiple the calf cow ratio by the sex ratio to get the 
#' female calf to cow ratio and then divide that number by itself plus 1 to
#' get the female recruitment rate ie female calves divided by all females.
#' To perform the inverse conversion see [bbr_rec_to_cc()]
#'
#' @param x A numeric vector of the calf:cow ratio
#' @param sex_ratio A 
#'
#' @return A numeric vector of the equivalent recruitment rate
#' @seealso [bbr_rec_to_cc()]
#' @export
#'
#' @examples
#' bbr_cc_to_rec(c(0, 1, 0.5, NA))
bbr_cc_to_rec <- function(x, sex_ratio = 0.5) {
  chk_numeric(x)
  chk_range(x, c(0, 2))
  chk_number(sex_ratio)
  chk_range(sex_ratio) 
  
  x2 <- x * sex_ratio
  x2 / (1 + x2)
}
