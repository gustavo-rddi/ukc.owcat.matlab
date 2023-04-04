function o = HVDCexportCableProcurement(o, data, ~)

%determine cable cross-sections to order this phase%
collectorSections = unique([o.offshoreSS.Acable]);
bipoleSections = unique([o.offshoreConv.Acable]);

o.OWF.lExportLay = sum([o.offshoreSS.nExportCable].*[o.offshoreSS.lCable]) + 2*sum([o.offshoreConv.lCableOffshore]);

for i = 1 : o.OWF.nOSS
    
    for j = 1 : numel(collectorSections)
        
        if o.offshoreSS(i).Acable == collectorSections(j);
            
            lTotSect = o.offshoreSS(i).lCable*o.offshoreSS(i).nExportCable * (1 + data.HVAC.fSpare);
        
            o = addToProcurementRequirements(o, data, 'exportCable', collectorSections(j), o.offshoreSS(i).nExportCable, lTotSect);
            
        end
        
    end
    
end

for i = 1 : o.OWF.nConv
    
    for j = 1 : numel(bipoleSections)
        
        if o.offshoreConv(i).Acable == bipoleSections(j);
            
            %identify cable sections and add to total length of onshore cables to supply%
            lTotSect = 2 * (o.offshoreConv(i).lCableOffshore + o.offshoreConv(i).lCableOnshore) * (1 + data.HVAC.fSpare);
            
            o = addToProcurementRequirements(o, data, 'HVDCbipole', bipoleSections(j), 2, lTotSect);
            
        end
        
    end
     
end
