function y = CreatSatHPOPFun( scenario,SatName,SatSixElements)
%% SatSixElements�ĵ�λΪ������km  �Ƕ� ��
% �ֱ�Ϊa,  e,   Inc   ,RAAN ,w,  M
%�������Ϊ���ص���� �� ƽ�����
satellite = scenario.Children.New('eSatellite',SatName);
PropagatorType='ePropagatorHPOP';
satellite.SetPropagatorType(PropagatorType);
propagator=satellite.Propagator;
initialState=propagator.InitialState;
representation=initialState.Representation;
% �����Ҫ�ض������ǳ�ʼ���
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
%% ������ģ��  Ĭ������30�׼�
CentralBodyGravity=ForceModel.CentralBodyGravity;
CentralBodyGravity.SetMaximumDegreeAndOrder(2,2);
%% ̫����ѹ
SolarRadiationPressure=ForceModel.SolarRadiationPressure;
SolarRadiationPressure.Use=0;
%% ��������
Drag=ForceModel.Drag;
DragModel=Drag.DragModel;
DragModel.Cd=0;
%% �����㶯
ThirdBodyGravity=ForceModel.ThirdBodyGravity;
% ��������㶯
%ThirdBodyGravity.AddThirdBody('Moon');
% ɾ�������㶯
ThirdBodyGravity.RemoveThirdBody('Moon')
ThirdBodyGravity.RemoveThirdBody('Sun')



%% ����ѡ��
MoreOptions=ForceModel.MoreOptions;
representation.Assign(keplerian);
satellite.Propagator.Propagate;
y=satellite;
end

