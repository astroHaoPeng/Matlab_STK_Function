function y = CreatSatSGP4Fun( scenario,SatName,FileNamePath,SSCNumber)
%% ���룺
% scenario��            STK�����Ľӿ�
% SatName��          ���ǵ�����
% FileNamePath��  TLE�����ļ���·���� ��׺Ϊ .tce
% SSCNumber   :    SSC���                 ��:24793U 
%% ���
% y��    �����õ����ǵĽӿ�
%% ��ʼ
satellite = scenario.Children.New('eSatellite',SatName);
satellite.SetPropagatorType('ePropagatorSGP4');
propagator=satellite.Propagator;

%% AutoUpdate������
propagator.AutoUpdateEnabled=1;                                                             %   Whether automatic update is enabled.
AutoUpdate        =propagator.AutoUpdate;
AutoUpdate.SelectedSource='eSGP4AutoUpdateSourceFile';                       %Retrieve TLEs from a file.  
Properties           =AutoUpdate.Properties;
FileSource           =AutoUpdate.FileSource;
FileSource.Filename=FileNamePath;                  % �ļ��Ķ�ȡλ��   VIP
OnlineSource      =AutoUpdate.OnlineSource;

%% Segments������
Segments            =propagator.Segments;
Segments.SSCNumber=SSCNumber;

LoadMethod       =Segments.LoadMethod;
CommonTasks    =propagator.CommonTasks;
Settings               =propagator.Settings;
%% Ԥ������
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



