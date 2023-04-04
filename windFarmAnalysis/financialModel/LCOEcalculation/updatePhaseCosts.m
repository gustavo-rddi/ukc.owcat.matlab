function [CAPEX OPEX] = updatePhaseCosts(OWF, phase, CF)

CAPEX = phase.CAPEX;
OPEX = phase.OPEX;

CAPEXfields = fieldnames(CAPEX.nom);
OPEXfields = fieldnames(OPEX.nom);

CAPEX.nom.total = 0; CAPEX.real.total = 0;
OPEX.nom.total = 0; OPEX.real.total = 0;

for i = 1 : length(CAPEXfields)
    
    if CAPEX.nom.(CAPEXfields{i}) == 0
        
        CAPEX.nom.(CAPEXfields{i}) = -sum(CF.nom.(CAPEXfields{i}));
        
    end
    
    if CAPEX.real.(CAPEXfields{i}) == 0
        
        CAPEX.real.(CAPEXfields{i}) = -sum(CF.real.(CAPEXfields{i}));
        
    end
    
    CAPEX.nom.total = CAPEX.nom.total + CAPEX.nom.(CAPEXfields{i});
    CAPEX.real.total = CAPEX.real.total + CAPEX.real.(CAPEXfields{i});
    
end

for i = 1 : length(OPEXfields)
    
    if OPEX.nom.(OPEXfields{i}) == 0
        
        OPEX.nom.(OPEXfields{i}) = -sum(CF.nom.(OPEXfields{i}))/OWF.nOper;
        
    end
    
    if OPEX.real.(OPEXfields{i}) == 0
        
        OPEX.real.(OPEXfields{i}) = -sum(CF.real.(OPEXfields{i}))/OWF.nOper;
        
    end
    
    OPEX.nom.total = OPEX.nom.total + OPEX.nom.(OPEXfields{i});
    OPEX.real.total = OPEX.real.total + OPEX.real.(OPEXfields{i});
    
end