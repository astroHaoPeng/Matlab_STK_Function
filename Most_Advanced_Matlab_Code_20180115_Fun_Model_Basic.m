%% 场景名字设置
Model.ScenarioName='6_9_Con';
%% 场景时间设置
Model.TimeOption.StartTime= '9 Jan 2018 04:00:00.000';
Model.TimeOption.StopTime = '12 Jan 2018 04:00:00.000';
Model.TimeOption.Epoch    = '9 Jan 2018 04:00:00.000';

%% 卫星名字设置
Model.Sat.SatName= 'Sat';
% 卫星轨道设置
Model.Sat.Orbit.SatPropagator='ePropagatorJ2Perturbation';   %% ePropagatorHPOP     ePropagatorJ2Perturbation    ePropagatorTwoBody
Model.Sat.Orbit.SatSeedOrbitParameter=[1100,1100,86.4,0,0,0];
% 卫星HPOP参数设置
Model.Sat.Orbit.UsingHPOPForceModel=1;
Model.Sat.Orbit.HPOPForceModel.DragModel.Cd=2.35;
Model.Sat.Orbit.HPOPForceModel.DragModel.AreaMassRatio=0.015;
Model.Sat.Orbit.HPOPForceModel.MoreOptions.Static.SatelliteMass=890;
% 卫星显示属性设置
Model.Sat.GAttributes.Inherit                 =0;
Model.Sat.GAttributes.LabelVisible            =1;
Model.Sat.GAttributes.IsGroundTrackVisible    =0;
Model.Sat.GAttributes.IsOrbitVisible          =0;
Model.Sat.GAttributes.IsGroundMarkerVisible   =1;
Model.Sat.GAttributes.IsOrbitMarkerVisible    =1;
Model.Sat.GAttributes.Color=16711680;%蓝色

%% 卫星星座设置
Model.Walker.ConstellationName='ConSat';
Model.Walker.NumberOfPlane         =6;
Model.Walker.NumberSatOfPerPlane   =9;
Model.Walker.F                     =1;
Model.Walker.RAAN                  =31;
Model.Walker.WalkerParameter=[Model.Walker.NumberOfPlane;
    Model.Walker.NumberSatOfPerPlane;
    360*Model.Walker.F/           Model.Walker.NumberOfPlane/Model.Walker.NumberSatOfPerPlane;
    Model.Walker.RAAN];

%% 地面站参数设置
Model.Fac.FacName='Fac';
Model.Fac.FacLat=40;
Model.Fac.FacLon=116;
Model.Fac.MinElevation=10;

%% 覆盖定义设置
Model.Cov.CovName='Cov';
Model.Cov.Bounds.MinLatitude   =0.0;
Model.Cov.Bounds.MaxLatitude   =90.0;
Model.Cov.LatLon=3.0;
% Cov显示设置
Model.Cov.GAttributes.Inherit  =0;
Model.Cov.CovIsPointsVisible=1;
Model.Cov.CovGraphics.IsRegionVisible=0;
Model.Cov.CovGraphics.IsPointsVisible=1;
Model.Cov.CovGraphics.Color=65535;
Model.Cov.CovGraphics.FillPoints=0;
Model.Cov.CovGraphics.MarkerStyle='Point';%%帮助文档查找关键词Graphics Marker
Model.Cov.CovGraphics.Animation.IsSatisfactionVisible=0;
Model.Cov.Advanced.AutoRecompute=0;
% 时间系统设置
Model.Cov.Inteterval.UseScenarioInterval=1;
Model.Cov.Inteterval.Start=Model.TimeOption.StartTime;
Model.Cov.Inteterval.Stop=Model.TimeOption.StopTime;
if(Model.Cov.Inteterval.UseScenarioInterval==0)
    Model.Cov.Inteterval.Start='9 Jan 2018 04:00:00.000';
    Model.Cov.Inteterval.Stop='12 Jan 2018 04:00:00.000';
end


%% Fom设置
Model.Fom.FomName='Fom';
% Fom参数设置
Model.Fom.FomDefinitionType  ='eFmNAssetCoverage';
Model.Fom.FomComputeType     = 'eMinimum';
Model.Fom.Satisfaction.Type='eFmAtLeast';
% Fom显示设置
Model.Fom.Satisfaction.EnableSatisfaction=1;
Model.Fom.Satisfaction.Threshold=1
Model.Fom.Graphics.Animation.IsVisible=0;
Model.Fom.Graphics.Static.IsVisible=1;
Model.Fom.Graphics.Static.FillPoints=1;
Model.Fom.Graphics.Color=16711680;%Blue



























