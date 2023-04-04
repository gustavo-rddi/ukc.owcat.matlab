function o = sizeHVACgridSubstationComponents(o, data, ~, ~)

%initialise number of transformers (max 1000MW for SQSS)%
o.gridSS.nTrans = max(ceil(o.OWF.cap/data.HVAC.capMaxTran), data.HVAC.nMinTrans);

%determine capacity of reactive compensation connected to each transformer%
o.gridSS.capSVCtrans = o.OWF.cap * sqrt(1/data.HVAC.cosPhiGC^2 - 1) / o.gridSS.nTrans;

if o.gridSS.nTrans == 1
    
    %calculate single transformer capacity with SVC (no redundancy)%
    o.gridSS.capTrans = sqrt((o.OWF.cap/o.gridSS.nTrans)^2 + o.gridSS.capSVCtrans^2);
    
else
    
    %determine active export capacity (with redundancy)
    capActive = o.OWF.cap * max(data.HVAC.fRedund/(o.gridSS.nTrans - 1), 1/o.gridSS.nTrans);
    
    %calculate single transformer capacity with SVC%
    o.gridSS.capTrans = sqrt(capActive^2 + o.gridSS.capSVCtrans^2);
   
end

o.gridSS.nExportCable = sum([o.offshoreSS.nExportCable]);

%determine number of HV switchgear required%
if o.gridSS.nTrans == o.gridSS.nExportCable
    o.gridSS.nHVswitch = o.gridSS.nTrans + o.gridSS.nExportCable;
else
    o.gridSS.nHVswitch = o.gridSS.nTrans + 2*o.gridSS.nExportCable;
end

%calculate number of UHV switchgear%
o.gridSS.nUHVswitch = o.gridSS.nTrans;