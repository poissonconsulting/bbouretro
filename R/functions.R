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

vld_overlap <- function(x, values) {
  any(x %in% values)
}

chk_overlap <- function(x, y, variable) {
  x <- x[[variable]]
  y <- y[[variable]]

  if (vld_overlap(x, y)) {
    return(invisible(x))
  }
  rlang::abort(
    paste(
      variable,
      "must have overlapping values in recruitment and survival."
    )
  )
}

chk_has_data <- function(x) {
  if (dim(x)[1] > 0) {
    return(x)
  }

  rlang::abort(paste(deparse(substitute(x)), "must have rows"))
}

chk_set <- function(x, list, name) {
  if (x %in% list[[name]]$PopulationName) {
    return(invisible(x))
  }

  rlang::abort(
    paste(
      "The population", x, "is not present in the", name, "table."
    )
  )
}

# Bootstrap ---------------------------------------------------------------

RecCalc <- function(C, indices) {
  d <- C[indices, ]
  CCF <- sum(d$FemaleCalves) / sum(d$Females)
  Rec <- CCF / (1 + CCF)
  Rec
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
