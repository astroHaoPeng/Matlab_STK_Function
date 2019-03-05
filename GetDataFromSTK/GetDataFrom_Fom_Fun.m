function y = GetDataFrom_Fom_Fun(fom,Definition_Type,Compute_Type,Satisfaction_Type,Satisfaction_Threshold)
%   获取Fom->Static Satisfaction->Percent Satisfiedd的数据
fom.SetDefinitionType(Definition_Type);
fom.Definition.SetComputeType(Compute_Type);
fomSatisfactionTemp=fom.Definition.Satisfaction;
fomSatisfactionTemp.EnableSatisfaction=1;
fomSatisfactionTemp.SatisfactionType=Satisfaction_Type;
if(strcmp(Definition_Type,'eFmNAssetCoverage') || strcmp(Definition_Type,'eFmNumberOfAccesses'))
    fomSatisfactionTemp.SatisfactionThreshold=int16(Satisfaction_Threshold);
end
if(strcmp(Definition_Type,'eFmCoverageTime')  ||  strcmp(Definition_Type,'eFmRevisitTime'))
    fomSatisfactionTemp.SatisfactionThreshold=double(Satisfaction_Threshold);
end
FomData=fom.DataProviders;
StaticSatisfactionData=FomData.Item('Static Satisfaction').Exec;
TempValue=StaticSatisfactionData.DataSets.GetDataSetByName('Percent Satisfied').GetValues;
y=cell2mat(TempValue);
end


%%   Definition_Type
% eFmAccessConstraint 0 Access Constraint Figure of Merit.  
% eFmAccessDuration 1 Access Duration Figure of Merit.  
% eFmAccessSeparation 2 Access Separation Figure of Merit.  
% eFmCoverageTime 3 Coverage Time Figure of Merit.  
% eFmDilutionOfPrecision 4 Dilution of Precision Figure of Merit.  
% eFmNAssetCoverage 5 N Asset Coverage Figure of Merit.  
% eFmNavigationAccuracy 6 Navigation Accuracy Figure of Merit.  
% eFmNumberOfAccesses 7 Number of Accesses Figure of Merit.  
% eFmNumberOfGaps 8 Number of Gaps Figure of Merit.  
% eFmResponseTime 9 Response Time Figure of Merit.  
% eFmRevisitTime 10 Revisit Time Figure of Merit.  
% eFmSimpleCoverage 11 Simple Coverage Figure of Merit.  
% eFmTimeAverageGap 12 Time Average Gap Figure of Merit.  
% eFmSystemResponseTime 13 System Response Time Figure of Merit.  
% eFmAgeOfData 14 Age of Data Figure of Merit.  
% eFmScalarCalculation 15 Scalar Calculation Figure of Merit. 

%% Compute_Type
% eFmComputeUnknown -1 Unknown compute option.  
% eAverage 0 Refer to STK Coverage help under the applicable figure of merit.  
% eMaximum 1 Refer to STK Coverage help under the applicable figure of merit.  
% eMinimum 2 Refer to STK Coverage help under the applicable figure of merit.  
% ePercentAbove 3 Refer to STK Coverage help under the applicable figure of merit.  
% ePercentBelow 4 Refer to STK Coverage help under the applicable figure of merit.  
% eStdDeviation 5 Refer to STK Coverage help under the applicable figure of merit.  
% eMaxPerDay 6 Refer to STK Coverage help under the applicable figure of merit.  
% eMaxPercentPerDay 7 Refer to STK Coverage help under the applicable figure of merit.  
% eMinPerDay 8 Refer to STK Coverage help under the applicable figure of merit.  
% eMinPercentPerDay 9 Refer to STK Coverage help under the applicable figure of merit.  
% ePerDay 10 Refer to STK Coverage help under the applicable figure of merit.  
% ePerDayStdDev 11 Refer to STK Coverage help under the applicable figure of merit.  
% ePercent 12 Refer to STK Coverage help under the applicable figure of merit.  
% ePercentPerDay 13 Refer to STK Coverage help under the applicable figure of merit.  
% ePercentPerDayStdDev 14 Refer to STK Coverage help under the applicable figure of merit.  
% ePercentTimeAbove 15 Refer to STK Coverage help under the applicable figure of merit.  
% eTotal 16 Refer to STK Coverage help under the applicable figure of merit.  
% eTotalTimeAbove 17 Refer to STK Coverage help under the applicable figure of merit.  
% ePercentBelowGapsOnly 18 Refer to STK Coverage help under the applicable figure of merit.  
% eNumPercentBelow 19 Refer to STK Coverage help under the applicable figure of merit.  
% eAvgPerDay 20 Refer to STK Coverage help under the applicable figure of merit.  
% eInSpan 21 Refer to STK Coverage help under the applicable figure of merit.  
% eInSpanPerDay 22 Refer to STK Coverage help under the applicable figure of merit.  
% eSum 23 Refer to STK Coverage help under the applicable figure of merit.  
% eUnique 24 Refer to STK Coverage help under the applicable figure of merit.  

%% Satisfaction_Type
% eFmAtLeast 0 The figure of merit is greater than or equal to the threshold.  
% eFmAtMost 1 The figure of merit is less than or equal to the threshold.  
% eFmEqualTo 2 The figure of merit is equal to the threshold.  
% eFmGreaterThan 3 The figure of merit is greater than the threshold.  
% eFmLessThan 4 The figure of merit is less than the threshold.  

