function CPI = inflationData(data)

%determine path to external data files%
dataDir = strcat(data.paths.homeDir, filesep, 'marketData', filesep, 'priceIndicators', filesep);

%get specifications data from file%
output = importdata(strcat(dataDir, 'CPIdata.txt'));

%store CPI data%
CPI.year = output.data(:,1);
CPI.GBP = output.data(:,2);
CPI.EUR = output.data(:,3);