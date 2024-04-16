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

    lambda <- bbr_growth(recruitment_est, survival_est)
    output <- bbr_growth_summarize(lambda)

    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_lambda_summarize_pop_a")
  })
})

test_that("errors with list that doesn't have correct columns", {
  lambda <- data.frame(y = 2)
  expect_error(
    bbr_growth_summarize(lambda),
    regexp = "`names\\(lambda\\)` must include 'PopulationName', 'Year', 'S', 'R', 'estimate', 'se', 'lower', 'upper', ... and 'ran_s'."
  )
})
