function [revStream, targSalesStart, targSalesAnn] = subsidyRevenueStream(o, data, Psub, t, subType, mode)

if nargin < 6; mode = 'P50'; end

%determine real-to-nominal conversion factors%
fNom = arrayfun(@(X)CPImodifier(data, X, data.econ.(o.OWF.loc).yrReal, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + t);

fRealWholesale = (1 + data.econ.(o.OWF.loc).grWhole) .^ (o.OWF.yrOper + t - data.econ.(o.OWF.loc).yrPrice);

switch lower(subType)
    
    case 'p0e'

        %production correction curve%
        N = [0 0.85 0.9 1.1 1.15 1e9]; R = [ 0 0.85 0.99 1.01 1.151 1e9];
        
        %update subsidy to pre-FID value (at 70% indexation)%
        P1E = Psub * (0.3 + 0.7*CPImodifier(data, o.OWF.yrOper - (o.OWF.nComm+3), data.econ.FR.yrPrice, data.econ.(o.OWF.loc).curr));

        %determine life-time adjusted subsidy value (at 60% indexation)%
        P1Eadj = P1E * (0.4 + 0.6*arrayfun(@(X)CPImodifier(data, X, o.OWF.yrOper, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + t));

        if strcmpi(mode, 'P50')
        
            revSubsidy = o.OWF.AEPnet * interp1(N, R, o.OWF.annYield/o.OWF.AEPnet) .* P1Eadj .* (t >= 0) .* (t < data.econ.FR.nSub);

            revMarket = o.OWF.annYield .* data.econ.FR.Pwhole * (1 - data.econ.discPPA) .* fRealWholesale .* fNom .* ((t < 0) + (t >= data.econ.FR.nSub));
        
            targSalesAnn = o.OWF.AEPnet .* P1Eadj .* (t >= 0) .* (t < data.econ.FR.nSub) ...
                     + o.OWF.AEPnet .* data.econ.FR.Pwhole * (1 - data.econ.discPPA) .* fNom .* (t >= data.econ.FR.nSub) .* (t < data.WTG.nOper) ;
                
            targSalesStart = o.OWF.AEPnet * P1E;         
            
        else
            
            revSubsidy = o.OWF.AEPnet * interp1(N, R, o.OWF.annYieldP90/o.OWF.AEPnet) .* P1Eadj .* (t >= 0) .* (t < data.econ.FR.nSub);

            revMarket = o.OWF.annYieldP90 .* data.econ.FR.Pwhole * (1 - data.econ.discPPA) .* fRealWholesale .* fNom .* ((t < 0) + (t >= data.econ.FR.nSub));
        
            targSalesAnn = o.OWF.AEPnet * interp1(N, R, o.OWF.AEPnetP90/o.OWF.AEPnet) .* P1Eadj .* (t >= 0) .* (t < data.econ.FR.nSub) ...
                         + o.OWF.AEPnetP90 .* data.econ.FR.Pwhole * (1 - data.econ.discPPA) .* fNom .* (t >= data.econ.FR.nSub) .* (t < data.WTG.nOper) ;
                
            targSalesStart = o.OWF.AEPnet * interp1(N, R, o.OWF.AEPnetP90/o.OWF.AEPnet) * P1E;   
            
        end 
                 
    case 'p0r'
        
        N = [0 0.5-eps 0.5 1.15 1e9]; R = [0 0.5 1 1 1e9];
        
        P3R = Psub * CPImodifier(data, o.OWF.yrOper - 1, data.econ.FR.yrPrice, data.econ.(o.OWF.loc).curr);

        revSubsidy = o.OWF.AEPnet * interp1(N, R, o.OWF.annYield/o.OWF.AEPnet) .* P3R .* (t >= 0) .* (t < data.econ.FR.nSub);
        
        revMarket = 0;
        
        targSalesAnn = o.OWF.AEPnet .* P3R .* (t >= 0) .* (t < data.econ.FR.nSub);
        
        targSalesStart = o.OWF.AEPnet .* P3R;
        
    case 'pstrike'
        
        revMarket = o.OWF.annYield .* data.econ.UK.Pwhole * (1 - data.econ.discPPA) .* fNom .* fRealWholesale;
        
        revSubsidy = o.OWF.annYield * (Psub - data.econ.UK.Pwhole) .* fNom .* (t >= 0) .* (t < data.econ.UK.nCFD);
        
        targSalesAnn = o.OWF.AEPnet * (Psub - data.econ.UK.Pwhole) .* fNom .* (t >= 0) .* (t < data.econ.UK.nCFD) ...
                     + o.OWF.AEPnet .* data.econ.UK.Pwhole * (1 - data.econ.discPPA) .* fNom;
        
        targSalesStart = o.OWF.AEPnet * (Psub - data.econ.UK.Pwhole) .* fNom(t == 0) ...
                       + o.OWF.AEPnet .* data.econ.UK.Pwhole * (1 - data.econ.discPPA) .* fNom(t == 0);
        
end

revStream = revSubsidy + revMarket;