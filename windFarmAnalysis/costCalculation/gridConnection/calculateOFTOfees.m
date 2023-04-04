function o = calculateOFTOfees(o, data)

for i = 1 : o.OWF.nFID
    
    %calculate ETV of OFTO assets (in nominal terms)%
    o.phase(i).CAPEX.nom.etvTransAsset = data.econ.fRecOFTO*(o.phase(i).CAPEX.nom.exportSupply + o.phase(i).CAPEX.nom.exportInstall) * (1 + min(data.econ.WACC, data.econ.IDCcap)) ...
                                       + data.econ.fRecOFTO*(o.phase(i).CAPEX.nom.onshoreSupply + o.phase(i).CAPEX.nom.onshoreInstall) * (1 + min(data.econ.WACC, data.econ.IDCcap))^2;
            
    nomOFTOfee = 0.8*(4.26e6 + 0.076*o.phase(i).CAPEX.nom.etvTransAsset);
    
    CPIsale = CPImodifier(data.econ.yrOper, data.econ.yrPrice, data);       
           
    o.phase(i).CAPEX.real.etvTransAsset = o.phase(i).CAPEX.nom.etvTransAsset / CPIsale;
    o.phase(i).OPEX.real.OFTOfee = nomOFTOfee / CPIsale;
           
end