#' Plot survival
#'
#' @param S 
#'
#' @return
#' @export
#'
#' @examples
PlotSurvival<-function(S){
  ggplot(S,aes(Year,S))+
    geom_point(color='red',size=3)+
    geom_errorbar(aes(x=Year,ymin=S_CIL, ymax=S_CIU),color='steelblue')+
    scale_y_continuous(breaks=seq(0,1,0.1))+
    xlab("Year")+
    ylab("Adult female survival")+
    facet_wrap(~PopulationName,scales="free_x")+
    theme_bw(base_size=14)  
}