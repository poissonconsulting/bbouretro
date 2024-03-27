# White, G.C., Burnham, K.P., and Anderson, D.R. 2001. Advanced features of Program Mark. In Wildlife, land, and people: prioritiesfor the 21st century. Edited by R. Field, R.J. Warren, H. Okarma, and P.R. Sievert. The Wildlife Society, Bethesda, Maryland. pp. 368–377.
logit_se <- function(se, estimate) {
  sqrt(se^2/(estimate^2 * (1 - estimate)^2))
}

logit <- function(x) {
  qlogis(x)
}

ilogit <- function(x) {
  plogis(x)
}
