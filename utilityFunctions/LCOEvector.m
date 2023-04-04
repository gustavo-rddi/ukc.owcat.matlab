function [V, legend] = LCOEvector(o)

V = [];
legend = {};

V(end+1) = o.LCOE.real.development + o.LCOE.real.projManagement;
V(end+1) = o.LCOE.real.turbSupply;
V(end+1) = o.LCOE.real.turbInstall + o.LCOE.real.portFacilities/2;
V(end+1) = o.LCOE.real.fndSupply + o.LCOE.real.fndInstall + o.LCOE.real.portFacilities/2;
V(end+1) = o.LCOE.real.arraySupply + o.LCOE.real.arrayInstall;
V(end+1) = o.LCOE.real.substationSupply + o.LCOE.real.onshoreSupply+o.LCOE.real.exportSupply+o.LCOE.real.onshoreInstall+o.LCOE.real.gridConnection+o.LCOE.real.substationInstall+o.LCOE.real.exportInstall;
V(end+1) = o.LCOE.real.operation + o.LCOE.real.turbMaint+o.LCOE.real.BOPmaint+o.LCOE.real.SSmaint+o.LCOE.real.expMaint;

legend{end+1} = 'Development';
legend{end+1} = 'Wind Turbines';
legend{end+1} = 'Foundations';
legend{end+1} = 'Array Cables';
legend{end+1} = 'Export System';
legend{end+1} = 'O&M Activities';

if strcmpi(o.finance.type, 'project')

    V(end+1) = o.LCOE.real.turbDecom + o.LCOE.real.fndDecom + o.LCOE.real.substationDecom+o.LCOE.real.decomReserve+o.LCOE.real.intIncome;

    legend{end+1} = 'Decommissioning';
        
else
    
    V(end+1) = o.LCOE.real.turbDecom + o.LCOE.real.fndDecom + o.LCOE.real.substationDecom;
    
    legend{end+1} = 'Decommissioning';
    
end

V(end+1) = o.LCOE.real.conInsurance+o.LCOE.real.opInsurance;
V(end+1) = o.LCOE.real.seabedRent + o.LCOE.real.taxes;
V(end+1) = o.LCOE.real.conContingency + o.LCOE.real.opContingency + o.LCOE.real.decContingency;

legend{end+1} = 'Insurance';
legend{end+1} = 'Taxes';
legend{end+1} = 'Contingency';

if strcmpi(o.finance.type, 'project')
    
    V = V * o.LCOE.real.total / sum(V);
    
end
    