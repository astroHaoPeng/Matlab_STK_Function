function RV = GetSatRVDataFun(Sat,TimeOption)
%%  获取Sat->Cartesian Velocity->(J2000)的卫星六要素数据
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
DataCollection=SatData.Item('Cartesian Position').Group.Item('J2000');
DataElements=DataCollection.Exec(StartTime,StopTime,Step).DataSets;
Rx     =cell2mat(DataElements.GetDataSetByName('x').GetValues);
Ry     =cell2mat(DataElements.GetDataSetByName('y').GetValues);
Rz     =cell2mat(DataElements.GetDataSetByName('z').GetValues);

DataCollection=SatData.Item('Cartesian Velocity').Group.Item('J2000');
DataElements=DataCollection.Exec(StartTime,StopTime,Step).DataSets;
Vx     =cell2mat(DataElements.GetDataSetByName('x').GetValues);
Vy     =cell2mat(DataElements.GetDataSetByName('y').GetValues);
Vz     =cell2mat(DataElements.GetDataSetByName('z').GetValues);
NLength=length(Vx);
y=zeros(NLength,6);
for i=1:NLength
    y(i,1)=Rx(i);
    y(i,2)=Ry(i);
    y(i,3)=Rz(i);
    y(i,4)=Vx(i);
    y(i,5)=Vy(i);
    y(i,6)=Vz(i);
end
RV=y;
end

