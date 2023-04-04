function cTNUoS = getTNUoScharge(o, data, nZone, fCap)

%get specifications data from file%
dataFile = strcat(data.paths.homeDir, filesep, 'marketData', filesep, 'nationalData', filesep, 'UKgridCharges', filesep, 'TNUoSdata.txt');
output = importdata(dataFile);

%extract TNUoS components%
zID = output.data(:,1);
cFix = output.data(:,2) / 1000;
cVar = output.data(:,3) / 1000;

%annual calculate TNUoS charge%
cTNUoS = cFix(zID == nZone) + fCap*cVar(zID == nZone);

%apply CPI inflation modifier%
cTNUoS = cTNUoS * costScalingFactor(o, data, 2020, 'GBP'); 
