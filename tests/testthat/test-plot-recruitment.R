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

    plot <- bbr_plot_recruitment(recruitment_est)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_recruitment_pop_a")
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

    plot <- bbr_plot_recruitment(recruitment_est)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_recruitment_pop_b")
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
    plot <- bbr_plot_recruitment(recruitment_est)

    expect_s3_class(plot, "ggplot")
    expect_snapshot_plot(plot, "plot_recruitment_pop_c")
  })
})

test_that("test xaxis labels", {
  recruitment_est <- data.frame(
    PopulationName = rep("A", 7),
    Year = c(2003L, 2004L, 2005L, 2006L, 2007L, 2008L, 2009L),
    R = c(0.1, 0.2, 0.2, 0.3, 0.3, 0.3, 0.3),
    R_SE = c(0.01, 0.02, 0.02, 0.03, 0.03, 0.03, 0.03),
    R_CIL = c(0.01, 0.02, 0.02, 0.03, 0.03, 0.03, 0.03),
    R_CIU = c(0.2, 0.25, 0.35, 0.35, 0.35, 0.35, 0.35),
    groups = c(10L, 15L, 12L, 4L, 7L, 5L, 9L),
    FemaleCalves = rep(7, 7),
    Females = rep(66, 7),
    sexratio = rep(0.5, 7),
    pFemales = rep(0.65, 7)
  )

  plot <- bbr_plot_recruitment(recruitment_est)
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_recruitment_more_then_6")

  plot <- bbr_plot_recruitment(recruitment_est[1:4, ])
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_recruitment_less_then_6")

  plot <- bbr_plot_recruitment(recruitment_est[1, ])
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_recruitment_only_1")
})

test_that("errors if no year column", {
  recruitment_est <- data.frame(
    PopulationName = rep("A", 7),
    R = c(0.1, 0.2, 0.2, 0.3, 0.3, 0.3, 0.3),
    R_SE = c(0.01, 0.02, 0.02, 0.03, 0.03, 0.03, 0.03),
    R_CIL = c(0.01, 0.02, 0.02, 0.03, 0.03, 0.03, 0.03),
    R_CIU = c(0.2, 0.25, 0.35, 0.35, 0.35, 0.35, 0.35),
    groups = c(10L, 15L, 12L, 4L, 7L, 5L, 9L),
    FemaleCalves = rep(7, 7),
    Females = rep(66, 7),
    sexratio = rep(0.5, 7),
    pFemales = rep(0.65, 7)
  )

  expect_error(
    bbr_plot_recruitment(recruitment_est),
    regexp = "`names\\(recruitment\\)` must include 'Year'\\."
  )
})

test_that("errors if list passed", {
  recruitment_est <- list()

  expect_error(
    bbr_plot_recruitment(recruitment_est),
    regexp = "`recruitment` must inherit from S3 class 'data\\.frame'\\."
  )
})

test_that("errors if df is empty", {
  recruitment_est <- data.frame(
    PopulationName = "A",
    Year = 2001L
  )[0, ]

  expect_error(
    bbr_plot_recruitment(recruitment_est),
    regexp = "recruitment must have rows"
  )
})
