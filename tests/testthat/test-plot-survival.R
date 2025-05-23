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
    survival_est <- bbr_survival(
      bboudata::bbousurv_a,
      include_uncertain_morts = TRUE,
      variance = "cox_oakes"
    )

    plot <- bbr_plot_survival(survival_est)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_survival_pop_a")
  })
})

test_that("pop b works", {
  withr::with_seed(10, {
    survival_est <- bbr_survival(
      bboudata::bbousurv_b,
      include_uncertain_morts = TRUE,
      variance = "cox_oakes"
    )

    plot <- bbr_plot_survival(survival_est)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_survival_pop_b")
  })
})

test_that("pop c works", {
  withr::with_seed(10, {
    survival_est <- bbr_survival(
      bboudata::bbousurv_c,
      include_uncertain_morts = TRUE,
      variance = "cox_oakes"
    )

    plot <- bbr_plot_survival(survival_est)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_survival_pop_c")
  })
})

test_that("skip x ticks when more then 6 groups", {
  survival_est <- data.frame(
    PopulationName = rep("A", 7),
    CaribouYear = c(2003L, 2004L, 2005L, 2006L, 2007L, 2008L, 2009L),
    estimate = c(0.57, 0.72, 0.75, 1, 0.6, 0.7, 0.8),
    se = c(0.05, 0.03, 0.03, 0, 0.02, 0.04, 0.06),
    lower = c(0.5, 0.7, 0.7, NaN, 0.4, 0.65, 0.72),
    upper = c(0.6, 0.8, 0.8, NaN, 0.72, 0.84, 0.98),
    mean_monitored = c(4.5, 12.6, 14.6, 20.2, 14.2, 15.7, 18.7),
    sum_dead = c(3L, 3L, 3L, 0L, 7L, 2L, 4L),
    sum_alive = c(39L, 149L, 179L, 242L, 251L, 124L, 365L),
    status = c(
      "Only 9 months monitored - ", " - ", " - ", " - ", " - ", " - ",
      " - "
    )
  )

  plot <- bbr_plot_survival(survival_est)
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_survival_test_data_7")

  plot <- bbr_plot_survival(survival_est[1:4, ])
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_survival_test_data_4")

  plot <- bbr_plot_survival(survival_est[1, ])
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_survival_test_data_1")
})

test_that("errors if no year column", {
  survival_est <- data.frame(
    PopulationName = c("A", "A", "A", "A"),
    estimate = c(0.57, 0.72, 0.75, 1),
    se = c(0.05, 0.03, 0.03, 0),
    lower = c(0.5, 0.7, 0.7, NaN),
    upper = c(0.6, 0.8, 0.8, NaN),
    mean_monitored = c(4.5, 12.6, 14.6, 20.2),
    sum_dead = c(3L, 3L, 3L, 0L),
    sum_alive = c(39L, 149L, 179L, 242L),
    status = c(
      "Only 9 months monitored - ", " - ", " - ",
      " - No Mortalities all year (SE=0)"
    )
  )

  expect_error(
    bbr_plot_survival(survival_est),
    regexp = "`names\\(survival\\)` must include 'CaribouYear'\\."
  )
})

test_that("errors if list passed", {
  survival_est <- list()

  expect_error(
    bbr_plot_survival(survival_est),
    regexp = "`survival` must inherit from S3 class 'data\\.frame'\\."
  )
})

test_that("errors if df is empty", {
  survival_est <- data.frame(
    PopulationName = "A",
    CaribouYear = 2001L
  )[0, ]

  expect_error(
    bbr_plot_survival(survival_est),
    regexp = "survival must have rows"
  )
})
