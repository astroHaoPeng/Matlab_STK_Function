function y = CreatSatHPOPFun( scenario,SatName,SatSixElements)
%% SatSixElements的单位为：距离km  角度 °
% 分别为a,  e,   Inc   ,RAAN ,w,  M
%最后两个为近地点幅角 和 平近点角
satellite = scenario.Children.New('eSatellite',SatName);
PropagatorType='ePropagatorHPOP';
satellite.SetPropagatorType(PropagatorType);
propagator=satellite.Propagator;
initialState=propagator.InitialState;
representation=initialState.Representation;
% 轨道六要素定义卫星初始轨道
keplerian = representation.ConvertTo('eOrbitStateClassical');
keplerian.SizeShapeType = 'eSizeShapeSemimajorAxis';  % Changes from Ecc/Inc to Perigee/Apogee Altitude
keplerian.LocationType = 'eLocationMeanAnomaly'; % Makes sure True Anomaly is being used  eLocationMeanAnomaly
keplerian.Orientation.AscNodeType = 'eAscNodeRAAN'; %Changes from eAscNodeLAN  eAscNodeRAAN  eAscNodeUnknown
keplerian.SizeShape.SemiMajorAxis = SatSixElements(1);
keplerian.SizeShape.Eccentricity =  SatSixElements(2);
keplerian.Orientation.Inclination =   SatSixElements(3);
keplerian.Orientation.AscNode.Value = SatSixElements(4);
keplerian.Orientation.ArgOfPerigee =  SatSixElements(5);
keplerian.Location.Value =            SatSixElements(6);
ForceModel=satellite.Propagator.ForceModel;
%% 重力场模型  默认设置30阶级
CentralBodyGravity=ForceModel.CentralBodyGravity;
CentralBodyGravity.SetMaximumDegreeAndOrder(2,2);
%% 太阳光压
SolarRadiationPressure=ForceModel.SolarRadiationPressure;
SolarRadiationPressure.Use=0;
%% 大气阻力
Drag=ForceModel.Drag;
DragModel=Drag.DragModel;
DragModel.Cd=0;
%% 三体摄动
ThirdBodyGravity=ForceModel.ThirdBodyGravity;
% 添加三体摄动
%ThirdBodyGravity.AddThirdBody('Moon');
% 删除三体摄动
ThirdBodyGravity.RemoveThirdBody('Moon')
ThirdBodyGravity.RemoveThirdBody('Sun')



%% 更多选项
MoreOptions=ForceModel.MoreOptions;
representation.Assign(keplerian);
satellite.Propagator.Propagate;
y=satellite;
end

