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

test_that("pop a works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_a,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_a,
      mort_type = "total",
      variance = "cox_oakes"
    )

    output <- bbr_growth(recruitment_est, survival_est)
    plot <- bbr_plot_growth_distributions(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_distributions_pop_a")
  })
})

test_that("pop b works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_b,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_b,
      mort_type = "total",
      variance = "cox_oakes"
    )

    output <- bbr_growth(recruitment_est, survival_est)
    plot <- bbr_plot_growth_distributions(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_distributions_pop_b")
  })
})

test_that("pop c works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_c,
      mort_type = "total",
      variance = "cox_oakes"
    )

    output <- bbr_growth(recruitment_est, survival_est)
    plot <- bbr_plot_growth_distributions(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_distributions_pop_c")
  })
})

test_that("errors when more then 1 pop in data set", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = c("A", "A", "A", "A"),
      CaribouYear = c(2003L, 2004L, 2005L, 2006L),
      estimate = c(0.01, 0.02, 0.02, 0.03),
      se = c(0.01, 0.02, 0.02, 0.03),
      lower = c(0.01, 0.02, 0.02, 0.03),
      upper = c(0.01, 0.02, 0.02, 0.03),
      groups = c(10L, 15L, 12L, 4L),
      female_calves = c(7, 6, 3.5, 1),
      females = c(66, 69, 47.95, 16)
    )

    survival_est <- data.frame(
      PopulationName = c("A", "A", "A", "A"),
      CaribouYear = c(2003L, 2004L, 2005L, 2006L),
      estimate = c(0.5, 0.7, 0.9, 1),
      se = c(0.05, 0.03, 0.03, 0),
      lower = c(0.5, 0.7, 0.7, NaN),
      upper = c(0.6, 0.8, 0.8, NaN),
      mean_monitored = c(4.5, 12.6, 14.6, 20.2),
      sum_dead = c(3L, 3L, 3L, 0L),
      sum_alive = c(39L, 149L, 179L, 242L),
      status = c(
        "Only 9 months monitored - ", " - ", " - ",
        " - No Mortalities all year (SE=0)"
      )
    )

    output <- bbr_growth(recruitment_est, survival_est)
    output[1, 1] <- "B"

    expect_error(
      bbr_plot_growth_distributions(output),
      regexp = "'PopulationName' can only contain one unique value\\."
    )
  })
})
