function uiapp = ReadSTKSCFun(FilePath)
try
    % Grab an existing instance of STK
    uiapp = actxGetRunningServer('STK11.application');
    root = uiapp.Personality2;
    checkempty = root.Children.Count;
    if checkempty == 0
        uiapp.visible = 1;
        root.Load(FilePath);
    else
        root.CurrentScenario.Unload;
        uiapp.visible = 1;
        root.Load(FilePath);
    end
catch
    uiapp = actxserver('STK11.application');
    root = uiapp.Personality2;
    uiapp.visible = 1;
    root.Load(FilePath);
end
uiapp.WindowState='eWindowStateMaximized';
uiapp.Windows.Arrange('eArrangeStyleTiledVertical');
end

