function o = sizeOTMcomponents(o, data)

for  i = 1 : o.OWF.nOSS
    
    %isingle transformer%
    o.offshoreSS(i).nTrans = 1;
    
    %calculate total required offshore transformer capacity%
    o.offshoreSS(i).capTrans = max(o.offshoreSS(i).capExport, o.offshoreSS(i).capWTG/data.OTM.cosPhi);
        
    %determine number of MV switchgear required%
    o.offshoreSS(i).nMVswitch = o.offshoreSS(i).nString + o.offshoreSS(i).nTrans;
    
    %determine number of HV switchgear required%
    o.offshoreSS(i).nHVswitch = 1 + o.design.intConSS;
    
    if ~o.OWF.fndShare
        
       %store number of pin-piles%
        o.offshoreSS(i).nPP = data.sJKT.nPP;
        
    else
        
        %determine shared WTG number%
        iWTGshare = o.offshoreSS(i).iWTGshare;
        
        %force WTG onto jacket foundation%
        o.WTG(iWTGshare).fndType = 'jacket';
        
        %store number of pin-piles%
        o.WTG(iWTGshare).nPP = data.sJKT.nPP;
        o.offshoreSS(i).nPP = 0;
               
    end    
        
end