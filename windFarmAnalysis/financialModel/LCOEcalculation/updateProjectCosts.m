function o = updateProjectCosts(o, data, ~, ~)

CAPEXfields = fieldnames(o.CAPEX.nom);
OPEXfields = fieldnames(o.OPEX.nom);
DECEXfields = fieldnames(o.DECEX.nom);

o.CAPEX.nom.total = 0; o.CAPEX.real.total = 0;
o.OPEX.nom.total = 0; o.OPEX.real.total = 0;
o.DECEX.nom.total = 0; o.DECEX.real.total = 0;

for i = 1 : length(CAPEXfields)
    
    o.CAPEX.nom.(CAPEXfields{i}) = -sum(o.LCOE.CF.nom.(CAPEXfields{i}));
        
    o.CAPEX.real.(CAPEXfields{i}) = -sum(o.LCOE.CF.real.(CAPEXfields{i}));
        
    o.CAPEX.nom.total = o.CAPEX.nom.total + o.CAPEX.nom.(CAPEXfields{i});
    o.CAPEX.real.total = o.CAPEX.real.total + o.CAPEX.real.(CAPEXfields{i});
    
end

for i = 1 : length(OPEXfields)
    
    o.OPEX.nom.(OPEXfields{i}) = -sum(o.LCOE.CF.nom.(OPEXfields{i}))/data.WTG.nOper;
    
    o.OPEX.real.(OPEXfields{i}) = -sum(o.LCOE.CF.real.(OPEXfields{i}))/data.WTG.nOper;
    
    o.OPEX.nom.total = o.OPEX.nom.total + o.OPEX.nom.(OPEXfields{i});
    o.OPEX.real.total = o.OPEX.real.total + o.OPEX.real.(OPEXfields{i});
    
end

for i = 1 : length(DECEXfields)
    
    o.DECEX.nom.(DECEXfields{i}) = -sum(o.LCOE.CF.nom.(DECEXfields{i}));
    
    o.DECEX.real.(DECEXfields{i}) = -sum(o.LCOE.CF.real.(DECEXfields{i}));
    
    o.DECEX.nom.total = o.DECEX.nom.total + o.DECEX.nom.(DECEXfields{i});
    o.DECEX.real.total = o.DECEX.real.total + o.DECEX.real.(DECEXfields{i});
    
end