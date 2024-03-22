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

    expect_type(output, "list")
    expect_snapshot_data(output$raw_values, "bbr_lambda_simulate_pop_a_raw_values")
    expect_snapshot_data(output$summary, "bbr_lambda_simulate_pop_a_summary")
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

    expect_type(output, "list")
    expect_snapshot_data(output$raw_values, "bbr_lambda_simulate_pop_b_raw_values")
    expect_snapshot_data(output$summary, "bbr_lambda_simulate_pop_b_summary")
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

    expect_type(output, "list")
    expect_snapshot_data(output$raw_values, "bbr_lambda_simulate_pop_c_raw_values")
    expect_snapshot_data(output$summary, "bbr_lambda_simulate_pop_c_summary")
  })
})

test_that("test data works", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = rep("C", 4),
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
      PopulationName = rep("C", 4),
      Year = c(2003L, 2004L, 2005L, 2006L),
      S = c(0.5, 0.7, 0.9, 1),
      S_SE = c(0.05, 0.03, 0.03, 0),
      S_CIL = c(0.5, 0.7, 0.7, NaN),
      S_CIU = c(0.6, 0.8, 0.8, NaN),
      mean_monitored = c(4.5, 12.6, 14.6, 20.2),
      sumdead = c(3L, 3L, 3L, 0L),
      sumalive = c(39L, 149L, 179L, 242L),
      Status = c(
        "Only 9 months monitored - ", " - ", " - ",
        " - No Mortalities all year (SE=0)"
      )
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)

    expect_snapshot_data(output$raw_values, "bbr_lambda_simulate_raw_values")
    expect_snapshot_data(output$summary, "bbr_lambda_simulate_summary")
  })
})

test_that("errors if no populations overlap", {
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
      PopulationName = c("C", "C", "C", "C"),
      Year = c(2003L, 2004L, 2005L, 2006L),
      S = c(0.5, 0.7, 0.9, 1),
      S_SE = c(0.05, 0.03, 0.03, 0),
      S_CIL = c(0.5, 0.7, 0.7, NaN),
      S_CIU = c(0.6, 0.8, 0.8, NaN),
      mean_monitored = c(4.5, 12.6, 14.6, 20.2),
      sumdead = c(3L, 3L, 3L, 0L),
      sumalive = c(39L, 149L, 179L, 242L),
      Status = c(
        "Only 9 months monitored - ", " - ", " - ",
        " - No Mortalities all year (SE=0)"
      )
    )

    expect_error(
      bbr_lambda_simulate(recruitment_est, survival_est),
      regexp = "PopulationName must have overlapping values in recruitment and survival."
    )
  })
})

test_that("errors if no years overlap", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = c("C", "C", "C", "C"),
      Year = c(2007L, 2008L, 2009L, 2010L),
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
      PopulationName = c("C", "C", "C", "C"),
      Year = c(2003L, 2004L, 2005L, 2006L),
      S = c(0.5, 0.7, 0.9, 1),
      S_SE = c(0.05, 0.03, 0.03, 0),
      S_CIL = c(0.5, 0.7, 0.7, NaN),
      S_CIU = c(0.6, 0.8, 0.8, NaN),
      mean_monitored = c(4.5, 12.6, 14.6, 20.2),
      sumdead = c(3L, 3L, 3L, 0L),
      sumalive = c(39L, 149L, 179L, 242L),
      Status = c(
        "Only 9 months monitored - ", " - ", " - ",
        " - No Mortalities all year (SE=0)"
      )
    )

    expect_error(
      bbr_lambda_simulate(recruitment_est, survival_est),
      regexp = "Year must have overlapping values in recruitment and survival."
    )
  })
})

test_that("errors when recruitment has rows passed", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )[0, ]

    survival_est <- bbr_km_survival(
      bboudata::bbousurv_c,
      mort_type = "total",
      variance = "pollock"
    )

    expect_error(
      bbr_lambda_simulate(recruitment_est, survival_est),
      regexp = "recruitment must have rows"
    )
  })
})

test_that("errors when survival has rows passed", {
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
    )[0, ]

    expect_error(
      bbr_lambda_simulate(recruitment_est, survival_est),
      regexp = "survival must have rows"
    )
  })
})

test_that("NA instead in dataset work", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = c("C", "C", "C", "C"),
      Year = c(2007L, 2008L, 2009L, 2010L),
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
      PopulationName = c("C", "C", "C", "C"),
      Year = c(2007L, 2008L, 2009L, 2010L),
      S = c(0.5, 0.7, 0.9, 1),
      S_SE = c(0.05, 0.03, 0.03, 0),
      S_CIL = c(0.5, 0.7, 0.7, NA),
      S_CIU = c(0.6, 0.8, 0.8, NA),
      mean_monitored = c(4.5, 12.6, 14.6, 20.2),
      sumdead = c(3L, 3L, 3L, 0L),
      sumalive = c(39L, 149L, 179L, 242L),
      Status = c(
        "Only 9 months monitored - ", " - ", " - ",
        " - No Mortalities all year (SE=0)"
      )
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)

    expect_type(output, "list")
    expect_snapshot_data(output$raw_values, "bbr_lambda_simulate_na_test_raw")
    expect_snapshot_data(output$summary, "bbr_lambda_simulate_na_test_sum")
  })
})
