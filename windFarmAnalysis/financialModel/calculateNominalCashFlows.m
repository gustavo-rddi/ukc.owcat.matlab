function CF = calculateNominalCashFlows(o, CF, data)

%determine real-to-nominal conversion factors%
fNom = arrayfun(@(X)CPImodifier(data, X, data.econ.(o.OWF.loc).yrReal, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + CF.t);

%get list of current cash-flow items%
CFfields = fieldnames(CF.real);

for j = 1 : length(CFfields)
    
    %determine nominal cash flows from equivalent real-term items%
    CF.nom.(CFfields{j}) = CF.real.(CFfields{j}) .* fNom;
    
end