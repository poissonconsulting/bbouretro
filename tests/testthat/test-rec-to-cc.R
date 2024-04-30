test_that("bbr_rec_to_cc works", {
  expect_identical(bbr_rec_to_cc(numeric(0)), numeric(0))
  expect_identical(bbr_rec_to_cc(NA_real_), NA_real_)
  expect_identical(bbr_rec_to_cc(0), 0)
  expect_identical(bbr_rec_to_cc(0.5), 2)
  expect_identical(bbr_rec_to_cc(0.5, sex_ratio = 1), 1)
  x <- c(0.25, 0.5, NA)
  expect_equal(bbr_rec_to_cc(x), c(2/3, 2, NA))
  expect_equal(bbr_cc_to_rec(bbr_rec_to_cc(x)),  x)
  expect_equal(bbr_cc_to_rec(bbr_rec_to_cc(x, sex_ratio = 0.7), sex_ratio = 0.7),  x)
})


test_that("bbr_cc_to_rec works", {
  expect_identical(bbr_cc_to_rec(numeric(0)), numeric(0))
  expect_identical(bbr_cc_to_rec(NA_real_), NA_real_)
  expect_identical(bbr_cc_to_rec(0), 0)
  expect_identical(bbr_cc_to_rec(0.5), 0.2)
  expect_identical(bbr_cc_to_rec(0.5, sex_ratio = 1), 1/3)
  x <- c(0.25, 0.5, NA)
  expect_equal(bbr_cc_to_rec(x), c(1/9, 1/5, NA))
  expect_equal(bbr_rec_to_cc(bbr_cc_to_rec(x)),  x)
  expect_equal(bbr_rec_to_cc(bbr_cc_to_rec(x, sex_ratio = 0.7), sex_ratio = 0.7),  x)
})
