#' Calculate survival
#'
#' @param Ssamps 
#' @param MortType 
#' @param variance 
#'
#' @return
#' @export
#'
#' @examples
KMsurvival<-function(Ssamps,MortType,variance)  {
  #suggest we make MortType="Total" and variance="Pollock" default settings.
  Ssamps<-SsampsC
  #make sure data set is sorted properly
  Ssamps<-arrange(Ssamps,PopulationName,Year,Month)
  #Tally total mortalities.
  Ssamps$TotalMorts<-Ssamps$MortalitiesCertain+Ssamps$MortalitiesUncertain
  
  #MortType can be "Total" or "Certain"
  Ssamps$MortType<-MortType
  Ssamps$Morts<-ifelse(Ssamps$MortType=="Total",Ssamps$TotalMorts,Ssamps$MortalitiesCertain)
  
  #Months with 0 collars monitored are removed but this is noted to user later and estimates scaled appropriately
  Ssamps<-subset(Ssamps,Ssamps$StartTotal>0)
  
  #calculate monthly components of survival and variance
  LiveDeadCount<-transform(Ssamps,
                           Smonth=(1-(Morts/StartTotal)), 
                           Smonth_varj=Morts/(StartTotal*(StartTotal-Morts)))
  
  #use ddply sum or product each year.
  YearSurv<-ddply(LiveDeadCount, c("PopulationName","Year"),summarize,
                  S=prod(Smonth),
                  S_var1=sum(Smonth_varj),
                  Survmean=mean(Smonth),
                  sumalive=sum(StartTotal),
                  sumdead=sum(Morts),
                  meanalive=mean(StartTotal),
                  minalive=min(StartTotal),
                  maxalive=max(StartTotal),
                  monthcount=length(Year))
  
  
  YearSurv$VarType<-variance
  
  #Variance estimate using the Greenwood formula for variance
  YearSurv$S_Var_Green<- YearSurv$S^2*YearSurv$S_var1 
  #Variance estimate using the Pollock et al 1989 method
  YearSurv$S_Var_Pollock<- (YearSurv$S^2*(1-YearSurv$S))/YearSurv$sumalive 
  YearSurv$S_Var<-ifelse(YearSurv$VarType=="Pollock",YearSurv$S_Var_Pollock,YearSurv$S_Var_Green)
  
  #Put note in output if there are no mortalities or less than 12 years.  Zero mortalities causes variance to be 0
  YearSurv$Status1<-ifelse(YearSurv$monthcount==12,"",paste("Only", YearSurv$monthcount, "months monitored"))
  YearSurv$Status2<-ifelse(YearSurv$sumdead==0,"No Mortalities all year (SE=0)","")
  YearSurv$Status<-paste(YearSurv$Status1,"-", YearSurv$Status2)
  
  #scale estimates to a year if less than 12 months monitored
  YearSurv$S<- YearSurv$S^(12/YearSurv$monthcount)
  YearSurv$S_Var<- YearSurv$S_Var^(12/YearSurv$monthcount)
  YearSurv$S_SE<-YearSurv$S_Var^0.5
  
  #logit-based confidence intervals--formulas based on program MARK.
  YearSurv<-transform(YearSurv,
                      logits=log(S/(1-S)), 
                      varlogit=S_Var/(S^2*((1-S)^2)))
  YearSurv$S_CIU<-1/(1+exp(-1*(YearSurv$logits+ 1.96*(YearSurv$varlogit**0.5)))) 
  YearSurv$S_CIL<-1/(1+exp(-1*(YearSurv$logits- 1.96*(YearSurv$varlogit**0.5)))) 
  
  #round estimates for table.
  YearSurv$MeanMonitored<-round(YearSurv$meanalive,1)
  YearSurv$S<-round(YearSurv$S,3)
  YearSurv$S_SE<-round(YearSurv$S_SE,3)
  YearSurv$S_CIL<-round(YearSurv$S_CIL,3)
  YearSurv$S_CIU<-round(YearSurv$S_CIU,3)
  
  YearSurvR<-YearSurv[c("PopulationName",'Year','S','S_SE','S_CIL','S_CIU','MeanMonitored',"sumdead","sumalive","Status")]
  
  return(YearSurvR)
}