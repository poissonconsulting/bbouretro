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

test_that("keeps all when less then 6", {
  x <- c(1, 2, 3, 4, 5)
  output <- every_nth(2)(x)
  expect_equal(output, x)
})

test_that("cuts every 2nd value when more then 6", {
  x <- c(1, 2, 3, 4, 5, 6, 7)
  output <- every_nth(2)(x)
  expect_equal(output, c(1, 3, 5, 7))
})

test_that("pass when df has at least 1 row", {
  x <- data.frame(x = 1)
  output <- chk_has_data(x) 
  expect_equal(output, data.frame(x = 1))
})

test_that("error when df has no rows", {
  x <- data.frame()
  expect_error(
    chk_has_data(x),
    regex = "x must have rows"
  )  
})