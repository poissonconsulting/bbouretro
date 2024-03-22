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
      sexratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_km_survival(
      bboudata::bbousurv_a,
      mort_type = "total",
      variance = "pollock"
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)
    plot <- bbr_plot_lambda_distributions(output, "A")

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_distributions_pop_a")
  })
})

test_that("pop b works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_b,
      p_females = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_km_survival(
      bboudata::bbousurv_b,
      mort_type = "total",
      variance = "pollock"
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)
    plot <- bbr_plot_lambda_distributions(output, "B")

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_distributions_pop_b")
  })
})

test_that("pop c works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_km_survival(
      bboudata::bbousurv_c,
      mort_type = "total",
      variance = "pollock"
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)
    plot <- bbr_plot_lambda_distributions(output, "C")

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_distributions_pop_c")
  })
})

test_that("errors when pop not in data set", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = c("A", "A", "A", "A"),
      Year = c(2003L, 2004L, 2005L, 2006L),
      R = c(0.01, 0.02, 0.02, 0.03),
      R_SE = c(0.01, 0.02, 0.02, 0.03),
      R_CIL = c(0.01, 0.02, 0.02, 0.03),
      R_CIU = c(0.01, 0.02, 0.02, 0.03),
      groups = c(10L, 15L, 12L, 4L),
      FemaleCalves = c(7, 6, 3.5, 1),
      Females = c(66, 69, 47.95, 16),
      sexratio = rep(0.5, 4),
      p_females = rep(0.65, 4)
    )

    survival_est <- data.frame(
      PopulationName = c("A", "A", "A", "A"),
      Year = c(2003L, 2004L, 2005L, 2006L),
      S = c(0.5, 0.7, 0.9, 1),
      S_SE = c(0.05, 0.03, 0.03, 0),
      S_CIL = c(0.5, 0.7, 0.7, NaN),
      S_CIU = c(0.6, 0.8, 0.8, NaN),
      MeanMonitored = c(4.5, 12.6, 14.6, 20.2),
      sumdead = c(3L, 3L, 3L, 0L),
      sumalive = c(39L, 149L, 179L, 242L),
      Status = c(
        "Only 9 months monitored - ", " - ", " - ",
        " - No Mortalities all year (SE=0)"
      )
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)
    plot <- bbr_plot_lambda_distributions(output, "A")

    expect_s3_class(plot, "ggplot")

    expect_error(
      bbr_plot_lambda_distributions(output, "B"),
      regexp = "The population B is not present in the raw_values table\\."
    )
  })
})

test_that("errors when dataframe passed as lambda", {
  lambda <- data.frame(x = 1)
  expect_error(
    bbr_plot_lambda_distributions(lambda, "A"),
    regexp = "`lambda` must inherit from class 'list'\\."
  )
})

test_that("errors when number passed as population", {
  lambda <- list(
    raw_values = data.frame(PopulationName = "A"),
    summary = data.frame(PopulationName = "A")
  )
  expect_error(
    bbr_plot_lambda_distributions(lambda, 1),
    regexp = "`population` must be a string \\(non-missing character scalar\\)\\."
  )
})
