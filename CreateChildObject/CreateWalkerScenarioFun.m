function  y= CreateWalkerScenarioFun(SatSeedOrbitParameter,WalkerParameter,MinElevation,PropagatorType)
% Using STK to Create Constellation
%Part1 Create SatSeed Object
%Patt2 Create A Walker Constellation
%Part2 Setting MinElevation Constraint

SatPropagator=PropagatorType;
try
    % Grab an existing instance of STK
    uiapp = actxGetRunningServer('STK11.application');
    root = uiapp.Personality2;
    checkempty = root.Children.Count;
    if checkempty == 0
        %If a Scenario is not open, create a new scenario
        uiapp.visible = 1;
        root.NewScenario('6_9_Con');
        scenario = root.CurrentScenario;
    else
        root.CurrentScenario.Unload;
        uiapp.visible = 1;
        root.NewScenario('6_9_Con');
        scenario = root.CurrentScenario;
    end
catch
    % STK is not running, launch new instance
    % Launch a new instance of STK11 and grab it
    uiapp = actxserver('STK11.application');
    root = uiapp.Personality2;
    uiapp.visible = 1;
    root.NewScenario('6_9_Con');
    scenario = root.CurrentScenario;
end
%% 设置场景的时间
scenario.StartTime= '9 Jan 2018 04:00:00.000';
scenario.StopTime = '9 Jan 2018 08:00:00.000';
scenario.Epoch    = '9 Jan 2018 04:00:00.000';
root.Rewind;
%% Windows Setting
uiapp.WindowState='eWindowStateMaximized';
uiapp.Windows.Arrange('eArrangeStyleTiledVertical');
%% 创建种子卫星
SatName='0';
satellite=CreateSatObjectFun(scenario,SatName,SatSeedOrbitParameter,SatPropagator);
%% 创建种子卫星的二三维显示
satellite_Graphics=satellite.Graphics;
GAttributes=satellite_Graphics.Attributes;
GAttributes.Inherit=0;
GAttributes.IsGroundTrackVisible=0;
GAttributes.IsOrbitVisible=0;
GAttributes.IsGroundMarkerVisible=1;
GAttributes.IsOrbitMarkerVisible=1;
GAttributes.Color=16711680;%蓝色
%% 创建Walker星座
ConstellationName='ConSat';
CreateWalkerObjectFun(root,SatName,WalkerParameter,ConstellationName);
satellite.Unload;
%% 创建地面站
FacName='Fac';
CreateFacObjectFun(scenario,FacName,MinElevation);


try
    %% 创建覆盖定义
    coverage = root.CurrentScenario.Children.New('eCoverageDefinition', 'Cov');
    %% 覆盖定义的Grid设置
    CovGrid=coverage.Grid;
    CovGrid.BoundsType='eBoundsLat';
    CovGrid.Bounds.MinLatitude=0.0;
    CovGrid.Bounds.MaxLatitude=90.0;
    CovGrid.ResolutionType='eResolutionLatLon';
    CovGrid.Resolution.LatLon=3.0;
    %% 非常重要的约束条件设置
    root.ExecuteCommand('Cov */CoverageDefinition/Cov Grid GridConstraint Facility UsePointAltitudeType Facility/Fac');
    %% 添加覆盖定义的资源
    CovAssetList=coverage.AssetList;
    %% 覆盖定义的二维设置
    CovGraphics=coverage.Graphics;
    CovGraphicsStatic=CovGraphics.Static;
    CovGraphicsStatic.IsRegionVisible=0;
    CovGraphicsStatic.IsPointsVisible=1;
    CovGraphicsStatic.Color=65535;
    CovGraphicsStatic.FillPoints=0;
    CovGraphicsStatic.MarkerStyle='Point';%帮助文档查找关键词Graphics Marker
    CovGraphics.Animation.IsSatisfactionVisible=0;
    %% 覆盖定义的其他高级设置
    CovAdvanced=coverage.Advanced;
    CovAdvanced.AutoRecompute=0;          %不可以自动计算
catch
end

try
    %% 创建FOM
    fom=coverage.Children.New('eFigureOfMerit', 'Fom');
    fom.SetDefinitionType('eFmNAssetCoverage');
    fom.Definition.SetComputeType('eMinimum');
    fomSatisfaction=fom.Definition.Satisfaction;
    fomSatisfaction.EnableSatisfaction=1;
    fomSatisfaction.SatisfactionType='eFmAtLeast';
    fomSatisfaction.SatisfactionThreshold=int16(1);
    fomGraphics=fom.Graphics;
    fomGraphics.Animation.IsVisible=0;
    fomGraphics.Static.IsVisible=1;
    fomGraphics.Static.FillPoints=1;
    fomGraphics.Static.Color=16711680;%Blue
catch
end
if(1)
    %% 向覆盖定义中添加资源
    CovAssetList.Add('Constellation/ConSat');
    %% 设置并行计算
    %root.ExecuteCommand('Parallel / AutomaticallyComputeInParallel On');
    root.ExecuteCommand('Parallel / Configuration ParallelType Local NumberOfLocalCores 4');
    %root.ExecuteCommand('Parallel / AutomaticallyComputeInParallel Off');
    %% 覆盖定义进行计算
    coverage.ComputeAccesses;
    %% 获取全球覆盖的性能
    y=GetFomSatisfactionDataFun(fom);
end
end

