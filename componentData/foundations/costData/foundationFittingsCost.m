function Cfit = foundationFittingsCost(o, data, ~, ~)

%fall arrest system [EUR]%
Cfall = 8000;

%foundation davit crane [EUR]%
Ccrane = 100000;

%electrical fittings [EUR]%
Celec = 155500;

%sum of fittings costs%
Cfit = Cfall + Ccrane + Celec;

%apply CPI inflation modifier and currency conversion%
Cfit = Cfit * costScalingFactor(o, data, 2019, 'EUR');
