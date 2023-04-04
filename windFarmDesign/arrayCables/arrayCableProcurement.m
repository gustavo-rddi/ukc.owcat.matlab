function o = arrayCableProcurement(o, data, ~)

%determine cable cross-sections to order%
arraySections = unique([o.arrayString.Acond]);

%initialise cable-laying vector%
o.OWF.lArrayLay = 0;
o.OWF.lExportLay = 0;

for i = 1 : o.OWF.nString
    
    if ~strcmpi(o.OWF.expType, 'MVAC')
    
        for j = 1 : length(arraySections)
        
            %determine sections in current string that match the selected conductor cross-section%
            iSectSel = (o.arrayString(i).Acond == arraySections(j));
        
            lTotSect = sum(o.arrayString(i).lCableTot(iSectSel))*(1 + data.array.fSpare);
        
            o = addToProcurementRequirements(o, data, 'arrayCable', arraySections(j), sum(iSectSel), lTotSect);
                
        end
    
        %add cable seabed lengths to total cable-laying requirements%
        o.OWF.lArrayLay = o.OWF.lArrayLay + sum(o.arrayString(i).lCableSeabed);
        
    else
    
        for j = 1 : o.arrayString(i).nWTG
            
            lTotSect = o.arrayString(i).lCableTot(j)*(1 + data.array.fSpare);
            
            if j < o.arrayString(i).nWTG
            
                o = addToProcurementRequirements(o, data, 'arrayCable', o.arrayString(i).Acond(j), 1, lTotSect);
                
                o.OWF.lArrayLay = o.OWF.lArrayLay + o.arrayString(i).lCableSeabed(j);
                
            else
                
                o = addToProcurementRequirements(o, data, 'exportCable', o.arrayString(i).Acond(j), 1, lTotSect);
                                
                o.OWF.lExportLay = o.OWF.lExportLay + o.arrayString(i).lCableSeabed(j);
                
            end
            
        end
        
        o = addToProcurementRequirements(o, data, 'onshoreCable', o.arrayString(i).Aonshore, 1, o.arrayString(i).lCableOnshore);
                
    end
    
    if strcmpi(o.design.arrConf, 'ring')
        
        lPartLink = (o.arrayString(i).lLinkTot/2)*(1 + data.array.fSpare);
        
        o = addToProcurementRequirements(o, data, 'arrayCable', o.arrayString(i).AcondLink, 1/2, lPartLink);
        
        %add link cable seabed lengths to total cable-laying requirements%
        o.OWF.lArrayLay = o.OWF.lArrayLay + o.arrayString(i).lLinkSeabed/2;
        
    end
    
end