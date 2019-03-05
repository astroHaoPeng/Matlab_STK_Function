function LLA = GetSatLLRDataFun(Sat,TimeOption)
%%  ��ȡSat->LLA State->(Fixed)�������µ������  ˳�� ����- γ��-�߶�
if(nargin>1)
    StartTime= TimeOption.StartTime;
    StopTime=  TimeOption.StopTime;
    Step   =   TimeOption.Step;
else
    StartTime=Sat.Propagator.StartTime;
    StopTime=Sat.Propagator.StopTime;
    Step     =Sat.Propagator.Step;
end
SatData=Sat.DataProviders;
DataCollection=SatData.Item('LLA State').Group.Item('Fixed');
DataElements=DataCollection.Exec(StartTime,StopTime,Step).DataSets;
Lat     =cell2mat(DataElements.GetDataSetByName('Lat').GetValues);
Lon     =cell2mat(DataElements.GetDataSetByName('Lon').GetValues);
Alt     =cell2mat(DataElements.GetDataSetByName('Alt').GetValues);
NLength=length(Lat);
y=zeros(NLength,3);
for i=1:NLength
    y(i,1)=Lon(i);
    y(i,2)=Lat(i);
    y(i,3)=Alt(i);
end
LLA=y;
end

