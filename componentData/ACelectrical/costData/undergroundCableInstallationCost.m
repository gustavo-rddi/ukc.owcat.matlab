function cInstall = undergroundCableInstallationCost(o, data, lCable, ~, ~)

if any(strcmpi({o.WTG.fndType}, 'oblyth'))

   %Cable section installation Navitus (adj. to ref. year)%
   cInstall = 390*lCable;
   %apply CPI inflation modifier%
   cInstall = cInstall * costScalingFactor(o, data, 2016, 'GBP');
   
return;    
end

%correlation of Ecofys data [GBP]%
cInstall = 9894000 + 364.6*lCable;

%apply CPI inflation modifier%
cInstall = cInstall * costScalingFactor(o, data, 2013, 'GBP');