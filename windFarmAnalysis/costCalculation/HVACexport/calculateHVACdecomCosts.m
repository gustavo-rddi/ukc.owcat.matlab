function o = calculateHVACdecomCosts(o, data)

for i = 1 : o.OWF.nFID
    
    if (o.phase(i).nOSS ~= 0 && strcmpi(o.OWF.expConf, 'OHVS')) || (i == o.OWF.nFID && o.OWF.osComp)     
    
        %calculate fixed CLV mobilisation costs%
        o.phase(i).Cdecom = o.phase(i).Cdecom + data.vessel.HLV.nMob*data.vessel.HLV.dayRate * CPImodifier(data.econ.yrOper+data.econ.nOper, data.vessel.yrRef, data);
           

        %calculate costs per installation phase%
        for j = 1 : o.OWF.nZones
            o.zone(j).Cdecom = o.zone(j).Cdecom + data.vessel.HLV.nMob*data.vessel.HLV.dayRate*(o.zone(j).cap/o.OWF.cap) * CPImodifier(data.econ.yrOper+data.econ.nOper, data.vessel.yrRef, data);
        end
        
        
    end
        
end

