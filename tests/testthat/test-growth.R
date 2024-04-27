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

    output <-
      data.frame(
        round_df_sigs(
          bbr_growth(survival_est, recruitment_est), 3
        )
      )

    expect_snapshot({
      print(
        output
      )
    })

    expect_snapshot(
      print(
        check_df_class(output)
      )
    )
  })
})

test_that("pop b works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_b,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_b,
      mort_type = "total",
      variance = "cox_oakes"
    )

    output <-
      data.frame(
        round_df_sigs(
          bbr_growth(survival_est, recruitment_est), 3
        )
      )

    expect_snapshot({
      print(
        output
      )
    })

    expect_snapshot(
      print(
        check_df_class(output)
      )
    )
  })
})

test_that("pop c works", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_c,
      mort_type = "total",
      variance = "cox_oakes"
    )

    output <-
      data.frame(
        round_df_sigs(
          bbr_growth(survival_est, recruitment_est), 3
        )
      )

    expect_snapshot({
      print(
        output
      )
    })

    expect_snapshot(
      print(
        check_df_class(output)
      )
    )
  })
})

test_that("test data works", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = rep("C", 4),
      CaribouYear = c(2003L, 2004L, 2005L, 2006L),
      estimate = c(0.01, 0.02, 0.02, 0.03),
      se = c(0.01, 0.02, 0.02, 0.03),
      lower = c(0.01, 0.02, 0.02, 0.03),
      upper = c(0.01, 0.02, 0.02, 0.03),
      groups = c(10L, 15L, 12L, 4L),
      female_calves = c(7, 6, 3.5, 1),
      females = c(66, 69, 47.95, 16)
    )

    survival_est <- data.frame(
      PopulationName = rep("C", 4),
      CaribouYear = c(2003L, 2004L, 2005L, 2006L),
      estimate = c(0.5, 0.7, 0.9, 1),
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

    output <-
      data.frame(
        round_df_sigs(
          bbr_growth(survival_est, recruitment_est), 3
        )
      )

    expect_snapshot({
      print(
        output
      )
    })

    expect_snapshot(
      print(
        check_df_class(output)
      )
    )
  })
})

test_that("errors if no populations overlap", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = c("A", "A", "A", "A"),
      CaribouYear = c(2003L, 2004L, 2005L, 2006L),
      estimate = c(0.01, 0.02, 0.02, 0.03),
      se = c(0.01, 0.02, 0.02, 0.03),
      lower = c(0.01, 0.02, 0.02, 0.03),
      upper = c(0.01, 0.02, 0.02, 0.03),
      groups = c(10L, 15L, 12L, 4L),
      female_calves = c(7, 6, 3.5, 1),
      females = c(66, 69, 47.95, 16)
    )

    survival_est <- data.frame(
      PopulationName = c("C", "C", "C", "C"),
      CaribouYear = c(2003L, 2004L, 2005L, 2006L),
      estimate = c(0.5, 0.7, 0.9, 1),
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
      bbr_growth(survival_est, recruitment_est),
      regexp = "recruitment and survival must have overlapping values in ."
    )
  })
})

test_that("errors if no years overlap", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = c("C", "C", "C", "C"),
      CaribouYear = c(2007L, 2008L, 2009L, 2010L),
      estimate = c(0.01, 0.02, 0.02, 0.03),
      se = c(0.01, 0.02, 0.02, 0.03),
      lower = c(0.01, 0.02, 0.02, 0.03),
      upper = c(0.01, 0.02, 0.02, 0.03),
      groups = c(10L, 15L, 12L, 4L),
      female_calves = c(7, 6, 3.5, 1),
      females = c(66, 69, 47.95, 16)
    )

    survival_est <- data.frame(
      PopulationName = c("C", "C", "C", "C"),
      CaribouYear = c(2003L, 2004L, 2005L, 2006L),
      estimate = c(0.5, 0.7, 0.9, 1),
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
      bbr_growth(survival_est, recruitment_est),
      regexp = "recruitment and survival must have overlapping values."
    )
  })
})

test_that("errors when recruitment has rows passed", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )[0, ]

    survival_est <- bbr_survival(
      bboudata::bbousurv_c,
      mort_type = "total",
      variance = "cox_oakes"
    )

    chk::expect_chk_error(
      bbr_growth(survival_est, recruitment_est),
      regexp = "must"
    )
  })
})

test_that("errors when survival has rows passed", {
  withr::with_seed(10, {
    recruitment_est <- bbr_recruitment(
      bboudata::bbourecruit_c,
      p_females = 0.65,
      sex_ratio = 0.5,
      variance = "binomial"
    )

    survival_est <- bbr_survival(
      bboudata::bbousurv_c,
      mort_type = "total",
      variance = "cox_oakes"
    )[0, ]

    chk::expect_chk_error(
      bbr_growth(survival_est, recruitment_est),
      regexp = "must"
    )
  })
})

test_that("NA instead in dataset work", {
  withr::with_seed(10, {
    recruitment_est <- data.frame(
      PopulationName = c("C", "C", "C", "C"),
      CaribouYear = c(2007L, 2008L, 2009L, 2010L),
      estimate = c(0.01, 0.02, 0.02, 0.03),
      se = c(0.01, 0.02, 0.02, 0.03),
      lower = c(0.01, 0.02, 0.02, 0.03),
      upper = c(0.01, 0.02, 0.02, 0.03),
      groups = c(10L, 15L, 12L, 4L),
      female_calves = c(7, 6, 3.5, 1),
      females = c(66, 69, 47.95, 16)
    )

    survival_est <- data.frame(
      PopulationName = c("C", "C", "C", "C"),
      CaribouYear = c(2007L, 2008L, 2009L, 2010L),
      estimate = c(0.5, 0.7, 0.9, 1),
      se = c(0.05, 0.03, 0.03, 0),
      lower = c(0.5, 0.7, 0.7, NA),
      upper = c(0.6, 0.8, 0.8, NA),
      mean_monitored = c(4.5, 12.6, 14.6, 20.2),
      sum_dead = c(3L, 3L, 3L, 0L),
      sum_alive = c(39L, 149L, 179L, 242L),
      status = c(
        "Only 9 months monitored - ", " - ", " - ",
        " - No Mortalities all year (SE=0)"
      )
    )

    output <-
      data.frame(
        round_df_sigs(
          bbr_growth(survival_est, recruitment_est), 3
        )
      )

    expect_snapshot({
      print(
        output
      )
    })

    expect_snapshot(
      print(
        check_df_class(output)
      )
    )
  })
})
