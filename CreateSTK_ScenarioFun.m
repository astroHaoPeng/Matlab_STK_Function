function [uiapp,root,scenario] = CreateSTK_ScenarioFun(ScenarioName)
% 创建一个名为ScenarioName的场景
if nargin ==0
    ScenarioName='None';
end
try
    uiapp = actxGetRunningServer('STK11.application');
    root = uiapp.Personality2;
    checkempty = root.Children.Count;
    if checkempty == 0
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
    uiapp = actxserver('STK11.application');
    root = uiapp.Personality2;
    uiapp.visible = 1;
    root.NewScenario(ScenarioName);
    scenario = root.CurrentScenario;
end
uiapp.WindowState='eWindowStateMaximized';
uiapp.Windows.Arrange('eArrangeStyleTiledVertical');
end

