#' Plot recruitment
#'
#' @param Compout 
#'
#' @return
#' @export
#'
#' @examples
PlotRecruitment<-function(Compout)  {
  
  ggplot(Compout,aes(Year,R))+
    geom_point(color='red',size=3)+
    geom_errorbar(aes(x=Year,ymin=R_CIL, ymax=R_CIU),color='steelblue')+
    scale_y_continuous(breaks=seq(0,1,0.1))+
    xlab("Year")+
    ylab("Recruitment")+
    facet_wrap(~PopulationName,ncol=1)+
    theme_bw(base_size=14)   
}