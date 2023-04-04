function [o, data] = OWCATcore(o, data, projMods, techMods, markMods)

%load specifications and apply any modifiers%
[o, data] = loadSpecifications(o, data, projMods, techMods);

%generate structure to contain market modifiers% 
markMods = generateMarketModifierStructure(markMods);

%setup environment for stochastic analysis% 
stocVar = generateStochasticModifiers(o, data, 'setup');

%design offshore wind farm%
o = designOffshoreWindFarm(o, data);

%initialise cost vectors%
o = initialiseCostVectors(o);

%procurement requirements%
o = componentProcurement(o, data);

for i = 1 : stocVar.nSamples + 1
    
    
    %determine masses of offshore wind structures%
    oCase = offshoreStructuralMasses(o, data, stocVar, markMods);
            
    %determine wind farm procurement and installation plan%
    oCase = vesselCharterPlanning(oCase, data, stocVar, markMods);
    
    %design wind farm components%
    oCase = calculateYield(oCase, data, stocVar, markMods);
    
    %cost wind farm components%
    oCase = calculateCAPEX(oCase, data, stocVar, markMods);
    oCase = calculateOPEX(oCase, data, stocVar, markMods);
    oCase = calculateDECEX(oCase, data, stocVar, markMods);
    
    %evaluate financial performance%
    oCase = calculateLCOEvalues(oCase, data, stocVar, markMods);
       
    %calculate cash-flow based CAPEX/OPEX values%
    oCase = updateProjectCosts(oCase, data, stocVar, markMods);
   
    oCase = calculateProjectReturns(oCase, data, stocVar, markMods);
    
    switch upper(o.OWF.loc);
    
       case 'FR'; oCase = calculateSubsidyFR(oCase, data, stocVar, markMods);
       case 'UK'; oCase = calculateSubsidyUK(oCase, data, stocVar, markMods);
        
    end
    
    if ~strcmpi(o.runMode, 'stoc')
   
        %display financial results%
        displayFinancialResults(oCase, data, 'single');
        
        %return base case%
        o = oCase; break;
        
    else
    
        if i == 1
            
            %base case%
            oRef = oCase;
            
        elseif i == 2
        
            oStoc = initialiseStochastics(oRef, oCase, data, stocVar);
            
        else
            
            %combine data from stochastic cases%
            oStoc = aggregateCases(oStoc, oCase, i-1);
            
        end
            
        %generate next set of stochastic multipliers%
        stocVar = generateStochasticModifiers(o, data, 'uncorrelated', stocVar);
        
        if (i > 1) && (rem(i-1, stocVar.nDisp) == 0)
            
            %display progress of stochastics%
            displayStochasticResults(oStoc, data, i-1);

        end
        
        if i == stocVar.nSamples + 1
           
            %final output%
            o = oStoc;
            
        end
        
    end
    
end