function o = sizeCollectorComponents(o, data, ~)

for  i = 1 : o.OWF.nOSS
    
    %initialise number of transformers%
    o.offshoreSS(i).nTrans = 1;
    
    o.offshoreSS(i).capTrans = o.offshoreSS(i).capExport;
    
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

for i = 1 : o.OWF.nConv
   
    %store number of pin-piles%
    o.offshoreConv(i).nPP = data.hJKT.nPP;
    
end