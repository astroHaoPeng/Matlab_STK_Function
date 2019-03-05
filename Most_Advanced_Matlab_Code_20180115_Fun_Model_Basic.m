%% ������������
Model.ScenarioName='6_9_Con';
%% ����ʱ������
Model.TimeOption.StartTime= '9 Jan 2018 04:00:00.000';
Model.TimeOption.StopTime = '12 Jan 2018 04:00:00.000';
Model.TimeOption.Epoch    = '9 Jan 2018 04:00:00.000';

%% ������������
Model.Sat.SatName= 'Sat';
% ���ǹ������
Model.Sat.Orbit.SatPropagator='ePropagatorJ2Perturbation';   %% ePropagatorHPOP     ePropagatorJ2Perturbation    ePropagatorTwoBody
Model.Sat.Orbit.SatSeedOrbitParameter=[1100,1100,86.4,0,0,0];
% ����HPOP��������
Model.Sat.Orbit.UsingHPOPForceModel=1;
Model.Sat.Orbit.HPOPForceModel.DragModel.Cd=2.35;
Model.Sat.Orbit.HPOPForceModel.DragModel.AreaMassRatio=0.015;
Model.Sat.Orbit.HPOPForceModel.MoreOptions.Static.SatelliteMass=890;
% ������ʾ��������
Model.Sat.GAttributes.Inherit                 =0;
Model.Sat.GAttributes.LabelVisible            =1;
Model.Sat.GAttributes.IsGroundTrackVisible    =0;
Model.Sat.GAttributes.IsOrbitVisible          =0;
Model.Sat.GAttributes.IsGroundMarkerVisible   =1;
Model.Sat.GAttributes.IsOrbitMarkerVisible    =1;
Model.Sat.GAttributes.Color=16711680;%��ɫ

%% ������������
Model.Walker.ConstellationName='ConSat';
Model.Walker.NumberOfPlane         =6;
Model.Walker.NumberSatOfPerPlane   =9;
Model.Walker.F                     =1;
Model.Walker.RAAN                  =31;
Model.Walker.WalkerParameter=[Model.Walker.NumberOfPlane;
    Model.Walker.NumberSatOfPerPlane;
    360*Model.Walker.F/           Model.Walker.NumberOfPlane/Model.Walker.NumberSatOfPerPlane;
    Model.Walker.RAAN];

%% ����վ��������
Model.Fac.FacName='Fac';
Model.Fac.FacLat=40;
Model.Fac.FacLon=116;
Model.Fac.MinElevation=10;

%% ���Ƕ�������
Model.Cov.CovName='Cov';
Model.Cov.Bounds.MinLatitude   =0.0;
Model.Cov.Bounds.MaxLatitude   =90.0;
Model.Cov.LatLon=3.0;
% Cov��ʾ����
Model.Cov.GAttributes.Inherit  =0;
Model.Cov.CovIsPointsVisible=1;
Model.Cov.CovGraphics.IsRegionVisible=0;
Model.Cov.CovGraphics.IsPointsVisible=1;
Model.Cov.CovGraphics.Color=65535;
Model.Cov.CovGraphics.FillPoints=0;
Model.Cov.CovGraphics.MarkerStyle='Point';%%�����ĵ����ҹؼ���Graphics Marker
Model.Cov.CovGraphics.Animation.IsSatisfactionVisible=0;
Model.Cov.Advanced.AutoRecompute=0;
% ʱ��ϵͳ����
Model.Cov.Inteterval.UseScenarioInterval=1;
Model.Cov.Inteterval.Start=Model.TimeOption.StartTime;
Model.Cov.Inteterval.Stop=Model.TimeOption.StopTime;
if(Model.Cov.Inteterval.UseScenarioInterval==0)
    Model.Cov.Inteterval.Start='9 Jan 2018 04:00:00.000';
    Model.Cov.Inteterval.Stop='12 Jan 2018 04:00:00.000';
end


%% Fom����
Model.Fom.FomName='Fom';
% Fom��������
Model.Fom.FomDefinitionType  ='eFmNAssetCoverage';
Model.Fom.FomComputeType     = 'eMinimum';
Model.Fom.Satisfaction.Type='eFmAtLeast';
% Fom��ʾ����
Model.Fom.Satisfaction.EnableSatisfaction=1;
Model.Fom.Satisfaction.Threshold=1
Model.Fom.Graphics.Animation.IsVisible=0;
Model.Fom.Graphics.Static.IsVisible=1;
Model.Fom.Graphics.Static.FillPoints=1;
Model.Fom.Graphics.Color=16711680;%Blue



























