#' Summarize lambda
#'
#' @param L 
#'
#' @return
#' @export
#'
#' @examples
SummarizeLambda<-function(L) {
  Lsum<-L$Summary
  Lsum[c(3:12)]<-round(Lsum[c(3:12)],3)
  print(Lsum)
  return(Lsum)
}