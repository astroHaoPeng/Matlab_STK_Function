function y = GetFomSatisfactionDataFun(Fom)
%   ��ȡFom->Static Satisfaction->Percent Satisfiedd������
FomData=Fom.DataProviders;
StaticSatisfactionData=FomData.Item('Static Satisfaction').Exec;
TempValue=StaticSatisfactionData.DataSets.GetDataSetByName('Percent Satisfied').GetValues;
y=cell2mat(TempValue);
end

