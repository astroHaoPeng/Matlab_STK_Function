function y = GetSatSixElementsData_Kozai_IzsakFun(Sat,TimeOption)
%%  获取Sat->Classical Elements->(ICRF)的卫星六要素数据

%% 获取数据结构
SatData=Sat.DataProviders;
DataCollection=SatData.Item('Kozai-Izsak Mean').Group.Item('ICRF');
%% 设置时间状态
if(nargin>1)
    StartTime= TimeOption.StartTime;
    StopTime=  TimeOption.StopTime;
    Step   =   TimeOption.Step;
else
    StartTime=Sat.Propagator.StartTime;
    StopTime=Sat.Propagator.StopTime;
    Step     =Sat.Propagator.Step;
end
%% 读取数据
DataElements=DataCollection.Exec(StartTime,StopTime,Step).DataSets;
Sat_Semimajor     =cell2mat(DataElements.GetDataSetByName('Mean Semi-major Axis').GetValues);
Sat_Eccent        =cell2mat(DataElements.GetDataSetByName('Mean Eccentricity').GetValues);
Sat_Inc           =cell2mat(DataElements.GetDataSetByName('Mean Inclination').GetValues);
Sat_RAAN          =cell2mat(DataElements.GetDataSetByName('Mean RAAN').GetValues);
Sat_Arg_Perige    =cell2mat(DataElements.GetDataSetByName('Mean Arg of Perigee').GetValues);
Sat_Mean_Anomaly  =cell2mat(DataElements.GetDataSetByName('Mean Mean Anomaly').GetValues);
Sat_Arg_Latitude  =cell2mat(DataElements.GetDataSetByName('Mean Arg of Latitude').GetValues);
%% 处理数据
NLength=length(Sat_Mean_Anomaly);
y=zeros(NLength,6);
for i=1:NLength
    y(i,1)=Sat_Semimajor(i);
    y(i,2)=Sat_Eccent(i);
    y(i,3)=Sat_Inc(i);
    y(i,4)=Sat_RAAN(i);
    y(i,5)=Sat_Arg_Perige(i);
    y(i,6)=Sat_Mean_Anomaly(i);
end

%% Set 'Arg of Latitude' As One Of SixElement
if(1)
    for i=1:NLength
        y(i,6)=Sat_Arg_Latitude(i);
    end
end

end

%% key word:Data Providers Reference
%% Another Key Word
%% Mean Anomaly
%% Arg of Latitude
%%The sum of the true anomaly and the argument of periapsis
%% Apogee Radius
%% Mean Motion (Revs/Day)
%% Lon Ascn Node :
% % A measure of the right ascension of the ascending node, made in the Fixed frame.
% % he value is the detic longitude of the orbit's ascending node.
% % The ascending node crossing is assumed to be at, or prior to,
% % the current position in the orbit in the same nodal revolution.
%% Longitude of Perigee
% % The sum of the right ascension of the ascending node and the argument of periapsis