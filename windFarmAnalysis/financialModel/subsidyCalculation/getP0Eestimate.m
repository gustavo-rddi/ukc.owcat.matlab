function P0E = getP0Eestimate(o, data)

%estimate CAPEX requirement of OWF%
CAPEX = o.CAPEX.real.development ...
      + o.CAPEX.real.turbSupply + o.CAPEX.real.turbInstall ...
      + o.CAPEX.real.fndSupply + o.CAPEX.real.fndInstall ...
      + o.CAPEX.real.arraySupply + o.CAPEX.real.arrayInstall ...
      + o.CAPEX.real.substationSupply + o.CAPEX.real.substationInstall ...
      + o.CAPEX.real.portFacilities ...
      + o.CAPEX.real.projManagement;
  
OPEX = o.OPEX.real.operation ...
     + o.OPEX.real.turbMaint + o.OPEX.real.BOPmaint + o.OPEX.real.SSmaint ...
     + o.OPEX.real.gridConnection;
      
%apply contingency to CAPEX/OPEX values%
CAPEX = CAPEX * (1 + data.econ.contCon);
OPEX = OPEX * (1 + data.econ.contOp);

fInfl = (data.CPI.(data.econ.(o.OWF.loc).curr)(end)/data.CPI.(data.econ.(o.OWF.loc).curr)(1))^(1/(length(data.CPI.(data.econ.(o.OWF.loc).curr))-1));

%calculate equivalent real discount rate%
WACCreal = (1 + o.finance.kHurdle)/fInfl - 1;

%calculate capital return factor%
alpha = WACCreal/(1 - (1+WACCreal)^-data.econ.FR.nSub);

%calculate simple LCOE estimation%
P0E = ((alpha + data.econ.fInsPD)*CAPEX + (1-data.econ.(o.OWF.loc).taxCorp)*OPEX) ...
      / ((1-data.econ.(o.OWF.loc).taxCorp)*(1-data.econ.fInsBI)*o.OWF.AEPnet);