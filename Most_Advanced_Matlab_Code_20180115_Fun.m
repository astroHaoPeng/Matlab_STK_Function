function y = Most_Advanced_Matlab_Code_20180115_Fun( Model)
tic
try
    % Grab an existing instance of STK
    uiapp = actxGetRunningServer('STK11.application');
    root = uiapp.Personality2;
    checkempty = root.Children.Count;
    ScenarioName=Model.ScenarioName;
    if checkempty == 0
        %If a Scenario is not open, create a new scenario
        uiapp.visible = 1;
        root.NewScenario(ScenarioName);
        scenario = root.CurrentScenario;
    else
        root.CurrentScenario.Unload;
        uiapp.visible = 1;
        root.NewScenario(ScenarioName);
        scenario = root.CurrentScenario;
    end
catch
    % STK is not running, launch new instance
    % Launch a new instance of STK11 and grab it
    uiapp = actxserver('STK11.application');
    root = uiapp.Personality2;
    uiapp.visible = 1;
    ScenarioName=Model.ScenarioName;
    root.NewScenario(ScenarioName);
    scenario = root.CurrentScenario;
end
%% 设置场景的时间
scenario.StartTime   =Model.TimeOption.StartTime;
scenario.StopTime    =Model.TimeOption.StopTime;
scenario.Epoch       =Model.TimeOption.Epoch;
root.Rewind;
%% Windows Setting
uiapp.WindowState='eWindowStateMaximized';
uiapp.Windows.Arrange('eArrangeStyleTiledVertical');

%% 卫星参数
SatName=Model.Sat.SatName;
SatPropagator=Model.Sat.Orbit.SatPropagator;
SatSeedOrbitParameter=Model.Sat.Orbit.SatSeedOrbitParameter;
SatOrbitParameter_IJ=SatSeedOrbitParameter;
if(Model.Sat.Orbit.UsingHPOPForceModel==1)
    HPOPForceModel.DragModel.Cd                       =  Model.Sat.Orbit.HPOPForceModel.DragModel.Cd;
    HPOPForceModel.DragModel.AreaMassRatio            =  Model.Sat.Orbit.HPOPForceModel.DragModel.AreaMassRatio;
    HPOPForceModel.MoreOptions.Static.SatelliteMass   =  Model.Sat.Orbit.HPOPForceModel.MoreOptions.Static.SatelliteMass;
end
SatInherit                      =Model.Sat.GAttributes.Inherit;
SatIsGroundTrackVisible         =Model.Sat.GAttributes.IsGroundTrackVisible;
SatIsOrbitVisible               =Model.Sat.GAttributes.IsOrbitVisible;
SatLabelVisible                 =Model.Sat.GAttributes.LabelVisible;
SatIsGroundMarkerVisible        =Model.Sat.GAttributes.IsGroundMarkerVisible;
SatIsOrbitMarkerVisible         =Model.Sat.GAttributes.IsOrbitMarkerVisible;
SatColor                        =Model.Sat.GAttributes.Color;
%% 星座参数
ConstellationName   =Model.Walker.ConstellationName;
WalkerParameter     =Model.Walker.WalkerParameter;
%% 高级功能   手动创建HPOP星座
if(strcmp(SatPropagator,'ePropagatorHPOP'))
    NumberOfPlane    =WalkerParameter(1);
    NumberOfPerPlane =WalkerParameter(2);
    
    for i=1:NumberOfPlane
        for j=1:1:NumberOfPerPlane
            %% 卫星轨道参数设置
            SatName_IJ=[SatName,num2str(i),num2str(j)];
            SatOrbitParameter_IJ(4)      =WalkerParameter(4)*(i-1);   %升交点赤经
            TempParameter                =WalkerParameter(3)*(i-1)+...
                360/NumberOfPerPlane*(j-1);% 真近点角
            while(TempParameter>=360)
                TempParameter=TempParameter-360;
            end
            SatOrbitParameter_IJ(6)=TempParameter;
            satellite=CreateSatObjectFun(scenario,SatName_IJ,SatOrbitParameter_IJ,SatPropagator);
            %% 卫星显示参数设置
            satellite_Graphics=satellite.Graphics;
            GAttributes=satellite_Graphics.Attributes;
            GAttributes.Inherit=SatInherit;
            if(SatInherit==0)
                GAttributes.LabelVisible             =SatLabelVisible;
                GAttributes.IsGroundTrackVisible     =SatIsGroundTrackVisible;
                GAttributes.IsOrbitVisible           =SatIsOrbitVisible;
                GAttributes.IsGroundMarkerVisible    =SatIsGroundMarkerVisible;
                GAttributes.IsOrbitMarkerVisible     =SatIsOrbitMarkerVisible;
                GAttributes.Color=SatColor;%蓝色
            end
            %% 卫星HPOP设置
            if(strcmp(satellite.PropagatorType,'ePropagatorHPOP'))
                ForceModel=satellite.Propagator.ForceModel;
                %% 重力场模型
                CentralBodyGravity=ForceModel.CentralBodyGravity;
                CentralBodyGravity.SetMaximumDegreeAndOrder(0,0);
                %% 大气阻力
                Drag=ForceModel.Drag;
                DragModel=Drag.DragModel;
                DragModel.Cd              =HPOPForceModel.DragModel.Cd;
                DragModel.AreaMassRatio   =HPOPForceModel.DragModel.AreaMassRatio;
                %% 更多选项
                MoreOptions=ForceModel.MoreOptions;
                MoreOptions.Static.SatelliteMass  =HPOPForceModel.MoreOptions.Static.SatelliteMass;
                %% 积分器选取
                if(0)
                    Propagator=satellite.Propagator;
                    Integrator=Propagator.Integrator;
                    StepSizeControl=Integrator.StepSizeControl;
                    StepSizeControl.Method='eFixedStep';%eRelativeError
                    TimeRegularization=Integrator.TimeRegularization;
                end
                %% 预报
                satellite.Propagator.Propagate;
            end
        end
    end
    %% 将卫星堆入星座中
    constellation = root.CurrentScenario.Children.New('eConstellation',ConstellationName);
    ConObjects=constellation.Objects;
    TempSatChildren=scenario.Children.GetElements('eSatellite');
    NumOfSat=TempSatChildren.Count;
    for i=1:NumOfSat
        TempSatChild=TempSatChildren.Item(int16(i-1));
        ConObjects.AddObject(TempSatChild);
    end
else
    %% 创建种子卫星
    satellite=CreateSatObjectFun(scenario,SatName,SatSeedOrbitParameter,SatPropagator);
    %% 卫星显示参数设置
    satellite_Graphics=satellite.Graphics;
    GAttributes=satellite_Graphics.Attributes;
    GAttributes.Inherit=SatInherit;
    if(SatInherit==0)
        GAttributes.LabelVisible             =SatLabelVisible;
        GAttributes.IsGroundTrackVisible     =SatIsGroundTrackVisible;
        GAttributes.IsOrbitVisible           =SatIsOrbitVisible;
        GAttributes.IsGroundMarkerVisible    =SatIsGroundMarkerVisible;
        GAttributes.IsOrbitMarkerVisible     =SatIsOrbitMarkerVisible;
        GAttributes.Color=SatColor;%蓝色
    end
    %% 创建Walker星座
    y=CreateWalkerObjectFun(root,SatName,WalkerParameter,ConstellationName);
    if(y==0)
        error('Create Walker Failed');
    end
    satellite.Unload;
end


%% 创建地面站
%% 地面站参数
FacName=Model.Fac.FacName;
MinElevation=Model.Fac.MinElevation;
CreateFacObjectFun(scenario,FacName,MinElevation);
try
    %% 覆盖定义参数
    CovName=Model.Cov.CovName;
    Bounds.MinLatitude   =Model.Cov.Bounds.MinLatitude;
    Bounds.MaxLatitude   =Model.Cov.Bounds.MaxLatitude;
    LatLon=Model.Cov.LatLon;
    %% 创建覆盖定义
    coverage = root.CurrentScenario.Children.New('eCoverageDefinition', CovName);
    %% 覆盖定义的Grid设置
    CovGrid=coverage.Grid;
    CovGrid.BoundsType='eBoundsLat';
    CovGrid.Bounds.MinLatitude=Bounds.MinLatitude;
    CovGrid.Bounds.MaxLatitude=Bounds.MaxLatitude;
    CovGrid.ResolutionType='eResolutionLatLon';
    CovGrid.Resolution.LatLon=LatLon;
    %% 非常重要的约束条件设置
    strcmd=['Cov */CoverageDefinition/Cov Grid GridConstraint Facility UsePointAltitudeType Facility/',FacName];
    root.ExecuteCommand(strcmd);
    %% 添加覆盖定义的资源
    CovAssetList=coverage.AssetList;
    %% 覆盖定义的二维设置
    CovGraphics=coverage.Graphics;
    CovGraphicsStatic=CovGraphics.Static;
    CovGraphicsStatic.IsRegionVisible     =Model.Cov.CovGraphics.IsRegionVisible;
    CovGraphicsStatic.IsPointsVisible     =Model.Cov.CovGraphics.IsPointsVisible;
    CovGraphicsStatic.Color               =Model.Cov.CovGraphics.Color;
    CovGraphicsStatic.FillPoints          =Model.Cov.CovGraphics.FillPoints;
    CovGraphicsStatic.MarkerStyle         =Model.Cov.CovGraphics.MarkerStyle;
    CovGraphics.Animation.IsSatisfactionVisible  =Model.Cov.CovGraphics.Animation.IsSatisfactionVisible;
    CovGraphicsStatic.IsPointsVisible            =Model.Cov.CovIsPointsVisible;
    %% 覆盖定义的其他高级设置
    CovAdvanced=coverage.Advanced;
    CovAdvanced.AutoRecompute            =Model.Cov.Advanced.AutoRecompute;          %不可以自动计算
    %% 覆盖定义的时间设置
    CovInteterval=coverage.Interval;
    if(Model.Cov.Inteterval.UseScenarioInterval==0)
        CovInteterval.UseScenarioInterval=0;
        CovInteterval.Start   =Model.Cov.Inteterval.Start;
        CovInteterval.Stop    = Model.Cov.Inteterval.Stop;
    end
catch
end

try
    %% 创建FOM
    FomName                                        =Model.Fom.FomName;
    FomDefinitionType                              =Model.Fom.FomDefinitionType;
    FomComputeType                                 = Model.Fom.FomComputeType;
    fom=coverage.Children.New('eFigureOfMerit', FomName);
    fom.SetDefinitionType(FomDefinitionType);
    fom.Definition.SetComputeType(FomComputeType);
    fomSatisfaction=fom.Definition.Satisfaction;
    fomSatisfaction.EnableSatisfaction           =Model.Fom.Satisfaction.EnableSatisfaction;
    fomSatisfaction.SatisfactionType             =Model.Fom.Satisfaction.Type;
    fomSatisfaction.SatisfactionThreshold=  int16(Model.Fom.Satisfaction.Threshold(1)   );
    fomGraphics=fom.Graphics;
    fomGraphics.Animation.IsVisible             =Model.Fom.Graphics.Animation.IsVisible;
    fomGraphics.Static.IsVisible                =Model.Fom.Graphics.Static.IsVisible;
    fomGraphics.Static.FillPoints               =Model.Fom.Graphics.Static.FillPoints;
    fomGraphics.Static.Color                    =Model.Fom.Graphics.Color;%Blue
    
    % FomContours参数设置
    IsGraphicsContours=0;
    FomLevels=0:3;
    FomColor=zeros(length(FomLevels),1);
    % 颜色设置
    FomColor(1)=hex2dec('FF');
    FomColor(2)=hex2dec('FF0000');
    FomColor(3)=hex2dec('00FF00');
    FomColor(4)=hex2dec('FFFF');
    if(IsGraphicsContours==1)
        fomGraphicsContours=fomGraphics.Static.Contours;
        fomGraphicsContours.IsVisible = true;
        fomGraphicsContours.ColorMethod='eExplicit';
        fomLevelAttributes   =fomGraphicsContours.LevelAttributes;
        for i=1:length(FomLevels)
            AddLevel         = fomLevelAttributes.AddLevel( FomLevels(i) );
            AddLevel.Color   =FomColor(i);
        end
    end
catch
end
if(1)
    %% 向覆盖定义中添加资源
    cmd=['Constellation/',ConstellationName];
    CovAssetList.Add(cmd);
    %% 设置并行计算
    %root.ExecuteCommand('Parallel / AutomaticallyComputeInParallel On');
    cmd=['Parallel / Configuration ParallelType Local NumberOfLocalCores 8'];
    root.ExecuteCommand('Parallel / Configuration ParallelType Local NumberOfLocalCores 8');
    %root.ExecuteCommand('Parallel / AutomaticallyComputeInParallel Off');
    %% 覆盖定义进行计算
    coverage.ComputeAccesses;
    %% 获取全球覆盖的性能
    for i=1:length(Model.Fom.Satisfaction.Threshold)
        fomSatisfaction.SatisfactionThreshold=  int16(Model.Fom.Satisfaction.Threshold(i)   );
        y(i)=GetFomSatisfactionDataFun(fom);
    end
end
toc
end


% % TimeOption.StartTime= '9 Jan 2018 04:00:00.000';
% % TimeOption.StopTime = '12 Jan 2018 04:00:00.000';
% % TimeOption.Epoch    = '9 Jan 2018 04:00:00.000';
% % SatSeedOrbitParameter=[1100,1100,86.4,0,0,0];
% % WalkerParameter=[6,9,6.666,31];
% % SatPropagator='ePropagatorHPOP';   %% ePropagatorHPOP  
% % %ePropagatorJ2Perturbation    ePropagatorTwoBody
% % Most_Advanced_Matlab_Code_20180115_Fun(SatPropagator,SatSeedOrbitParameter,WalkerParameter,TimeOption)

