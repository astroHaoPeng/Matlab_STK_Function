function [accessStartTimes,accessStopTimes] = GetAccess_IntervalDataFun(access,TimeOption)

StartTime= TimeOption.StartTime;
StopTime=  TimeOption.StopTime;
AccessData=access.DataProviders;
%DataCollection=AccessData.Item('Access Data').Group.Item('Center');
DataCollection=AccessData.GetDataPrvIntervalFromPath('Access Data');
DataElements  =DataCollection.Exec(StartTime, StopTime);
%% 字符串的UTC时间
accessStartTimes = cell2mat(DataElements.DataSets.GetDataSetByName('Start Time').GetValues);
accessStopTimes = cell2mat(DataElements.DataSets.GetDataSetByName('Stop Time').GetValues);
%% 相对开始间的秒数
StartTimeIntervals=cell2mat(DataElements.DataSets.GetDataSetByName('Start Time').GetInternalUnitValues)
StopTimeIntervals=cell2mat(DataElements.DataSets.GetDataSetByName('Stop Time').GetInternalUnitValues)
end