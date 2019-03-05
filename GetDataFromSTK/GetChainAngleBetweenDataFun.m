function y = GetChainAngleBetweenDataFun(chain,TimeOption)

chainData=chain.DataProviders;
DataCollection=chainData.Item('Angle Between').Group.Item('Granularity Determined');
%% ÉèÖÃÊ±¼ä×´Ì¬
if(nargin>1)
    StartTime= TimeOption.StartTime;
    StopTime=  TimeOption.StopTime;
    Step   =   TimeOption.Step;
else
    StartTime=chain.TimePeriod.Start;
    StopTime=chain.TimePeriod.Stop;
    Step     =60.0;
    
end
DataElements=DataCollection.Exec(StartTime,StopTime,Step).DataSets;
BetweenAngle=cell2mat(DataElements.GetDataSetByName('Angle').GetValues);
DataElements.GetDataSetByName('Time').GetValues
y=BetweenAngle;
end