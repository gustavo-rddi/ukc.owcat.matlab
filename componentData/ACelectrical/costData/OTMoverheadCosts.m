function Coverhead = OTMoverheadCosts(data, nSupply, yearSupply, ~)

cOTMdesign = 1010500 * (nSupply/2)^0.5;

Coverhead = cOTMdesign;

if nargin > 2

    %apply CPI inflation modifier%
    Coverhead = Coverhead * CPImodifier(yearSupply, 2018, data);
    
end