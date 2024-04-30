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

# White, G.C., Burnham, K.P., and Anderson, D.R. 2001. Advanced features of Program Mark. In Wildlife, land, and people: prioritiesfor the 21st century. Edited by R. Field, R.J. Warren, H. Okarma, and P.R. Sievert. The Wildlife Society, Bethesda, Maryland. pp. 368–377.
logit_se <- function(se, estimate) {
  sqrt(se^2 / (estimate^2 * (1 - estimate)^2))
}

binomial_variance <- function(p, n) {
  (p * (1 - p)) / n
}

wald_cl <- function(estimate, se, upper = FALSE, level = 0.95) {
  q <- (1 - level) / 2
  z <- qnorm(q)
  if (upper) {
    z <- z * -1
  }
  estimate + se * z
}
