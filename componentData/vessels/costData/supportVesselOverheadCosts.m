function Csupp = supportVesselOverheadCosts(data, nComm, stocVar) 

%emergency response%
cEmerg = 1800000*nComm;

%crew vessels%
cCrew = 2350000*nComm;

cMarkings = 730000*nComm;

%total support vessel costs%
Csupp = cEmerg + cCrew + cMarkings;

%apply CPI inflation modifier and currency conversion%
Csupp = Csupp * exchangeRate(data.econ.curr, 'GBP', data) ...
              * CPImodifier(data.econ.yrReal, 2019, data.econ.curr, data);

if nargin > 3
    
    %apply stochastic cost multiplier%
    Csupp = Csupp * stocVar.cVessels;
    
end