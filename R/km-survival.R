# Copyright 2024 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Calculate survival
#'
#' This function estimates survival rates based on the Kaplan Meir survival rate
#' estimator (Pollock et al. 1989).
#'
#' @param x input survival data frame
#' @param MortType Mortality data to be included.   Values can be “Total” which
#'   would be all (MortalitiesCertain and MortalitiesUncertain) or “Certain”,
#'   (MortalitiesCertain only)
#' @param variance Variance type to estimate.  Can be the Greenwood estimator
#'   “Greenwood” or Pollock estimator (“Pollock”)
#'
#' @details 
#' See the vignette Methods for description of equations used. 
#'
#' @return An output data frame with the columns.
#' @export
#'
#' @format A tibble with columns:
#' \describe{
#' \item{PopulationName}{Population name}
#' \item{Year}{Year sampled}
#' \item{S}{Survival estimate }
#' \item{S_SE}{SE}
#' \item{S_CIL}{Confidence limit}
#' \item{S_CIU}{Confidence limit}
#' \item{MeanMonitored}{Mean number of caribou monitored each month}
#' \item{sumdead }{Total number of mortalities in a year}
#' \item{sumalive}{Total number of caribou-months in a year}
#' \item{Status}{Indicates less than 12 months monitored or if there were 0 mortalities in a given year}
#' }
#'
#' @references Pollock, K. H., S. R. Winterstein, C. M. Bunck, and P. D. Curtis.
#' 1989. Survival analysis in telemetry studies: the staggered entry design.
#' Journal of Wildlife Management 53:7-15. TODO Need Cox paper
#'
#' @examples
#' survival_est <- km_survival(bboudata::bbousurv_a, "Total", variance = "Greenwood")
km_survival <- function(x, MortType = "Total", variance = "Pollock") {
  
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
  
  YearSurvR
}
