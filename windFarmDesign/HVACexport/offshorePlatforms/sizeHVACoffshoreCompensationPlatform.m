function o = sizeHVACoffshoreCompensationPlatform(o, data)

%single OCP%
o.OWF.nOCP = 1;

%initialise design%
o.offshoreCP.capComp = 0;
o.offshoreCP.nExportCable = 0;
o.offshoreCP.nHVswitch = 1;

for i = 1 : o.OWF.nOSS
    
    %add compensation capacity to OCP substation%
    o.offshoreCP.capComp = o.offshoreCP.capComp + o.offshoreSS(i).QcompPlat;
    
    %determine required HV switchgear%
    o.offshoreCP.nExportCable = o.offshoreCP.nExportCable + o.offshoreSS(i).nExportCable;
    o.offshoreCP.nHVswitch = o.offshoreCP.nHVswitch + 2*o.offshoreSS(i).nExportCable;
    
end

%build in 1st phase%
o.offshoreCP.phase = 1;

%estimate water depth and port distance of OCP%
o.offshoreCP.dWater = mean([o.zone(:).dWater])*2/3;
o.offshoreCP.dPortCon = mean([o.zone(:).dPortCon])*2/3;
o.offshoreCP.dPortOM = mean([o.zone(:).dPortOM])/2;

%store number of pin-piles%
o.offshoreCP.nPP = data.hJKT.nPP;

o.offshoreCP.dSpace = 0;
