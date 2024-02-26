#' Plot lambda distributions
#'
#' @param L 
#' @param Pop 
#'
#' @return
#' @export
#'
#' @examples
plotLambdaDistributions<-function(L,Pop){
  
  #subset data set for target population
  Ld<-subset(L$RawValues,L$RawValues$PopulationName==Pop) 
  RL<-subset(L$Summary,L$Summary$PopulationName==Pop) 
  Lraw<-L$RawValues
  
  #screen out sims where random lambda is NA (likely due to S=1 with 0 variance)
  #year is still plotted as a line but with no distribution
  LrawR<-subset(Lraw,is.na(Lraw$RanLambda)==F)
  
  #plot estimated lambda for each year as a red line with 
  #a black hashed line indicates lambda=1.
  ggplot(LrawR,aes(RanLambda))+
    geom_histogram(bins=30,fill="tan",color="black")+
    geom_vline(data=RL, aes(xintercept=Lambda),  color="red")+
    geom_vline(xintercept=1,linetype=2,color="black")+
    scale_x_continuous(breaks=seq(0.2,1.4,0.4))+
    facet_wrap(~Year)+
    xlab("Lambda Values")+
    ylab("Frequencies")+
    theme_bw()
}