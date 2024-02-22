#' Simulate lambda
#'
#' @param CompfullR 
#' @param YearSurvR 
#'
#' @return
#' @export
#'
#' @examples
LambdaSim<-function(CompfullR,YearSurvR)  {
  
  #merge the comp and survival databases
  LambdaSum<-merge(CompfullR,YearSurvR,by=c("PopulationName",'Year'))
  #Lambda estimate using the H-B equation
  LambdaSum$Lambda<-LambdaSum$S/(1-LambdaSum$R)
  
  #total number of groups (projectXYear) for sims
  groups<-nrow(LambdaSum)
  #fix sims at 1000
  sims<-1000
  
  #generate random normal data frames for survival and recruitment and group number to each 
  #set of 1000 random numbers.  Use seperate random numbers for S and R to ensure independence
  rnnors<-data.frame(rnorm(groups*sims))
  names(rnnors)<-"RannorS"
  rnnors$RannorR<-rnorm(groups*sims)
  rnnors$nrow<-1:nrow(rnnors)
  rnnors$group<-rep(seq(1,groups,1),1000)
  rnnors<-arrange(rnnors,group)
  
  #merge the random numbers with input data set based on group/row #
  #this expands the data frame 1000X
  LambdaSum$group<-1:nrow(LambdaSum)
  LambdaSumSim<-merge(LambdaSum,rnnors,by="group")
  
  #put the estimated parameters on the logit scale
  LambdaSumSim<-transform(LambdaSumSim,
                          Slogit=log(S/(1-S)),
                          Svarlogit=S_SE^2/(S^2*((1-S)^2)),
                          Rlogit=log(R/(1-R)),
                          Rvarlogit=R_SE^2/(R^2*((1-R)^2)))
  
  #generate random values by adding random variation based on the SE of estimates-transform back to 0 to 1 interval.
  LambdaSumSim<-transform(LambdaSumSim,
                          RanS=(1/(1+exp(-1*(Slogit+ RannorS*(Svarlogit^0.5))))),
                          RanR=(1/(1+exp(-1*(Rlogit+ RannorR*(Rvarlogit^0.5))))))
  
  #random H-B lambda based on simulated R and S                           
  LambdaSumSim$RanLambda<-LambdaSumSim$RanS/(1-LambdaSumSim$RanR)
  LambdaSumSim$LGT1<-ifelse(LambdaSumSim$RanLambda>1,1,0)
  
  #An abriged data set with raw simulated values for later plotting etc.
  LambdaSumSimR<-LambdaSumSim[c("PopulationName","Year","S","R","Lambda","RanLambda","RanS","RanR")]
  
  #summary of simulation and percentile based estimated CI's for lambda
  SumLambda<-ddply(LambdaSumSim,c("PopulationName","Year","S","R","Lambda"),summarize,
                   SE_Lambda=sd(RanLambda,na.rm=T),
                   Lambda_LCL=quantile(RanLambda,0.025,na.rm=T),
                   Lambda_UCL=quantile(RanLambda,0.975,na.rm=T),
                   Prop_LGT1=mean(LGT1),
                   meanSimSurv=mean(RanS,na.rm=T),
                   meanRsim=mean(RanR,na.rm=T),
                   meanSimLambda=mean(RanLambda,na.rm=T),
                   medianSimLambda=median(RanLambda ))
  
  #create a list that contains raw and summarized output
  LambdaOut<-list(LambdaSumSimR,SumLambda)
  names(LambdaOut)<-c("RawValues","Summary")
  
  return(LambdaOut)
}
