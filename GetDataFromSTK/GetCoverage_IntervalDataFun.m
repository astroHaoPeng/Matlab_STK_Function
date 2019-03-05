function [accessStartTimes,accessStopTimes] = GetCoverage_IntervalDataFun(Coverage,TimeOption,OutPutOption)
if nargin<3
    OutPutOption=-1;
end
StartTime= TimeOption.StartTime;
StopTime=  TimeOption.StopTime;
AccessData=Coverage.DataProviders;
DataCollection=AccessData.GetDataPrvIntervalFromPath('Object Coverage');
DataElements  =DataCollection.Exec(StartTime, StopTime);
if OutPutOption>0
    %% 字符串的UTC时间
    accessStartTimes = (DataElements.DataSets.GetDataSetByName('Access Start').GetValues);
    accessStopTimes = (DataElements.DataSets.GetDataSetByName('Access End').GetValues);
else
    %% 相对开始间的秒数
    accessStartTimes=cell2mat(DataElements.DataSets.GetDataSetByName('Access Start').GetInternalUnitValues);
    accessStopTimes=cell2mat(DataElements.DataSets.GetDataSetByName('Access End').GetInternalUnitValues);    
end
end