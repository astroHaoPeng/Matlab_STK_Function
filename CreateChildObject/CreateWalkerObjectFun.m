function y = CreateWalkerObjectFun(root,SatName,FourWalkerElements,ConstellationName)
%使用STK创建Walker星座
%% 输入
% FourWalkerElements（1）   ： Walker星座的轨道面数
% FourWalkerElements（2）   ： Walker星座每个轨道面卫星数
% FourWalkerElements（3）   ： Walker星座相邻轨道面编号相同卫星的真近点角度差值
% FourWalkerElements（4）   ： Walker星座相邻轨道面升交点赤经差值
%% 输出
%是否创建成功，成功为1，失败为0

try
    WalkerType=' Custom';
    walkercommondstr=['Walker */Satellite/',SatName,' Type',WalkerType,...
        ' NumPlanes ',                       num2str(FourWalkerElements(1)),...
        ' NumSatsPerPlane ',                 num2str(FourWalkerElements(2)),...
        ' InterPlaneTrueAnomalyIncrement ',  num2str(FourWalkerElements(3)),...
        ' RAANIncrement ',                   num2str(FourWalkerElements(4)),...
        ' ColorByPlane Yes SetUniqueNames No',...
        ' ConstellationName ', ConstellationName];
    root.ExecuteCommand(walkercommondstr);
    y=1;
catch
    y=0;
end
end

