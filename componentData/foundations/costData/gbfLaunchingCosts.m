function Claunch = gbfLaunchingCosts(o, data, nGBFinstall, mode, stocVar, markMods)

objType = 'gbf';

hLaunch = data.(objType).hLaunch;

if strcmpi(mode, 'decom')
    
    %decommissioning modifiers%
    hLaunch = hLaunch * (1 + data.(objType).fDecom);

end

if isfield(data.(objType), 'LRinst')

    %apply learning-by-doing effects where available%
    hLaunch = hLaunch * learningEffect(nGBFinstall, data.(objType).Nref, data.(objType).LRinst);

end

Claunch = data.equip.(data.gbf.launch) * hLaunch * nGBFinstall;

%apply CPI inflation modifier and currency conversion%
Claunch = Claunch * costScalingFactor(o, data, data.vessel.yrRef, data.vessel.curr);