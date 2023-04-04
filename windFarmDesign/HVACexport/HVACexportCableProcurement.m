function o = HVACexportCableProcurement(o, data, ~)

%determine cable cross-sections to order this phase%
subseaSections = unique([o.offshoreSS.AcableSB]);
onshoreSections = unique([o.offshoreSS.AcableUG]);

o.OWF.lExportLay = sum([o.offshoreSS.nExportCable].*[o.offshoreSS.lCableOffshore]);

for i = 1 : o.OWF.nOSS
    
    for j = 1 : numel(subseaSections)
        
        if o.offshoreSS(i).AcableSB == subseaSections(j);
            
            lTotSect = o.offshoreSS(i).lCableOffshore*o.offshoreSS(i).nExportCable * (1 + data.HVAC.fSpare);
        
            o = addToProcurementRequirements(o, data, 'exportCable', subseaSections(j), o.offshoreSS(i).nExportCable, lTotSect);
            
        end
        
    end
    
    for j = 1 : numel(onshoreSections)
        
        if o.offshoreSS(i).AcableUG == onshoreSections(j);
            
            %identify cable sections and add to total length of onshore cables to supply%
            lTotSect = o.offshoreSS(i).lCableOnshore*o.offshoreSS(i).nExportCable * (1 + data.HVAC.fSpare);
            
            o = addToProcurementRequirements(o, data, 'onshoreCable', onshoreSections(j), o.offshoreSS(i).nExportCable, lTotSect);
            
        end
        
    end
     
end
