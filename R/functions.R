
# Checks ------------------------------------------------------------------

vld_overlap <- function(x, values) {
  any(x %in% values)
}

chk_overlap <- function(x, y, variable) {
  x <- x[[variable]]
  y <- y[[variable]]
  
  if (vld_overlap(x, y)) {
    return(invisible(x))
  }
  rlang::abort(
    paste(
      variable, 
      "must have overlapping values in recruitment and survival."
    )
  )
}

chk_has_data <- function(x) {
  if (dim(x)[1] > 0) {
    return(x)
  }
  
  rlang::abort(paste(deparse(substitute(x)), "must have rows"))
}
