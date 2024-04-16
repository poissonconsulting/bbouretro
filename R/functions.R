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

# Checks ------------------------------------------------------------------

chk_has_data <- function(x) {
  if (dim(x)[1] > 0) {
    return(x)
  }

  rlang::abort(paste(deparse(substitute(x)), "must have rows"))
}

chk_population <- function(x) {
  if (vld_population(x)) {
    return(invisible())
  }
  chk::abort_chk("'PopulationName' can only contain one unique value.")
}

vld_population <- function(x) {
  length(unique(x$PopulationName)) == 1L
}

# Bootstrap ---------------------------------------------------------------

rec_calc <- function(x, indices) {
  d <- x[indices, ]
  ccf <- sum(d$female_calves) / sum(d$females)
  rec <- ccf / (1 + ccf)
  rec
}

# Plot Helper -------------------------------------------------------------

every_nth <- function(n) {
  function(x) {
    if (length(x) <= 6) {
      return(x)
    } else {
      x[c(TRUE, rep(FALSE, n - 1))]
    }
  }
}

# caribou year ------------------------------------------------------------

caribou_year <- function(year, month, year_start) {
  start <- as.Date(paste(year, year_start, "01", sep = "-"))
  date_in_start <- as.Date(paste(year, month, "01", sep = "-")) >= start
  year[!date_in_start] <- year[!date_in_start] - 1L
  year
}