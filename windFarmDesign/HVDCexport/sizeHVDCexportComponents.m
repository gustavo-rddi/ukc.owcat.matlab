function o = sizeHVDCexportComponents(o, data)

o = sizeCollectorComponents(o, data);

o = sizeHVDCgridSubstationComponents(o, data);

%design substation interconnectors%
if o.design.intConSS
    o = sizeHVACinterconnectorCables(o, data);
end