function o = calculateWTGsupplyCosts(o, data, stocVar, markMods)

for i = 1 : o.OWF.nWTG
   
    %calculate costs for each WTG unit%
    o.WTG(i).Cturb = WTGsupplyCosts(o, data, o.WTG(i), stocVar, markMods);
     
%     if o.design.Varray ~= 33e3
%         
%         %additional GIS and transformer costs for non-33kV option%
%         o.WTG(i).Cturb = o.WTG(i).Cturb + GIScost(o, data, o.design.Varray, 'offshore', stocVar, markMods) ...
%                                         - GIScost(o, data, 33e3, 'offshore', stocVar, markMods) ...
%                                         + transformerCost(o, data, o.WTG(i).cap, o.design.Varray, 'offshore', stocVar, markMods) ...
%                                         - transformerCost(o, data, o.WTG(i).cap, 33e3, 'offshore', stocVar, markMods);
%         
%     end
    
    %add direct WTG supply costs to OWF total%
    o.CAPEX.real.turbSupply = o.CAPEX.real.turbSupply + o.WTG(i).Cturb;
        
end

%determine WTG transport costs%
Ctrans = WTGtransportCosts(o, data, o.OWF.nWTG, stocVar, markMods);

%determine WTG pre-assembly costs%
Cpre = WTGpreassemblyCost(o, data, o.OWF.nWTG, stocVar, markMods);

%add indirect WTG supply costs to OWF total%
o.CAPEX.real.turbSupply = o.CAPEX.real.turbSupply + 0*Ctrans + 0*Cpre;

    