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
    output <- bbr_recruitment(
      bboudata::bbourecruit_a,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_a_bin")

    output <- bbr_recruitment(
      bboudata::bbourecruit_a,
      p_females = 0.20,
      sex_ratio = 0.6,
      variance = "bootstrap"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_a_boot")
  })
})

test_that("pop b works", {
  withr::with_seed(10, {
    output <- bbr_recruitment(
      bboudata::bbourecruit_b,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_b_bin")

    output <- bbr_recruitment(
      bboudata::bbourecruit_b,
      p_females = 0.20,
      sex_ratio = 0.6,
      variance = "bootstrap"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_b_boot")
  })
})

test_that("pop c works", {
  withr::with_seed(10, {
    output <- bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_c_bin", 2)

    output <- bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.20,
      sex_ratio = 0.6,
      variance = "bootstrap"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_c_boot")
  })
})

test_that("p_females and sex_ratio matches what was set", {
  output <- bbr_recruitment(
    bboudata::bbourecruit_c,
    p_females = 0.65,
    sex_ratio = 0.5,
    variance = "binomial"
  )
  expect_equal(unique(output$p_females), 0.65)
  expect_equal(unique(output$sex_ratio), 0.5)
})

test_that("variance options give different se, cui and cil and same for other columns", {
  output_binomial <- bbr_recruitment(
    bboudata::bbourecruit_c,
    p_females = 0.65,
    sex_ratio = 0.5,
    variance = "binomial"
  )

  output_bootstrap <- bbr_recruitment(
    bboudata::bbourecruit_c,
    p_females = 0.65,
    sex_ratio = 0.5,
    variance = "bootstrap"
  )

  expect_equal(output_binomial$PopulationName, output_bootstrap$PopulationName)
  expect_equal(output_binomial$Year, output_bootstrap$Year)
  expect_equal(output_binomial$R, output_bootstrap$R)
  expect_equal(output_binomial$groups, output_bootstrap$groups)
  expect_equal(output_binomial$female_calves, output_bootstrap$female_calves)
  expect_equal(output_binomial$females, output_bootstrap$females)
  expect_equal(output_binomial$sex_ratio, output_bootstrap$sex_ratio)
  expect_equal(output_binomial$p_females, output_bootstrap$p_females)
  expect_true(all(output_binomial$R_SE != output_bootstrap$R_SE))
  expect_true(any(output_binomial$R_CIL != output_bootstrap$R_CIL))
  expect_true(all(output_binomial$R_CIU != output_bootstrap$R_CIU))
})

test_that("errors when no data supplied", {
  expect_error(
    bbr_recruitment(),
    regexp = 'argument "x" is missing, with no default'
  )
})

test_that("errors when empty dataframe is passed", {
  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c[0, ]
    )
  )
})

test_that("errors when column missing in data", {
  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c[-2]
    ),
    regexp = "X must include 'Year'"
  )
})

test_that("errors number greater then 1 or less then 0 provided to p_females", {
  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 1.05,
      sex_ratio = 0.5,
      variance = "binomial"
    ),
    regexp = "`p_females` must be between 0 and 1, not 1.05\\."
  )

  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = -1.05,
      sex_ratio = 0.5,
      variance = "binomial"
    ),
    regexp = "`p_females` must be between 0 and 1, not -1.05\\."
  )
})

test_that("errors number greater then 1 or less then 0 provided to sex_ratio", {
  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.5,
      sex_ratio = 2,
      variance = "binomial"
    ),
    regexp = "`sex_ratio` must be between 0 and 1, not 2\\."
  )

  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.5,
      sex_ratio = -1,
      variance = "binomial"
    ),
    regexp = "`sex_ratio` must be between 0 and 1, not -1\\."
  )
})

test_that("p_females and sex_ratio matches what was set", {
  output <- bbr_recruitment(
    bboudata::bbourecruit_c,
    p_females = 0,
    sex_ratio = 0,
    variance = "binomial"
  )
  expect_snapshot_data(output, "bbr_recruitment_c_0")
})
