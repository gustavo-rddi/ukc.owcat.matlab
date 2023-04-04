function o = sizeHVDCgridSubstationComponents(o, data)

o.gridSS.capConv = sum([o.offshoreConv.capConv]);

%initialise number of transformers (max 1000MW for SQSS)%
o.gridSS.nTrans = max(ceil(o.OWF.cap/data.HVAC.capMaxTran), data.HVAC.nMinTrans);

capReactTrans = o.OWF.cap * sqrt(1/data.HVAC.cosPhiGC^2 - 1) / o.gridSS.nTrans;

if o.gridSS.nTrans == 1
    
    %calculate single transformer capacity with SVC (no redundancy)%
    o.gridSS.capTrans = sqrt(o.OWF.cap^2 + capReactTrans^2);
    
else
    
    %determine active export capacity (with redundancy)
    capActive = o.OWF.cap * max(data.HVAC.fRedund/(o.gridSS.nTrans - 1), 1/o.gridSS.nTrans);
    
    %calculate single transformer capacity with SVC%
    o.gridSS.capTrans = sqrt(capActive^2 + capReactTrans^2);
   
end

o.gridSS.nHVswitch = o.gridSS.nTrans;
o.gridSS.nUHVswitch = o.gridSS.nTrans;