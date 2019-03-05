function y = GetFomSatisfactionDataFun(Fom)
%   获取Fom->Static Satisfaction->Percent Satisfiedd的数据
FomData=Fom.DataProviders;
StaticSatisfactionData=FomData.Item('Static Satisfaction').Exec;
TempValue=StaticSatisfactionData.DataSets.GetDataSetByName('Percent Satisfied').GetValues;
y=cell2mat(TempValue);
end

