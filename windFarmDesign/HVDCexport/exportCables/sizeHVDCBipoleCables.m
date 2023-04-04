function o = sizeHVDCBipoleCables(o, data)

%calculate rated current of available cable sections%
Isect = DCcableProperties('Irate', data.HVDC.Asect, 'Cu');

for i = 1 : o.OWF.nConv
    
    %determine active export current per cable%
    Iexport = o.offshoreConv(i).capConv/(2*o.design.Vexport);
    
    o.offshoreConv(i).Acable = data.HVDC.Asect(find(Isect >= Iexport, 1));
   
end

o.OWF.nExportCable = 2 * o.OWF.nConv;