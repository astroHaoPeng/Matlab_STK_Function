%%���� �����Ѿ����ڵĳ���
clear
ScPath='C:\Users\ShouJin\Documents\STK 11 (x64)\FindRAAN\OnlyJ2\FindReasonChangeRAAN.sc';
[uiapp,root,scenario] = LoadExist_ScenarionFun(ScPath);
tic
ScenarioName=scenario.InstanceName;
TimeOption.StartTime     =scenario.StartTime;
TimeOption.StopTime      =scenario.StopTime;
TimeOption.Step              =60.0*60;                            %��λ��
TempSatChildren=scenario.Children.GetElements('eSatellite');
NumOfSat=TempSatChildren.Count;
for i=1:NumOfSat
    TempSat=TempSatChildren.Item(int16(i-1));
    SatName=TempSat.InstanceName;
    SixEl=GetSatSixElementsDataFun(TempSat,TimeOption);
    Cmd=['m_',SatName,'=','SixEl;'];
    eval(Cmd);
    OutFinishi=['��ɣ�',SatName,'�������ݵĻ�ȡ��'];
    disp(OutFinishi);
end
SaveData=['DataTemp\',ScenarioName];
save(SaveData)
toc
