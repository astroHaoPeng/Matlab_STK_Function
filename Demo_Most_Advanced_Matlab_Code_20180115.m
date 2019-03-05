clc;clear;
tic
StartTime= '9 Jan 2018 04:00:00.000';
StopTime = '12 Jan 2018 04:00:00.000';
Epoch    = '9 Jan 2018 04:00:00.000';
ScenarioName='6_9_Con';
%% ���ǲ���
SatName='Sat';
SatPropagator='ePropagatorJ2Perturbation';   %% ePropagatorHPOP     ePropagatorJ2Perturbation    ePropagatorTwoBody
SatSeedOrbitParameter=[1100,1100,86.4,0,0,0];
SatOrbitParameter_IJ=SatSeedOrbitParameter;
HPOPForceModel.DragModel.Cd=0;
HPOPForceModel.DragModel.AreaMassRatio=0;
HPOPForceModel.MoreOptions.Static.SatelliteMass=890;

SatIsGroundTrackVisible=0;
SatIsOrbitVisible=0;
SatLabelVisible=1;
SatIsGroundMarkerVisible=1;
SatIsOrbitMarkerVisible=1;
%% ��������
ConstellationName='ConSat';
WalkerParameter=[6,9,6.666,32];
%% ����վ����
FacName='Fac';
MinElevation=10;
FacLat=40;
FacLon=116;
%% ���Ƕ������
CovName='Cov';
Bounds.MinLatitude   =-90.0;
Bounds.MaxLatitude   =0.0;
LatLon=1.0;
CovIsPointsVisible=1;
%%
FomName='Fom';
FomDefinitionType  ='eFmNAssetCoverage';
FomComputeType     = 'eMinimum';
FomSatisfactionType='eFmAtLeast';
%% FomContours��������
IsGraphicsContours=0;
FomLevels=0:3;
FomColor=zeros(length(FomLevels),1);
% ��ɫ����
FomColor(1)=hex2dec('FF');
FomColor(2)=hex2dec('FF0000');
FomColor(3)=hex2dec('00FF00');
FomColor(4)=hex2dec('FFFF');
try
    % Grab an existing instance of STK
    uiapp = actxGetRunningServer('STK11.application');
    root = uiapp.Personality2;
    checkempty = root.Children.Count;
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
    root.NewScenario(ScenarioName);
    scenario = root.CurrentScenario;
end
%% ���ó�����ʱ��
scenario.StartTime= StartTime;
scenario.StopTime = StopTime;
scenario.Epoch    = Epoch;
root.Rewind;
%% Windows Setting
uiapp.WindowState='eWindowStateMaximized';
uiapp.Windows.Arrange('eArrangeStyleTiledVertical');

%% �߼�����   �ֶ�����HPOP����
if(strcmp(SatPropagator,'ePropagatorHPOP'))
    NumberOfPlane    =WalkerParameter(1);
    NumberOfPerPlane =WalkerParameter(2);
    for i=1:NumberOfPlane
        for j=1:1:NumberOfPerPlane
            SatName_IJ=[SatName,num2str(i),num2str(j)];
            SatOrbitParameter_IJ(4)      =WalkerParameter(4)*(i-1);   %������ྭ
            TempParameter                =WalkerParameter(3)*(i-1)+...
                360/NumberOfPerPlane*(j-1);% ������
            while(TempParameter>=360)
                TempParameter=TempParameter-360;
            end
            SatOrbitParameter_IJ(6)=TempParameter;
            satellite=CreateSatObjectFun(scenario,SatName_IJ,SatOrbitParameter_IJ,SatPropagator);
            satellite_Graphics=satellite.Graphics;
            GAttributes=satellite_Graphics.Attributes;
            GAttributes.Inherit=0;
            GAttributes.LabelVisible             =SatLabelVisible;
            GAttributes.IsGroundTrackVisible     =SatIsGroundTrackVisible;
            GAttributes.IsOrbitVisible           =SatIsOrbitVisible;
            GAttributes.IsGroundMarkerVisible    =SatIsGroundMarkerVisible;
            GAttributes.IsOrbitMarkerVisible     =SatIsOrbitMarkerVisible;
            GAttributes.Color=16711680;%��ɫ
            if(strcmp(satellite.PropagatorType,'ePropagatorHPOP'))
                ForceModel=satellite.Propagator.ForceModel;
                %% ��������
                Drag=ForceModel.Drag;
                DragModel=Drag.DragModel;
                DragModel.Cd              =HPOPForceModel.DragModel.Cd;
                DragModel.AreaMassRatio   =HPOPForceModel.DragModel.AreaMassRatio;
                %% ����ѡ��
                MoreOptions=ForceModel.MoreOptions;
                MoreOptions.Static.SatelliteMass  =HPOPForceModel.MoreOptions.Static.SatelliteMass;
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
    %% �����������ǵĶ���ά��ʾ
    satellite_Graphics=satellite.Graphics;
    GAttributes=satellite_Graphics.Attributes;
    GAttributes.Inherit=0;
    GAttributes.LabelVisible           =SatLabelVisible;
    GAttributes.IsGroundTrackVisible     =SatIsGroundTrackVisible;
    GAttributes.IsOrbitVisible           =SatIsOrbitVisible;
    GAttributes.IsGroundMarkerVisible    =SatIsGroundMarkerVisible;
    GAttributes.IsOrbitMarkerVisible     =SatIsOrbitMarkerVisible;
    GAttributes.Color=16711680;%��ɫ
    %% ����Walker����
    y=CreateWalkerObjectFun(root,SatName,WalkerParameter,ConstellationName);
    if(y==0)
        error('Create Walker Failed');
    end
    satellite.Unload;
end
%% ��������վ
CreateFacObjectFun(scenario,FacName,MinElevation);
try
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
    CovGraphicsStatic.IsRegionVisible=0;
    CovGraphicsStatic.IsPointsVisible=1;
    CovGraphicsStatic.Color=65535;
    CovGraphicsStatic.FillPoints=0;
    CovGraphicsStatic.MarkerStyle='Point';%�����ĵ����ҹؼ���Graphics Marker
    CovGraphics.Animation.IsSatisfactionVisible=0;
    CovGraphicsStatic.IsPointsVisible=CovIsPointsVisible;
    %% ���Ƕ���������߼�����
    CovAdvanced=coverage.Advanced;
    CovAdvanced.AutoRecompute=0;          %�������Զ�����
catch
end

try
    %% ����FOM
    fom=coverage.Children.New('eFigureOfMerit', FomName);
    fom.SetDefinitionType(FomDefinitionType);
    fom.Definition.SetComputeType(FomComputeType);
    fomSatisfaction=fom.Definition.Satisfaction;
    fomSatisfaction.EnableSatisfaction=1;
    fomSatisfaction.SatisfactionType=FomSatisfactionType;
    fomSatisfaction.SatisfactionThreshold=int16(1);
    fomGraphics=fom.Graphics;
    fomGraphics.Animation.IsVisible=0;
    fomGraphics.Static.IsVisible=1;
    fomGraphics.Static.FillPoints=1;
    fomGraphics.Static.Color=16711680;%Blue
    if(IsGraphicsContours==1)
        fomGraphicsContours=fomGraphics.Static.Contours;
        fomGraphicsContours.IsVisible = true;
        fomGraphicsContours.ColorMethod='eExplicit';
        fomRampColor         =fomGraphicsContours.RampColor;
        fomLevelAttributes   =fomGraphicsContours.LevelAttributes;
        fomLegend            =fomGraphicsContours.Legend;
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
    %root.ExecuteCommand('Parallel / Configuration ParallelType Local NumberOfLocalCores 4');
    %root.ExecuteCommand('Parallel / AutomaticallyComputeInParallel Off');
    %% ���Ƕ�����м���
    %coverage.ComputeAccesses;
    %% ��ȡȫ�򸲸ǵ�����
    %y=GetFomSatisfactionDataFun(fom);
end
toc















