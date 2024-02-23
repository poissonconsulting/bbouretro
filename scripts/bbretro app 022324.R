#bbretro functions
#DRAFT Feb 23,2024
#John Boulanger, IER

 #the following packages are required.
 library(dplyr)
 library(plyr)
 library(ggplot2)
 library(boot)
 #library(remotes)
 #library(devtools)
 #devtools::install_github("poissonconsulting/bboudata")
 library(bboudata)

   
 





#FUNCTIONS

#Recruitment function
Recruitment<-function(Rsamps,pFemales,sexratio,variance)  {

 #use this code for testing.....
 #Rsamps<-RsampsC
 #pFemales<-0.65
 #sexratio<-0.5
 #variance<-"binomial"
  
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
         
         pc <- purrr::map_df(names(boot), function(x){
           boots <- boot[[x]]$t
           year <- strsplit(x, split = "\\.")[[1]][2]
           pop <- strsplit(x, split = "\\.")[[1]][1]
           quants <- quantile(boots, c(0.025, 0.5, 0.975))
           SE<-sd(boots)
           tibble::tibble(PopulationName = pop, 
                          Year = year, 
                          medianboot = quants[2],
                          R_SE=SE,
                          R_CIL = quants[1],
                          R_CIU = quants[3])
         })
         
         Compfull<-merge(Compfull,pc[c("PopulationName","Year","R_SE","R_CIL","R_CIU")],by=c("PopulationName","Year"))
    }
  
   
  #An abbreviated output data set.
  CompfullR<-cbind(Compfull[c("PopulationName","Year","R","R_SE", "R_CIL","R_CIU","groups","FemaleCalves","Females")], sexratio , pFemales)
  CompfullR[c(3:6)]<-round(CompfullR[c(3:6)],3)
  
return (CompfullR)
}
 
#Plot recruitment
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


#Survival rate function
KMsurvival<-function(Ssamps,MortType,variance)  {
#suggest we make MortType="Total" and variance="Pollock" default settings.
   
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

#plot survival function
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
  
#Simulate Lambda function
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

#A function that extracts the summary from the Lambda list
SummarizeLambda<-function(L) {
  Lsum<-L$Summary
  Lsum[c(3:12)]<-round(Lsum[c(3:12)],3)
  print(Lsum)
 return(Lsum)
}

#Plot simulated lambda distributions--for a chosen population
plotLambdaDistributions<-function(L,Pop){
 
  #subset data set for target population
  Ld<-subset(L$RawValues,L$RawValues$PopulationName==Pop) 
  RL<-subset(L$Summary,L$Summary$PopulationName==Pop) 
 
  #screen out sims where random lambda is NA (likely due to S=1 with 0 variance)
  #year is still plotted as a line but with no distribution
  LrawR<-subset(Ld,is.na(Ld$RanLambda)==F)
 
  #set lambda limits for x axis based all lambda--this reduces influence of outliers
  xmin<-quantile(LrawR$RanLambda,0.0001) 
  xmax<-quantile( LrawR$RanLambda,0.99) 
  #make sure that limits are still within range of lambda estimates for estimates with no CI's
  xmax<-ifelse(xmax<=max(RL$Lambda),max(RL$Lambda)+0.05,xmax)
  xmin<-ifelse(xmin>=min(RL$Lambda),min(RL$Lambda)-0.05,xmin)
  
  #subset data based on xlimits-this works better than using xlim or coord_cartesian in ggplot
  LrawR<-subset(LrawR,LrawR$RanLambda>=xmin & LrawR$RanLambda<=xmax )
  
  #plot estimated lambda for each year as a red line with 
  #a black hashed line indicates lambda=1.
    ggplot(LrawR,aes(RanLambda))+
    geom_histogram(bins=30,fill="tan",color="black")+
    geom_vline(data=RL, aes(xintercept=Lambda),  color="red")+
    geom_vline(xintercept=1,linetype=2,color="black")+
    facet_wrap(~Year)+
    xlab("Lambda Values")+
    ylab("Frequencies")+
    theme_bw()
}
 
#plot Lambda estimates
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
 
#EXAMPLES with bboudata data sets

#with A
Rec_A<-Recruitment(bbourecruit_a,pFemales=0.65,sexratio=0.5,variance="bootstrap") 
S_A<-KMsurvival(bbousurv_a,MortType="Total",variance="Pollock")
PlotRecruitment(Rec_A)
PlotSurvival(S_A)
Lambdadat_A<-LambdaSim(Rec_A,S_A)
Summary_A<-SummarizeLambda(Lambdadat_A)
plotLambda(Lambdadat_A)
plotLambdaDistributions(Lambdadat_A,"A")

#with B
Rec_B<-Recruitment(bbourecruit_b,pFemales=0.65,sexratio=0.5,variance="binomial") 
S_B<-KMsurvival(bbousurv_b,MortType="Total",variance="Pollock")
PlotRecruitment(Rec_B)
PlotSurvival(S_B)
Lambdadat_B<-LambdaSim(Rec_B,S_B)
Summary_B<-SummarizeLambda(Lambdadat_B)
plotLambda(Lambdadat_B)
plotLambdaDistributions(Lambdadat_B,"B")


#with C
Rec_C<-Recruitment(bbourecruit_c,pFemales=0.65,sexratio=0.5,variance="binomial") 
S_C<-KMsurvival(bbousurv_c,MortType="Total",variance="Pollock")
PlotRecruitment(Rec_C)
PlotSurvival(S_C)
Lambdadat_C<-LambdaSim(Rec_C,S_C)
Summary<-SummarizeLambda(Lambdadat_C)
plotLambda(Lambdadat_C)
plotLambdaDistributions(Lambdadat_C,"C")



