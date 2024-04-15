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

save_png <- function(x, width = 400, height = 400) {
  path <- tempfile(fileext = ".png")
  grDevices::png(path, width = width, height = height)
  on.exit(grDevices::dev.off())
  print(x)
  path
}

save_csv <- function(x, digits) {
  path <- tempfile(fileext = ".csv")
  x <- round_df_sigs(x, digits)
  readr::write_csv(x, path)
  path
}

expect_snapshot_plot <- function(x, name) {
  testthat::skip_on_ci()
  path <- save_png(x)
  testthat::expect_snapshot_file(path, paste0(name, ".png"))
}

expect_snapshot_data <- function(x, name, digits = 3) {
  testthat::skip_on_os("windows")
  path <- save_csv(x, digits)
  testthat::expect_snapshot_file(path, paste0(name, ".csv"))
}

round_df_sigs <- function(df, digits) {
  x <- vapply(df, class, FUN.VALUE = "")
  names(x)
  nums <- which(x == "numeric")
  num_cols <- names(x)[nums]

  df <- df |>
    dplyr::mutate(
      dplyr::across(dplyr::all_of(num_cols), ~ signif(.x, digits = digits))
    )
  df
}

check_df_class <- function(df) {
  vapply(df, class, FUN.VALUE = "")
}
