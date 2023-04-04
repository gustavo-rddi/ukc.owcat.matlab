function Claunch = semiSubLaunchingCosts(o, data, nSSinstall, mode, stocVar, markMods)

objType = 'semi';

hLaunch = data.(objType).hLaunch;

if strcmpi(mode, 'decom')
    
    %decommissioning modifiers%
    hLaunch = hLaunch * (1 + data.(objType).fDecom);

end

if isfield(data.(objType), 'LRinst')

    %apply learning-by-doing effects where available%
    hLaunch = hLaunch * learningEffect(nSSinstall, data.(objType).Nref, data.(objType).LRinst);

end

Claunch = data.equip.(data.semi.launch) * hLaunch * nSSinstall;

%apply CPI inflation modifier and currency conversion%
Claunch = Claunch * costScalingFactor(o, data, data.vessel.yrRef, data.vessel.curr);