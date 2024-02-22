#' Plot lambda
#'
#' @param L 
#'
#' @return
#' @export
#'
#' @examples
plotLambda<-function(L){
  plotdat<-L$Summary
  
  ggplot(plotdat,aes(Year,Lambda))+
    geom_point(color='red',size=3)+
    geom_errorbar(aes(x=Year,ymin=Lambda_LCL, ymax=Lambda_UCL),color='steelblue')+
    geom_hline(yintercept=1)+
    facet_wrap(~PopulationName,ncol=1)+
    xlab("Year")+
    ylab("Lambda estimate")+
    theme_bw()  
}
