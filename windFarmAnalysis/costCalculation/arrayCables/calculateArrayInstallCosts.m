function o = calculateArrayInstallCosts(o, data, stocVar, markMods)

%determine number of sections to install%
nSectInstall = sum(o.proc.arrayCable.nSupply);

%remove sections for OTMs integrated with WTGs%
if strcmpi(o.design.expConf, 'OTM') && o.OWF.fndShare
    nSectInstall = nSectInstall - o.OWF.nOSS;
end

%determine overhead costs for array cable installation (adj. to ref. year)%
Coverhead = arrayInstallOverheadCosts(o, data, nSectInstall, stocVar, markMods);

%calculate cost of pre-laying activities%
Cprelay = cablePreLayingCosts(o, data, o.OWF.lArrayLay*scenarioModifier('array.lCable', stocVar, markMods), stocVar, markMods);

%determine charter times for cable laying and burial%
[~, ~, Cvessels] = postLayBurialModel(o, data, o.OWF.lArrayLay*scenarioModifier('array.lCable', stocVar, markMods), o.WTG, 'array', nSectInstall, stocVar, markMods);

[~, Cterm] = cableTermination(o, data, 'array', nSectInstall, stocVar, markMods);

%sum array cable installation costs%
o.CAPEX.real.arrayInstall = o.CAPEX.real.arrayInstall + Cprelay + Cvessels + Cterm + Coverhead;

for i = 1 : numel(o.vessels.arrayInst.type)
    
    %add vessel mobilisation costs to installation total%
    o.CAPEX.real.arrayInstall = o.CAPEX.real.arrayInstall + vesselMobilisationCost(o, data, o.vessels.arrayInst.type{i}, stocVar, markMods) * o.vessels.arrayInst.nVesMob(i);
    
end