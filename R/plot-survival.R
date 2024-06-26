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

#' Plot survival
#'
#' A plot of yearly survival is given for each population unit.
#'
#' @param survival A data frame generated by `bbr_survival()`.
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' \dontrun{
#' survival_est <- bbr_survival(bboudata::bbousurv_a)
#' 
#' bbr_plot_survival(survival_est)
#' }
bbr_plot_survival <- function(survival) {
  chk::chk_s3_class(survival, "data.frame")
  chk_has_data(survival)
  chk::check_data(
    survival,
    values = list(
      PopulationName = character(),
      CaribouYear = integer(),
      estimate = numeric(),
      lower = numeric(),
      upper = numeric()
    )
  )

  survival$CaribouYear <- as.character(survival$CaribouYear)

  ggplot(survival, aes(.data$CaribouYear, .data$estimate)) +
    geom_point(color = "red", size = 3) +
    geom_errorbar(
      aes(x = .data$CaribouYear, ymin = .data$lower, ymax = .data$upper),
      color = "steelblue"
    ) +
    scale_y_continuous(breaks = seq(0, 1, 0.1)) +
    scale_x_discrete(breaks = every_nth(n = 2)) +
    xlab("Caribou Year") +
    ylab("Adult female survival") +
    facet_wrap(~PopulationName, scales = "free_x") +
    theme_bw(base_size = 14) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
}
