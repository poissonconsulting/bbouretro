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
      pFemales = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_a_bin")

    output <- bbr_recruitment(
      bboudata::bbourecruit_a,
      pFemales = 0.20,
      sexratio = 0.6,
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
      pFemales = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_b_bin")

    output <- bbr_recruitment(
      bboudata::bbourecruit_b,
      pFemales = 0.20,
      sexratio = 0.6,
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
      pFemales = 0.65,
      sexratio = 0.5,
      variance = "binomial"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_c_bin", 2)

    output <- bbr_recruitment(
      bboudata::bbourecruit_c,
      pFemales = 0.20,
      sexratio = 0.6,
      variance = "bootstrap"
    )
    expect_s3_class(output, "data.frame")
    expect_snapshot_data(output, "bbr_recruitment_c_boot")
  })
})

test_that("pFemales and sexratio matches what was set", {
  output <- bbr_recruitment(
    bboudata::bbourecruit_c,
    pFemales = 0.65,
    sexratio = 0.5,
    variance = "binomial"
  )
  expect_equal(unique(output$pFemales), 0.65)
  expect_equal(unique(output$sexratio), 0.5)
})

test_that("variance options give different se, cui and cil and same for other columns", {
  output_binomial <- bbr_recruitment(
    bboudata::bbourecruit_c,
    pFemales = 0.65,
    sexratio = 0.5,
    variance = "binomial"
  )

  output_bootstrap <- bbr_recruitment(
    bboudata::bbourecruit_c,
    pFemales = 0.65,
    sexratio = 0.5,
    variance = "bootstrap"
  )

  expect_equal(output_binomial$PopulationName, output_bootstrap$PopulationName)
  expect_equal(output_binomial$Year, output_bootstrap$Year)
  expect_equal(output_binomial$R, output_bootstrap$R)
  expect_equal(output_binomial$groups, output_bootstrap$groups)
  expect_equal(output_binomial$FemaleCalves, output_bootstrap$FemaleCalves)
  expect_equal(output_binomial$Females, output_bootstrap$Females)
  expect_equal(output_binomial$sexratio, output_bootstrap$sexratio)
  expect_equal(output_binomial$pFemales, output_bootstrap$pFemales)
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

test_that("errors number greater then 1 or less then 0 provided to pFemales", {
  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c,
      pFemales = 1.05,
      sexratio = 0.5,
      variance = "binomial"
    ),
    regexp = "`pFemales` must be between 0 and 1, not 1.05\\."
  )

  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c,
      pFemales = -1.05,
      sexratio = 0.5,
      variance = "binomial"
    ),
    regexp = "`pFemales` must be between 0 and 1, not -1.05\\."
  )
})

test_that("errors number greater then 1 or less then 0 provided to sexratio", {
  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c,
      pFemales = 0.5,
      sexratio = 2,
      variance = "binomial"
    ),
    regexp = "`sexratio` must be between 0 and 1, not 2\\."
  )

  expect_error(
    bbr_recruitment(
      bboudata::bbourecruit_c,
      pFemales = 0.5,
      sexratio = -1,
      variance = "binomial"
    ),
    regexp = "`sexratio` must be between 0 and 1, not -1\\."
  )
})

test_that("pFemales and sexratio matches what was set", {
  output <- bbr_recruitment(
    bboudata::bbourecruit_c,
    pFemales = 0,
    sexratio = 0,
    variance = "binomial"
  )
  expect_snapshot_data(output, "bbr_recruitment_c_0")
})
