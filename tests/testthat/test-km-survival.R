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

test_that("survival a works", {
  expect_snapshot({
    print(
      bbr_km_survival(
        bboudata::bbousurv_a, mort_type = "total", variance = "pollock"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_a, mort_type = "certain", variance = "pollock"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_a, mort_type = "total", variance = "greenwood"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_a, mort_type = "certain", variance = "greenwood"
      ),
      n = 100, width = 100
    )
  })
})

test_that("survival b works", {
  expect_snapshot({
    print(
      bbr_km_survival(
        bboudata::bbousurv_b, mort_type = "total", variance = "pollock"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_b, mort_type = "certain", variance = "pollock"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_b, mort_type = "total", variance = "greenwood"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_b, mort_type = "certain", variance = "greenwood"
      ),
      n = 100, width = 100
    )
  })
})

test_that("survival c works", {
  expect_snapshot({
    print(
      bbr_km_survival(
        bboudata::bbousurv_c, mort_type = "total", variance = "pollock"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_c, mort_type = "certain", variance = "pollock"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_c, mort_type = "total", variance = "greenwood"
      ),
      n = 100, width = 100
    )
    print(
      bbr_km_survival(
        bboudata::bbousurv_c, mort_type = "certain", variance = "greenwood"
      ),
      n = 100, width = 100
    )
  })
})

test_that("mort_type gives different outputs when values in mort uncertain column", {
  df <- bboudata::bbousurv_c
  df$MortalitiesUncertain <- 1
  df$StartTotal <- df$StartTotal + 1
  
  output_total <- bbr_km_survival(
    df,
    mort_type = "total",
    variance = "greenwood"
  )
  
  output_certain <- bbr_km_survival(
    df,
    mort_type = "certain",
    variance = "greenwood"
  )
  
  expect_true(
    all(output_total$S != output_certain$S)
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

test_that("status message", {
  output <- bbr_km_survival(
    bboudata::bbousurv_c
  )
  
  expect_equal(
    unique(output$status[output$sum_dead == 0]),
    " - No Mortalities all year (SE=0)"
  )
})
