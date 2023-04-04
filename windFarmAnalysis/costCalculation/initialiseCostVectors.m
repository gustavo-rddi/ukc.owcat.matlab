function o = initialiseCostVectors(o)

%inform of current operation%
%message(o, 'Performing Cost Calculation...', 'single', 1);
    
%CAPEX cost fields to initialise%
CAPEXitems = {'turbSupply', 'fndSupply', 'arraySupply', 'substationSupply', 'exportSupply', 'onshoreSupply', ...
             'turbInstall', 'fndInstall', 'arrayInstall', 'substationInstall', 'exportInstall', 'onshoreInstall', ...
             'development', 'projManagement', 'portFacilities', 'conInsurance', 'conContingency'};

%OPEX cost fields to initialise%
OPEXitems = {'operation', 'turbMaint', 'BOPmaint', 'SSmaint', 'expMaint', ...
             'gridConnection', 'opInsurance', 'seabedRent', 'opContingency'};
         
%DECEX cost fields to initialise%
DECEXitems = {'turbDecom', 'fndDecom', 'substationDecom', ...
              'decContingency'};
         
%initialise CAPEX terms%
for j = 1 : length(CAPEXitems)
    o.CAPEX.real.(CAPEXitems{j}) = 0;
    o.CAPEX.nom.(CAPEXitems{j}) = 0;
end

%initialise OPEX terms%
for j = 1 : length(OPEXitems)
    o.OPEX.real.(OPEXitems{j}) = 0;
    o.OPEX.nom.(OPEXitems{j}) = 0;
end

%initialise DECEX terms%
for j = 1 : length(DECEXitems)
    o.DECEX.real.(DECEXitems{j}) = 0;
    o.DECEX.nom.(DECEXitems{j}) = 0;
end