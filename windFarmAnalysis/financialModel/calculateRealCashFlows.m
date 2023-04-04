function CF = calculateRealCashFlows(o, CF, data)

%determine real-to-nominal conversion factors%
fNom = arrayfun(@(X)CPImodifier(data, X, data.econ.(o.OWF.loc).yrReal, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + CF.t);

newCF = setdiff(fieldnames(CF.nom), fieldnames(CF.real));

for i = 1 : length(newCF)
    
    CF.real.(newCF{i}) = CF.nom.(newCF{i}) ./ fNom;
    
end