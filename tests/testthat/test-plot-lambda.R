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
      pFemales = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_km_survival(
      bboudata::bbousurv_a,
      mort_type = "Total",
      variance = "Pollock"
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)
    plot <- bbr_plot_lambda(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_pop_a")
  })
})

test_that("pop b works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_b,
      pFemales = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_km_survival(
      bboudata::bbousurv_b,
      mort_type = "Total",
      variance = "Pollock"
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)
    plot <- bbr_plot_lambda(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_pop_b")
  })
})

test_that("pop c works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_c,
      pFemales = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_km_survival(
      bboudata::bbousurv_c,
      mort_type = "Total",
      variance = "Pollock"
    )

    output <- bbr_lambda_simulate(recruitment_est, survival_est)
    plot <- bbr_plot_lambda(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_pop_c")
  })
})

test_that("errors when dataframe passed as lambda", {
  lambda <- data.frame(x = 1)
  expect_error(
    bbr_plot_lambda(lambda),
    regexp = "`lambda` must inherit from class 'list'\\."
  )
})

test_that("errors when Summary not in input list", {
  lambda <- list(
    Summary_2 = data.frame(PopulationName = "A")
  )
  expect_error(
    bbr_plot_lambda(lambda),
    regexp = "`names\\(lambda\\)` must include 'Summary'\\."
  )
})

test_that("errors when Summary is an empty dataframe", {
  lambda <- list(
    Summary = data.frame()
  )
  expect_error(
    bbr_plot_lambda(lambda),
    regexp = "lambda\\$Summary must have rows"
  )
})

test_that("creats plot as expected", {
  lambda <- list(
    Summary = data.frame(
      PopulationName = c("A", "A"),
      Year = c(2000L, 2001L),
      S = c(0.814, .987),
      R = c(0.147, .0138),
      Lambda = c(1.27, 0.97),
      SE_Lambda = c(0.0357, 0.0247),
      Lambda_LCL = c(0.80, 0.75),
      Lambda_UCL = c(1.30, 1.05),
      Prop_LGT1 = c(0.587, 0.658),
      meanSimSurv = c(0.974, 0.984),
      meanRsim = c(0.147, 0.0587),
      meanSimLambda = c(1.08, 0.478),
      medianSimLambda = c(0.98, 1.01)
    )
  )

  plot <- bbr_plot_lambda(lambda)
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_lambda_test_pop")
})
