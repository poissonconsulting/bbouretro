#' Calculate recruitment
#'
#' @param Rsamps 
#' @param pFemales 
#' @param sexratio 
#' @param variance 
#'
#' @return
#' @export
#'
#' @examples
#' Rsamps<-RsampsC
#' pFemales<-0.65
#' sexratio<-0.5
#' variance<-"binomial"
#' #... tbd
Recruitment<-function(Rsamps,pFemales,sexratio,variance)  {
  
  #Estimate total females based on pFemales and sexratio
  Rsamps<-transform(Rsamps,
                    Females=Cows+UnknownAdults*pFemales+Yearlings*sexratio,
                    FemaleCalves=Calves*sexratio)
  
  #summarize by population and year
  Compfull<-ddply(Rsamps,c("PopulationName","Year"),summarize,
                  Females=sum(Females),
                  FemaleCalves=sum(FemaleCalves),
                  Calves=sum(Calves),
                  UnknownAdults=sum(UnknownAdults),
                  Bulls=sum(Bulls),
                  Yearlings=sum(Yearlings),
                  groups=length(Year))
  
  #Estimate recruitment based on full data set.
  #Calf cow based on male/female calves           
  Compfull$CalfCow<-Compfull$Calves/Compfull$Females
  #Calf cow for female calves is 1/2 of CC with female/male calves
  Compfull$CalfCowF<-Compfull$CalfCow*sexratio
  #Recruitment using DeCesare correction
  Compfull$R<-Compfull$CalfCowF/(1+Compfull$CalfCowF)
  
  #variance estimation-in progress.....
  #simple binomial variance estimate-right now uses females but may not be statistically correct!
  if (variance=="binomial") {
    Compfull$BinVar<-(Compfull$R*(1-Compfull$R))/Compfull$Females
    Compfull$R_SE<-Compfull$BinVar^0.5
    
    #logit-based confidence limits assuing R is constrained between 0 and 1.
    Compfull<-transform(Compfull,
                        logits=log(R/(1-R)), 
                        varlogit=BinVar/(R^2*((1-R)^2)))
    Compfull$R_CIU<-1/(1+exp(-1*(Compfull$logits+ 1.96*(Compfull$varlogit**0.5))))
    Compfull$R_CIL<-1/(1+exp(-1*(Compfull$logits- 1.96*(Compfull$varlogit**0.5))))
  }
  
  #bootstrap approach...in progress....
  if (variance=="bootstrap") {
    
    #a function to bootrap
    RecCalc<-function(C,indices) {
      d <- C[indices,]
      CCF<-sum(d$FemaleCalves)/sum(d$Females)
      Rec<-CCF/(1+CCF)
      return(Rec)
    }
    
    #use ddply to bootstrap by Population and year
    boot<-  dlply(Rsamps,c("PopulationName","Year"), function(Rsamps) boot(data=Rsamps, RecCalc,R=1000))
    #need to write a way to extract SE and percentile CI's from boot list..... 
  }
  
  #add in other formula with finite correction??  To do this would need data frame of f values......
  
  #An abbreviated output data set.
  CompfullR<-cbind(Compfull[c("PopulationName","Year","R","R_SE", "R_CIL","R_CIU","groups","FemaleCalves","Females")], sexratio , pFemales)
  CompfullR[c(3:6)]<-round(CompfullR[c(3:6)],3)
  
  return (CompfullR)
}