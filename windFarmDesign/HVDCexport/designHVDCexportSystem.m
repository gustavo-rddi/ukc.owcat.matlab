function o = designHVDCexportSystem(o, data)

%determine overall HVAC OSS specifications%
o = setHVDCcollectorSpecifications(o, data);
o = setHVDCconverterSpecifications(o, data);

o = sizeCollectorCables(o, data);
o = sizeCollectorComponents(o, data);

o = sizeHVDCBipoleCables(o, data);

%determine OSS build order%
o = calculateHVDCbuildSchedule(o, data);

o = sizeHVDCgridSubstationComponents(o, data);