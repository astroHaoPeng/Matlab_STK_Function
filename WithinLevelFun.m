function y = WithinLevelFun(InputMatrix,Min,Max)
% ���� �� �Ƕ�ֵ�任Ϊһ���ķ�Χ��
KSize=size(InputMatrix);
AllLength=KSize(1)*KSize(2);
if length(KSize)==3
    AllLength=KSize(1)*KSize(2)*KSize(3);
end

for i=1:AllLength
    if InputMatrix(i)<Min
        InputMatrix(i)=InputMatrix(i)+360;
    end
    if InputMatrix(i)>Max
        InputMatrix(i)=InputMatrix(i)-360;
    end
end
y=InputMatrix;
end
