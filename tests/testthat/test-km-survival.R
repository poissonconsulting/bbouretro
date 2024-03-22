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
  output <- bbr_km_survival(
    bboudata::bbousurv_a,
    mort_type = "Total",
    variance = "Pollock"
  )

  expect_s3_class(output, "data.frame")
  expect_snapshot_data(output, "bbr_km_survival_a")
})

test_that("pop b works", {
  output <- bbr_km_survival(
    bboudata::bbousurv_b,
    mort_type = "Total",
    variance = "Pollock"
  )

  expect_s3_class(output, "data.frame")
  expect_snapshot_data(output, "bbr_km_survival_b")
})

test_that("pop c works", {
  output <- bbr_km_survival(
    bboudata::bbousurv_c,
    mort_type = "Total",
    variance = "Pollock"
  )

  expect_s3_class(output, "data.frame")
  expect_snapshot_data(output, "bbr_km_survival_c")
})

test_that("works with mort_type as 'certain'", {
  output <- bbr_km_survival(
    bboudata::bbousurv_c,
    mort_type = "Certain",
    variance = "Pollock"
  )

  expect_s3_class(output, "data.frame")
  expect_snapshot_data(output, "bbr_km_survival_c_certain_p")

  output <- bbr_km_survival(
    bboudata::bbousurv_c,
    mort_type = "Certain",
    variance = "Greenwood"
  )

  expect_s3_class(output, "data.frame")
  expect_snapshot_data(output, "bbr_km_survival_c_certain_w")
})

test_that("works with variance as 'Greenwood'", {
  output <- bbr_km_survival(
    bboudata::bbousurv_c,
    mort_type = "Total",
    variance = "Greenwood"
  )

  expect_s3_class(output, "data.frame")
  expect_snapshot_data(output, "bbr_km_survival_c_greenwood_t")
})

test_that("mort_type gives different outputs when values in mort uncertain column", {
  df <- bboudata::bbousurv_c
  df$MortalitiesUncertain <- 1
  df$StartTotal <- df$StartTotal + 1

  output_total <- bbr_km_survival(
    df,
    mort_type = "Total",
    variance = "Greenwood"
  )

  output_certain <- bbr_km_survival(
    df,
    mort_type = "Certain",
    variance = "Greenwood"
  )

  expect_true(
    all(output_total$S != output_certain$S)
  )
})

test_that("mort_type gives same outputs when all 0 values in mort uncertain column", {
  df <- bboudata::bbousurv_c

  expect_equal(unique(df$MortalitiesUncertain), 0)

  output_total <- bbr_km_survival(
    df,
    mort_type = "Total",
    variance = "Greenwood"
  )

  output_certain <- bbr_km_survival(
    df,
    mort_type = "Certain",
    variance = "Greenwood"
  )

  expect_true(
    all(output_total$S == output_certain$S)
  )
})

test_that("variance options give different SE, CIL and CIU", {
  df <- bboudata::bbousurv_c

  output_greenwood <- bbr_km_survival(
    df,
    mort_type = "Total",
    variance = "Greenwood"
  )

  output_pollock <- bbr_km_survival(
    df,
    mort_type = "Total",
    variance = "Pollock"
  )

  expect_true(
    all(output_greenwood$PopulationName == output_pollock$PopulationName)
  )
  expect_true(
    all(output_greenwood$Year == output_pollock$Year)
  )

  expect_true(
    all(output_greenwood$S == output_pollock$S)
  )

  expect_true(
    any(output_greenwood$S_SE != output_pollock$S_SE)
  )

  expect_true(
    any(output_greenwood$S_CIL != output_pollock$S_CIL)
  )

  expect_true(
    any(output_greenwood$S_CIU != output_pollock$S_CIU)
  )

  expect_true(
    all(output_greenwood$MeanMonitored == output_pollock$MeanMonitored)
  )

  expect_true(
    all(output_greenwood$sumdead == output_pollock$sumdead)
  )

  expect_true(
    all(output_greenwood$sumalive == output_pollock$sumalive)
  )

  expect_true(
    all(output_greenwood$S == output_pollock$S)
  )
})

test_that("errors when no data supplied", {
  expect_error(
    bbr_km_survival(),
    regexp = 'argument "x" is missing, with no default'
  )
})

test_that("errors when empty dataframe is passed", {
  expect_error(
    bbr_km_survival(
      bboudata::bbousurv_a[0, ]
    )
  )
})

test_that("errors when column missing in data", {
  expect_error(
    bbr_km_survival(
      bboudata::bbousurv_a[-2]
    ),
    regexp = "X must include 'Year'"
  )
})

test_that("status messages ", {
  output <- bbr_km_survival(
    bboudata::bbousurv_c
  )

  expect_equal(
    unique(output$Status[output$sumdead == 0]),
    " - No Mortalities all year (SE=0)"
  )

  expect_equal(
    unique(output$Status[output$Year == 2003]),
    "Only 9 months monitored - "
  )
})
