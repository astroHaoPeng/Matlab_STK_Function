function R = GetFacilityRDataFun(Facility,TimeOption)
%%  ªÒ»°Facility->Points(ICRF)->CenterŒª÷√

StartTime= TimeOption.StartTime;
StopTime=  TimeOption.StopTime;
Step   =   TimeOption.Step;

FacilityData=Facility.DataProviders;
DataCollection=FacilityData.Item('Points(J2000)').Group.Item('Center');
DataElements=DataCollection.Exec(StartTime,StopTime,Step).DataSets;
Rx     =cell2mat(DataElements.GetDataSetByName('x').GetValues);
Ry     =cell2mat(DataElements.GetDataSetByName('y').GetValues);
Rz     =cell2mat(DataElements.GetDataSetByName('z').GetValues);
NLength=length(Rx);
y=zeros(NLength,3);
for i=1:NLength
    y(i,1)=Rx(i);
    y(i,2)=Ry(i);
    y(i,3)=Rz(i);
end
R=y;
end

