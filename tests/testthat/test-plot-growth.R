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
      adult_female_proportion = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_a,
      mort_type = "total",
      variance = "cox_oakes"
    )

    output <- bbr_growth(survival_est, recruitment_est)
    plot <- bbr_plot_growth(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_pop_a")
  })
})

test_that("pop b works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_b,
      adult_female_proportion = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_b,
      mort_type = "total",
      variance = "cox_oakes"
    )

    output <- bbr_growth(survival_est, recruitment_est)
    plot <- bbr_plot_growth(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_pop_b")
  })
})

test_that("pop c works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_c,
      adult_female_proportion = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_c,
      mort_type = "total",
      variance = "cox_oakes"
    )

    output <- bbr_growth(survival_est, recruitment_est)
    plot <- bbr_plot_growth(output)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_lambda_pop_c")
  })
})

test_that("errors when summary is an empty dataframe", {
  lambda <- data.frame()
  expect_error(
    bbr_plot_growth(lambda),
    regexp = "must"
  )
})
