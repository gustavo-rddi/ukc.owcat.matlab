function Cves = supportVesselCosts(data, nVes, nComm, stocVar) 

%total support vessel costs%
Cves = 1100000 * nVes * nComm;

%apply CPI inflation modifier and currency conversion%
Cves = Cves * exchangeRate(data.econ.curr, 'GBP', data) ...
            * CPImodifier(data.econ.yrReal, 2019, data.econ.curr, data);

if nargin > 3
    
    %apply stochastic cost multiplier%
    Cves = Cves * stocVar.cVessels;
    
end
    