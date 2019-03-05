function y = Mean_OsculateRelationFromSTKFun(Element,Method)
%%功能 从STK中获取平根与瞬根的转换方式
%Element 轨道六要素 单位 km °   最后一个量为平近点角
%Method 转换方法
% 1：Osculate2KI
% 2：Osculate2BLong
% 3：Osculate2BShort
% 4：KI2Os
% 5：BLong2Os
% 6：BShort2Os
%% 会启动STK程序 可能会冲掉已创建的场景
%创建场景卫星
if(1)
    ScenarioName='Simple';
    try
        uiapp = actxGetRunningServer('STK11.application');
        root = uiapp.Personality2;
        checkempty = root.Children.Count;
        if checkempty == 0
            uiapp.visible = 0;
            root.NewScenario(ScenarioName);
            scenario = root.CurrentScenario;
        else
            root.CurrentScenario.Unload;
            uiapp.visible = 0;
            root.NewScenario(ScenarioName);
            scenario = root.CurrentScenario;
        end
    catch
        uiapp = actxserver('STK11.application');
        root = uiapp.Personality2;
        uiapp.visible = 0;
        root.NewScenario(ScenarioName);
        scenario = root.CurrentScenario;
    end
       
    sat = root.CurrentScenario.Children.New('eSatellite', 'Dack');
    sat.SetPropagatorType('ePropagatorAstrogator')
    BianGui = sat.Propagator;
    MCS = BianGui.MainSequence;
    MCS.RemoveAll;
    MCS.Insert('eVASegmentTypeInitialState','Inner Orbit','-');
    % Create a handle to the Initial State Segment, set it to use Modified
    % Keplerian elements and assign new initial values
    initstate = MCS.Item('Inner Orbit');
    initstate.OrbitEpoch = scenario.StartTime;
    initstate.SetElementType('eVAElementTypeKeplerian');
end

if(nargin<2)
    Method=1;
end
if(nargin==0)
    Element(1)=11378.137;
    Element(2)=0;
    Element(3)=45;
    Element(4)=0;
    Element(5)=0;
    Element(6)=0;
end
switch Method
    case 1
        StartMeanOsculateType='eVAElementOsculating';
        StopMeanOsculateType='eVAElementKozaiIzsakMean';
    case 2
        StartMeanOsculateType='eVAElementOsculating';
        StopMeanOsculateType='eVAElementBrouwerLyddaneMeanLong';
    case 3
        StartMeanOsculateType='eVAElementOsculating';
        StopMeanOsculateType='eVAElementBrouwerLyddaneMeanShort';
    case 4
        StartMeanOsculateType='eVAElementKozaiIzsakMean';
        StopMeanOsculateType='eVAElementOsculating';
    case 5
        StartMeanOsculateType='eVAElementBrouwerLyddaneMeanLong';
        StopMeanOsculateType='eVAElementOsculating';
    case 6
        StartMeanOsculateType='eVAElementBrouwerLyddaneMeanShort';
        StopMeanOsculateType='eVAElementOsculating';
end
%%输入结果

initstate.Element.ElementType = StartMeanOsculateType;
kep = initstate.Element;
kep.SemiMajorAxis=Element(1);
kep.Eccentricity = Element(2);
kep.Inclination = Element(3);
kep.RAAN = Element(4);
kep.ArgOfPeriapsis =Element(5);
kep.MeanAnomaly = Element(6);
%%输出结果
initstate.Element.ElementType = StopMeanOsculateType;
y(1)=kep.SemiMajorAxis;
y(2)=kep.Eccentricity;
y(3)=kep.Inclination;
y(4)=kep.RAAN;
y(5)=kep.ArgOfPeriapsis;
y(6)=kep.MeanAnomaly;
end

% Which type of elements (osculating or mean)
% Members
% Member Value Description
% eVAElementOsculating                                      0 Osculating.
% eVAElementKozaiIzsakMean                              1 Kozai-Izsak Mean.
% eVAElementBrouwerLyddaneMeanLong             2 Brouwer-Lyddane Mean Long.
% eVAElementBrouwerLyddaneMeanShort            3 Brouwer-Lyddane Mean Short.

