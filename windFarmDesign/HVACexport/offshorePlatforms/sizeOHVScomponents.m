function o = sizeOHVScomponents(o, data, ~)

for  i = 1 : o.OWF.nOSS
    
    %calculate total required offshore transformer capacity%
    capTotTrans = max(o.offshoreSS(i).capExport, o.offshoreSS(i).capWTG/data.OTM.cosPhi);
    
    %initialise number of transformers%
    o.offshoreSS(i).nTrans = data.HVAC.nMinTrans;
    
    for j = 1 : data.model.maxIter
    
        if o.offshoreSS(i).nTrans > 1
            
            %calaculate individual transformer capacity with redundancy%
            o.offshoreSS(i).capTrans = capTotTrans * max(data.HVAC.fRedund/(o.offshoreSS(i).nTrans - 1), 1/o.offshoreSS(i).nTrans);
        
        else
            
            %no redundancy for single tranformers%
            o.offshoreSS(i).capTrans = capTotTrans;
        
        end
    
        %check maximum transformer size%
        if o.offshoreSS(i).capTrans > data.HVAC.capMaxTran
            o.offshoreSS(i).nTrans = o.offshoreSS(i).nTrans + 1;
        else
            break;
        end
        
    end
    
    %determine number of MV switchgear required%
    o.offshoreSS(i).nMVswitch = o.offshoreSS(i).nString + o.offshoreSS(i).nTrans;
    
    %determine number of HV switchgear required%
    if o.offshoreSS(i).nTrans == o.offshoreSS(i).nExportCable
        o.offshoreSS(i).nHVswitch = o.offshoreSS(i).nTrans;
    else
        o.offshoreSS(i).nHVswitch = o.offshoreSS(i).nTrans + o.offshoreSS(i).nExportCable;
    end
       
    if data.OHVS.fCompOff > 0
        o.offshoreSS(i).nHVswitch = o.offshoreSS(i).nHVswitch + o.offshoreSS(i).nExportCable;
    end        
    
    %store number of pin-piles%
    o.offshoreSS(i).nPP = data.hJKT.nPP;
    
end