
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

chk_set <- function(x, list, name) {
  if (x %in% list[[name]]$PopulationName) {
    return(invisible(x))
  }
  
  rlang::abort(
    paste(
      "The population", x, "is not present in the", name, "table."
    )
  )
}

# Bootstrap ---------------------------------------------------------------

RecCalc <- function(C, indices) {
  d <- C[indices, ]
  CCF <- sum(d$FemaleCalves) / sum(d$Females)
  Rec <- CCF / (1 + CCF)
  Rec
}