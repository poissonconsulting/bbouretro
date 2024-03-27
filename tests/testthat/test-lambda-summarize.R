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

    survival_est <- bbr_km_survival(
      bboudata::bbousurv_a,
      mort_type = "total",
      variance = "pollock"
    )

    lambda <- bbr_lambda_simulate(recruitment_est, survival_est)
    output <- bbr_lambda_summarize(lambda)

    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_lambda_summarize_pop_a")
  })
})

test_that("errors with empty list", {
  expect_error(
    bbr_lambda_summarize(list()),
    regexp = "Lambda must not be empty \\(zero length\\)."
  )
})

test_that("errors with list that doesn't have correct columns", {
  lambda <- list(raw_values = data.frame(x = 1), summary = data.frame(y = 2))
  expect_error(
    bbr_lambda_summarize(lambda),
    regexp = "`names\\(summary\\)` must include 'PopulationName', 'Year', 'S', 'R', 'estimate', 'se', 'lower', 'upper', ... and 'median_sim_lambda'."
  )
})

test_that("errors with wrong list name", {
  lambda <- list(raw_values = data.frame(x = 1), Summary2 = data.frame(y = 2))
  expect_error(
    bbr_lambda_summarize(lambda),
    regexp = "names\\(lambda\\)` must include 'summary'."
  )
})

test_that("outputs even if raw_values is empty", {
  lambda <- list(
    raw_values = data.frame(x = 1),
    summary = data.frame(
      PopulationName = c("A"),
      Year = 1991L,
      S = .874,
      R = 0.125,
      estimate = 0.94878,
      se = 0.345578,
      lower = 0.947,
      upper = 0.97248,
      prop_lgt1 = 0.78,
      mean_sim_survival = 0.87414,
      mean_sim_recruitment = 0.09,
      mean_sim_lambda = 0.14,
      median_sim_lambda = 0.8745
    )
  )

  output <- bbr_lambda_summarize(lambda)

  expect_equal(
    output,
    data.frame(
      PopulationName = c("A"),
      Year = 1991L,
      S = .874,
      R = 0.125,
      estimate = 0.949,
      se = 0.346,
      lower = 0.947,
      upper = 0.972,
      prop_lgt1 = 0.78,
      mean_sim_survival = 0.874,
      mean_sim_recruitment = 0.09,
      mean_sim_lambda = 0.14,
      median_sim_lambda = 0.8745
    )
  )
})
