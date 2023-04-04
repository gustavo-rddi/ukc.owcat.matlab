function P0R = getP0Restimate(o, data)

%estimate CAPEX requirement of OWF%
CAPEX = o.CAPEX.real.exportSupply + o.CAPEX.real.exportInstall ...
      + o.CAPEX.real.onshoreSupply + o.CAPEX.real.onshoreInstall;
  
OPEX = o.OPEX.real.expMaint;
      
%apply contingency to CAPEX/OPEX values%
CAPEX = CAPEX * (1 + data.econ.contCon);
OPEX = OPEX * (1 + data.econ.contOp);

fInfl = (data.CPI.(data.econ.(o.OWF.loc).curr)(end)/data.CPI.(data.econ.(o.OWF.loc).curr)(1))^(1/(length(data.CPI.(data.econ.(o.OWF.loc).curr))-1));

%calculate equivalent real discount rate%
WACCreal = (1 + o.finance.kHurdle)/fInfl - 1;

%calculate capital return factor%
alpha = WACCreal/(1 - (1+WACCreal)^-data.econ.FR.nSub);

%calculate simple LCOE estimation%
P0R = ((alpha + data.econ.fInsPD)*CAPEX + (1-data.econ.(o.OWF.loc).taxCorp)*OPEX) ...
      / ((1-data.econ.(o.OWF.loc).taxCorp)*(1-data.econ.fInsBI)*o.OWF.AEPnet);