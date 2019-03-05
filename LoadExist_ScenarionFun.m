%%作用 加载已经存在的场景
function [uiapp,root,scenario] = LoadExist_ScenarionFun(ScPath)
try
    uiapp = actxGetRunningServer('STK11.application');
    root = uiapp.Personality2;
    checkempty = root.Children.Count;
    if checkempty == 0
        uiapp.visible = 1;
        root.Load(ScPath);
        scenario = root.CurrentScenario;
    else
        root.CurrentScenario.Unload;
        uiapp.visible = 1;
        root.Load(ScPath);
        scenario = root.CurrentScenario;
    end
catch
    uiapp = actxserver('STK11.application');
    root = uiapp.Personality2;
    uiapp.visible = 1;
    root.Load(ScPath);
    scenario = root.CurrentScenario;
end
uiapp.WindowState='eWindowStateMaximized';
uiapp.Windows.Arrange('eArrangeStyleTiledVertical');
end

