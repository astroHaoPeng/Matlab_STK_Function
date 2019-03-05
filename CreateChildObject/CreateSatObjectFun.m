function y = CreateSatObjectFun(scenario,SatName,SatSixElements,PropagatorType)
%ʹ��STK�������ǵĹ������
%���Ϊ���Ǵ����ľ��
try
    satellite = scenario.Children.New('eSatellite',SatName);
    if(nargin<4)
        PropagatorType='ePropagatorTwoBody';
    end
    satellite.SetPropagatorType(PropagatorType);
    propagator=satellite.Propagator;
    initialState=propagator.InitialState;
    representation=initialState.Representation;
    % �����Ҫ�ض������ǳ�ʼ���
    keplerian = representation.ConvertTo('eOrbitStateClassical');
    keplerian.SizeShapeType = 'eSizeShapeAltitude';  % Changes from Ecc/Inc to Perigee/Apogee Altitude
    keplerian.LocationType = 'eLocationTrueAnomaly'; % Makes sure True Anomaly is being used  eLocationMeanAnomaly
    keplerian.Orientation.AscNodeType = 'eAscNodeRAAN'; %Changes from eAscNodeLAN  eAscNodeRAAN  eAscNodeUnknown
    keplerian.SizeShape.PerigeeAltitude = SatSixElements(1);
    keplerian.SizeShape.ApogeeAltitude =  SatSixElements(2);
    keplerian.Orientation.Inclination =   SatSixElements(3);
    keplerian.Orientation.AscNode.Value = SatSixElements(4);
    keplerian.Orientation.ArgOfPerigee =  SatSixElements(5);
    keplerian.Location.Value =            SatSixElements(6);
    % Apply the changes made to the satellite's state and propagate:
    if(strcmp(PropagatorType,'ePropagatorHPOP'))
        %% HPOP->Force Model Setting
        ForceModel=satellite.Propagator.ForceModel;
        %% ������ģ��
        CentralBodyGravity=ForceModel.CentralBodyGravity;
        %% ̫����ѹ
        SolarRadiationPressure=ForceModel.SolarRadiationPressure;
        %% ��������
        Drag=ForceModel.Drag;
        DragModel=Drag.DragModel;
        %% �����㶯
        ThirdBodyGravity=ForceModel.ThirdBodyGravity;
        %% ����ѡ��
        MoreOptions=ForceModel.MoreOptions;
    end
    representation.Assign(keplerian);
    satellite.Propagator.Propagate;
    y=satellite;
catch
    y=0;
end

end

%% Key Word
% AgEVePropagatorType Enumeration 
% ePropagatorHPOP
% ePropagatorJ2Perturbation
% ePropagatorJ4Perturbation
% ePropagatorTwoBody
% ePropagatorSGP4