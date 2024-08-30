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

test_that("recruitment a works", {
  withr::with_seed(10, {
    expect_snapshot({
      print(
        bbr_calf_cow_ratio(
          bboudata::bbourecruit_a
        ),
        n = 100, width = 100
      )
      print(
        bbr_calf_cow_ratio(
          bboudata::bbourecruit_a,
          adult_female_proportion = 0.2, sex_ratio = 0.6, variance = "binomial"
        ),
        n = 100, width = 100
      )
      print(
        bbr_calf_cow_ratio(
          bboudata::bbourecruit_a,
          adult_female_proportion = 0.2, sex_ratio = 0.5, variance = "bootstrap"
        ),
        n = 100, width = 100
      )
    })
  })
})

test_that("recruitment b works", {
  withr::with_seed(10, {
    expect_snapshot({
      print(
        bbr_calf_cow_ratio(
          bboudata::bbourecruit_b
        ),
        n = 100, width = 100
      )
      print(
        bbr_calf_cow_ratio(
          bboudata::bbourecruit_b,
          adult_female_proportion = 0.65, sex_ratio = 0.6, variance = "binomial"
        ),
        n = 100, width = 100
      )
      print(
        bbr_calf_cow_ratio(
          bboudata::bbourecruit_b,
          adult_female_proportion = 0.2, sex_ratio = 0.5, variance = "bootstrap"
        ),
        n = 100, width = 100
      )
    })
  })
})

test_that("recruitment c works", {
  skip("OS sensitive rounding error in females!")

  expect_snapshot({
    print(
      bbr_calf_cow_ratio(bboudata::bbourecruit_c),
      n = 100, width = 100
    )
    print(
      bbr_calf_cow_ratio(
        bboudata::bbourecruit_c,
        adult_female_proportion = 0.65, sex_ratio = 0.6, variance = "binomial"
      ),
      n = 100, width = 100
    )
    print(
      bbr_calf_cow_ratio(
        bboudata::bbourecruit_c,
        adult_female_proportion = 0.2, sex_ratio = 0.5, variance = "bootstrap"
      ),
      n = 100, width = 100
    )
  })
})

test_that("errors when no data supplied", {
  expect_error(
    bbr_calf_cow_ratio(),
    regexp = 'argument "x" is missing, with no default'
  )
})

test_that("errors when empty dataframe is passed", {
  expect_error(
    bbr_calf_cow_ratio(
      bboudata::bbourecruit_c[0, ]
    )
  )
})

test_that("errors when column missing in data", {
  expect_error(
    bbr_calf_cow_ratio(
      bboudata::bbourecruit_c[-2]
    ),
    regexp = "X must include 'Year'"
  )
})

test_that("errors number greater then 1 or less then 0 provided to adult_female_proportion", {
  expect_error(
    bbr_calf_cow_ratio(
      bboudata::bbourecruit_c,
      adult_female_proportion = 1.05,
      sex_ratio = 0.5,
      variance = "binomial"
    ),
    regexp = "`adult_female_proportion` must be between 0 and 1, not 1.05\\."
  )

  expect_error(
    bbr_calf_cow_ratio(
      bboudata::bbourecruit_c,
      adult_female_proportion = -1.05,
      sex_ratio = 0.5,
      variance = "binomial"
    ),
    regexp = "`adult_female_proportion` must be between 0 and 1, not -1.05\\."
  )
})

test_that("errors number greater then 1 or less then 0 provided to sex_ratio", {
  expect_error(
    bbr_calf_cow_ratio(
      bboudata::bbourecruit_c,
      adult_female_proportion = 0.5,
      sex_ratio = 2,
      variance = "binomial"
    ),
    regexp = "`sex_ratio` must be between 0 and 1, not 2\\."
  )

  expect_error(
    bbr_calf_cow_ratio(
      bboudata::bbourecruit_c,
      adult_female_proportion = 0.5,
      sex_ratio = -1,
      variance = "binomial"
    ),
    regexp = "`sex_ratio` must be between 0 and 1, not -1\\."
  )
})
