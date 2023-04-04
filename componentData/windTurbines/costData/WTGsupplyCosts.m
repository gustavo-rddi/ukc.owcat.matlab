function Cturb = WTGsupplyCosts(o, data, WTG, stocVar, markMods)

switch lower(WTG.model)
    
    case 'haliade-6-150'
        
        %EDF CAPEX & OPEX model [EUR]%
        Cturb = 8460000;
                
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2018, 'EUR');
        
    case 'senvion-5-126'
        
        %EDF CAPEX & OPEX model [EUR]%
        Cturb = 7470000;
                        
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2018, 'EUR');
    
    case 'siemens-2.3-97'
        
        %Teesside Data [GBP]%
        Cturb = 3000000;
                        
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2010, 'EUR');    
        
    case 'siemens-3.6-107'
        
        %EDF CAPEX & OPEX model [EUR]%
        Cturb = 4550000;
                        
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2018, 'EUR');
    
    case {'siemens-3.6-120', 'siemens-4.0-120'}
        
        %EDF CAPEX & OPEX model [EUR]%
        Cturb = 5550000;
                        
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2018, 'EUR');
    
    case 'siemens-6-154'
        
        %adj. from Navitus Bay tender [EUR]%
        Cturb = 7797100;
                        
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2015, 'EUR');
        
    case 'siemens-7-154'
        
        %Navitus Bay tender [EUR]%
        Cturb = 8093700;
                                
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2015, 'EUR');
        
    case {'vestas-3.3-112', 'vestas-3.45-112'}
        
        %EDF CAPEX & OPEX model [EUR]%
        Cturb = 3970000;
                                
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2018, 'EUR');
        
    case {'vestas-8-164', 'vestas-8.25-164'}
        
        %Navitus Bay tender [EUR]%
        Cturb = 9714300;
                                
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, 2015, 'EUR');
        
    otherwise
        
        %default cost value%
        Cturb = data.WTG.cSpecDef*WTG.cap;
        
        %apply CPI inflation modifier and currency conversion%
        Cturb = Cturb * costScalingFactor(o, data, data.WTG.yearRef, data.WTG.currDef);
        
end

%apply any stochastic and market modifiers and learning effect to WTG cost%
Cturb = Cturb * scenarioModifier('WTG.cost', stocVar, markMods)* learningEffect(o.OWF.nWTG, data.WTG.Nref, data.WTG.LRman);