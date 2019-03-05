function AER = GetAccess_AERDataFun(access,TimeOption)
%% 这个函数只是用于连续可见性的AER
StartTime  = TimeOption.StartTime;
StopTime  =  TimeOption.StopTime;
Step          =   TimeOption.Step;
AccessData=access.DataProviders;
DataCollection=AccessData.Item('AER Data').Group.Item('Default');
DataElements  =DataCollection.Exec(StartTime, StopTime,Step).DataSets;
AER_A = cell2mat(DataElements.GetDataSetByName('Azimuth').GetValues);
AER_E = cell2mat(DataElements.GetDataSetByName('Elevation').GetValues);
AER_R = cell2mat(DataElements.GetDataSetByName('Range').GetValues);
AER_ARate = cell2mat(DataElements.GetDataSetByName('AzimuthRate').GetValues);
AER_ERate = cell2mat(DataElements.GetDataSetByName('ElevationRate').GetValues);
AER_RRate = cell2mat(DataElements.GetDataSetByName('RangeRate').GetValues);
NLength=length(AER_A);
AER=zeros(NLength,6);
for i=1:NLength
    AER(i,1)=AER_A(i);
    AER(i,2)=AER_E(i);
    AER(i,3)=AER_R(i);
    AER(i,4)=AER_ARate(i);
    AER(i,5)=AER_ERate(i);
    AER(i,6)=AER_RRate(i);   
end
end