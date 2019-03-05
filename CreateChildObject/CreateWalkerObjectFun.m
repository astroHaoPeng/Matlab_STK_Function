function y = CreateWalkerObjectFun(root,SatName,FourWalkerElements,ConstellationName)
%ʹ��STK����Walker����
%% ����
% FourWalkerElements��1��   �� Walker�����Ĺ������
% FourWalkerElements��2��   �� Walker����ÿ�������������
% FourWalkerElements��3��   �� Walker�������ڹ��������ͬ���ǵ������ǶȲ�ֵ
% FourWalkerElements��4��   �� Walker�������ڹ����������ྭ��ֵ
%% ���
%�Ƿ񴴽��ɹ����ɹ�Ϊ1��ʧ��Ϊ0

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

