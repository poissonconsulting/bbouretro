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
  x <- vapply(df, class, FUN.VALUE="")
  names(x)
  nums <- which(x == "numeric")
  num_cols <- names(x)[nums]
  
  df <- df |>
    dplyr::mutate(
      dplyr::across(dplyr::all_of(num_cols), ~ signif(.x , digits = digits))
    )
  df
}