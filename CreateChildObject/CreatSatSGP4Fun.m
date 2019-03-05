function y = CreatSatSGP4Fun( scenario,SatName,FileNamePath,SSCNumber)
%% 输入：
% scenario：            STK场景的接口
% SatName：          卫星的名字
% FileNamePath：  TLE数据文件的路径， 后缀为 .tce
% SSCNumber   :    SSC序号                 如:24793U 
%% 输出
% y：    创建好的卫星的接口
%% 开始
satellite = scenario.Children.New('eSatellite',SatName);
satellite.SetPropagatorType('ePropagatorSGP4');
propagator=satellite.Propagator;

%% AutoUpdate的设置
propagator.AutoUpdateEnabled=1;                                                             %   Whether automatic update is enabled.
AutoUpdate        =propagator.AutoUpdate;
AutoUpdate.SelectedSource='eSGP4AutoUpdateSourceFile';                       %Retrieve TLEs from a file.  
Properties           =AutoUpdate.Properties;
FileSource           =AutoUpdate.FileSource;
FileSource.Filename=FileNamePath;                  % 文件的读取位置   VIP
OnlineSource      =AutoUpdate.OnlineSource;

%% Segments的设置
Segments            =propagator.Segments;
Segments.SSCNumber=SSCNumber;

LoadMethod       =Segments.LoadMethod;
CommonTasks    =propagator.CommonTasks;
Settings               =propagator.Settings;
%% 预报卫星
satellite.Propagator.Step=60;
satellite.Propagator.Propagate;
y=satellite;
end

% Member Value                                                               Description                                                AgEVeSGP4AutoUpdateSource Enumeration 
% eSGP4AutoUpdateSourceUnknown                              -1 Unknown or unsupported TLE source.  
% eSGP4AutoUpdateSourceOnline                                    0 Retrieve TLEs from an online source (AGI server).  
% eSGP4AutoUpdateOnlineSpaceTrack                             1 Retrieve TLEs from the space track. Not currently supported.  
% eSGP4AutoUpdateSourceFile                                         2 Retrieve TLEs from a file.  
% eSGP4AutoUpdateNone                                                3 Manually specify/import TLEs, no auto-updates will be performed during propagation.  



