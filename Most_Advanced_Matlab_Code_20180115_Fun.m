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
%% ���ó�����ʱ��
scenario.StartTime   =Model.TimeOption.StartTime;
scenario.StopTime    =Model.TimeOption.StopTime;
scenario.Epoch       =Model.TimeOption.Epoch;
root.Rewind;
%% Windows Setting
uiapp.WindowState='eWindowStateMaximized';
uiapp.Windows.Arrange('eArrangeStyleTiledVertical');

%% ���ǲ���
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
%% ��������
ConstellationName   =Model.Walker.ConstellationName;
WalkerParameter     =Model.Walker.WalkerParameter;
%% �߼�����   �ֶ�����HPOP����
if(strcmp(SatPropagator,'ePropagatorHPOP'))
    NumberOfPlane    =WalkerParameter(1);
    NumberOfPerPlane =WalkerParameter(2);
    
    for i=1:NumberOfPlane
        for j=1:1:NumberOfPerPlane
            %% ���ǹ����������
            SatName_IJ=[SatName,num2str(i),num2str(j)];
            SatOrbitParameter_IJ(4)      =WalkerParameter(4)*(i-1);   %������ྭ
            TempParameter                =WalkerParameter(3)*(i-1)+...
                360/NumberOfPerPlane*(j-1);% ������
            while(TempParameter>=360)
                TempParameter=TempParameter-360;
            end
            SatOrbitParameter_IJ(6)=TempParameter;
            satellite=CreateSatObjectFun(scenario,SatName_IJ,SatOrbitParameter_IJ,SatPropagator);
            %% ������ʾ��������
            satellite_Graphics=satellite.Graphics;
            GAttributes=satellite_Graphics.Attributes;
            GAttributes.Inherit=SatInherit;
            if(SatInherit==0)
                GAttributes.LabelVisible             =SatLabelVisible;
                GAttributes.IsGroundTrackVisible     =SatIsGroundTrackVisible;
                GAttributes.IsOrbitVisible           =SatIsOrbitVisible;
                GAttributes.IsGroundMarkerVisible    =SatIsGroundMarkerVisible;
                GAttributes.IsOrbitMarkerVisible     =SatIsOrbitMarkerVisible;
                GAttributes.Color=SatColor;%��ɫ
            end
            %% ����HPOP����
            if(strcmp(satellite.PropagatorType,'ePropagatorHPOP'))
                ForceModel=satellite.Propagator.ForceModel;
                %% ������ģ��
                CentralBodyGravity=ForceModel.CentralBodyGravity;
                CentralBodyGravity.SetMaximumDegreeAndOrder(0,0);
                %% ��������
                Drag=ForceModel.Drag;
                DragModel=Drag.DragModel;
                DragModel.Cd              =HPOPForceModel.DragModel.Cd;
                DragModel.AreaMassRatio   =HPOPForceModel.DragModel.AreaMassRatio;
                %% ����ѡ��
                MoreOptions=ForceModel.MoreOptions;
                MoreOptions.Static.SatelliteMass  =HPOPForceModel.MoreOptions.Static.SatelliteMass;
                %% ������ѡȡ
                if(0)
                    Propagator=satellite.Propagator;
                    Integrator=Propagator.Integrator;
                    StepSizeControl=Integrator.StepSizeControl;
                    StepSizeControl.Method='eFixedStep';%eRelativeError
                    TimeRegularization=Integrator.TimeRegularization;
                end
                %% Ԥ��
                satellite.Propagator.Propagate;
            end
        end
    end
    %% �����Ƕ���������
    constellation = root.CurrentScenario.Children.New('eConstellation',ConstellationName);
    ConObjects=constellation.Objects;
    TempSatChildren=scenario.Children.GetElements('eSatellite');
    NumOfSat=TempSatChildren.Count;
    for i=1:NumOfSat
        TempSatChild=TempSatChildren.Item(int16(i-1));
        ConObjects.AddObject(TempSatChild);
    end
else
    %% ������������
    satellite=CreateSatObjectFun(scenario,SatName,SatSeedOrbitParameter,SatPropagator);
    %% ������ʾ��������
    satellite_Graphics=satellite.Graphics;
    GAttributes=satellite_Graphics.Attributes;
    GAttributes.Inherit=SatInherit;
    if(SatInherit==0)
        GAttributes.LabelVisible             =SatLabelVisible;
        GAttributes.IsGroundTrackVisible     =SatIsGroundTrackVisible;
        GAttributes.IsOrbitVisible           =SatIsOrbitVisible;
        GAttributes.IsGroundMarkerVisible    =SatIsGroundMarkerVisible;
        GAttributes.IsOrbitMarkerVisible     =SatIsOrbitMarkerVisible;
        GAttributes.Color=SatColor;%��ɫ
    end
    %% ����Walker����
    y=CreateWalkerObjectFun(root,SatName,WalkerParameter,ConstellationName);
    if(y==0)
        error('Create Walker Failed');
    end
    satellite.Unload;
end


%% ��������վ
%% ����վ����
FacName=Model.Fac.FacName;
MinElevation=Model.Fac.MinElevation;
CreateFacObjectFun(scenario,FacName,MinElevation);
try
    %% ���Ƕ������
    CovName=Model.Cov.CovName;
    Bounds.MinLatitude   =Model.Cov.Bounds.MinLatitude;
    Bounds.MaxLatitude   =Model.Cov.Bounds.MaxLatitude;
    LatLon=Model.Cov.LatLon;
    %% �������Ƕ���
    coverage = root.CurrentScenario.Children.New('eCoverageDefinition', CovName);
    %% ���Ƕ����Grid����
    CovGrid=coverage.Grid;
    CovGrid.BoundsType='eBoundsLat';
    CovGrid.Bounds.MinLatitude=Bounds.MinLatitude;
    CovGrid.Bounds.MaxLatitude=Bounds.MaxLatitude;
    CovGrid.ResolutionType='eResolutionLatLon';
    CovGrid.Resolution.LatLon=LatLon;
    %% �ǳ���Ҫ��Լ����������
    strcmd=['Cov */CoverageDefinition/Cov Grid GridConstraint Facility UsePointAltitudeType Facility/',FacName];
    root.ExecuteCommand(strcmd);
    %% ��Ӹ��Ƕ������Դ
    CovAssetList=coverage.AssetList;
    %% ���Ƕ���Ķ�ά����
    CovGraphics=coverage.Graphics;
    CovGraphicsStatic=CovGraphics.Static;
    CovGraphicsStatic.IsRegionVisible     =Model.Cov.CovGraphics.IsRegionVisible;
    CovGraphicsStatic.IsPointsVisible     =Model.Cov.CovGraphics.IsPointsVisible;
    CovGraphicsStatic.Color               =Model.Cov.CovGraphics.Color;
    CovGraphicsStatic.FillPoints          =Model.Cov.CovGraphics.FillPoints;
    CovGraphicsStatic.MarkerStyle         =Model.Cov.CovGraphics.MarkerStyle;
    CovGraphics.Animation.IsSatisfactionVisible  =Model.Cov.CovGraphics.Animation.IsSatisfactionVisible;
    CovGraphicsStatic.IsPointsVisible            =Model.Cov.CovIsPointsVisible;
    %% ���Ƕ���������߼�����
    CovAdvanced=coverage.Advanced;
    CovAdvanced.AutoRecompute            =Model.Cov.Advanced.AutoRecompute;          %�������Զ�����
    %% ���Ƕ����ʱ������
    CovInteterval=coverage.Interval;
    if(Model.Cov.Inteterval.UseScenarioInterval==0)
        CovInteterval.UseScenarioInterval=0;
        CovInteterval.Start   =Model.Cov.Inteterval.Start;
        CovInteterval.Stop    = Model.Cov.Inteterval.Stop;
    end
catch
end

try
    %% ����FOM
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
    
    % FomContours��������
    IsGraphicsContours=0;
    FomLevels=0:3;
    FomColor=zeros(length(FomLevels),1);
    % ��ɫ����
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
    %% �򸲸Ƕ����������Դ
    cmd=['Constellation/',ConstellationName];
    CovAssetList.Add(cmd);
    %% ���ò��м���
    %root.ExecuteCommand('Parallel / AutomaticallyComputeInParallel On');
    cmd=['Parallel / Configuration ParallelType Local NumberOfLocalCores 8'];
    root.ExecuteCommand('Parallel / Configuration ParallelType Local NumberOfLocalCores 8');
    %root.ExecuteCommand('Parallel / AutomaticallyComputeInParallel Off');
    %% ���Ƕ�����м���
    coverage.ComputeAccesses;
    %% ��ȡȫ�򸲸ǵ�����
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

