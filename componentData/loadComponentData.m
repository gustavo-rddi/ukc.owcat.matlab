function data = loadComponentData(o, data, Y)

%inform of current operation%
message(o, 'Loading Component Data...', {'single', 'stoc'}, 1);

%load wind turbine specifcations%
data = WTGspecifications(data);

%load foundation specifications%
data = foundationSpecifications(data);

%load array cable specifications%
data = arraySpecifications(data);

%load export system specifications%
data = HVACspecifications(data);
data = HVDCspecifications(data);

%load vessel specifications%
data = vesselSpecifications(data);

%load economic specifications%
data = economicSpecifications(data);

%load material cost data%
data = materialCostData(data);

%load modelling constants%
data = modellingConstants(data);

%load uncertainties%
data = defaultUncertainties(data);

%apply data changes%
if ~isempty(Y)
    data = modifyComponentData(data, Y);
end