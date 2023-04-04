function o = sizeHVAClandfallSubstationComponents(o, ~)

%initialise design%
o.landfallSS.capComp = 0;
o.landfallSS.nExportCable = o.OWF.nExportCable;

for i = 1 : o.OWF.nOSS
       
    %determine required shunt reactor capacity and number of export cables%
    o.landfallSS.capComp = o.landfallSS.capComp + o.offshoreSS(i).QlandfallSS;
            
end

%calculate required number of HV switchgear%
o.landfallSS.nHVswitch = 1 + 2*o.landfallSS.nExportCable;