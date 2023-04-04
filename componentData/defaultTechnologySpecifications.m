function data = defaultTechnologySpecifications(data)

if nargin < 1 || isempty(data)
    data = struct;
else
    data.CPI = inflationData(data);
    data.exch = exchangeRateData();
end

%load WTG specifications%
data.WTG = WTGspecifications();

%load foundation specifications for WTG and SS units%
[data.fnd, data.MP, data.TP, data.sJKT, data.hJKT, data.PP, data.semi, data.drag, data.GBF] = foundationSpecifications();

%load array cable specifications%
data.array = arraySpecifications();


%load export system specifications%
[data.HVAC, data.OHVS, data.OTM] = HVACspecifications();
[data.HVDC, data.VSC] = HVDCspecifications();

%load vessel specifications%
[data.vessel, data.equip, data.crew] = vesselSpecifications();

%load economic specifications%
data.econ = economicSpecifications();

%load global modelling data%
data.model = modellingConstants();