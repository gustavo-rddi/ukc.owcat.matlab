function o = arrayCableInstallation(o, data, stocVar, markMods)

%determine number of sections to install%
nSectInstall = sum(o.proc.arrayCable.nSupply);

%remove sections for OTMs integrated with WTGs%
if strcmpi(o.design.expConf, 'OTM') && o.OWF.fndShare
    nSectInstall = nSectInstall - o.OWF.nOSS;
end

%determine charter times for cable laying and burial%
[hLay, hBury, ~] = postLayBurialModel(o, data, o.OWF.lArrayLay*scenarioModifier('array.lCable', stocVar, markMods), o.WTG, 'array', nSectInstall, stocVar, markMods);

%add vessels to WTG installation requirements%
o = addToVesselRequirements(o, data, 'arrayInst', 'CLV', 1, hLay, true);
o = addToVesselRequirements(o, data, 'arrayInst', 'OCV', 1, hBury, true);

[hTerm, ~] = cableTermination(o, data, 'array', nSectInstall, stocVar, markMods);

%add termination crew to installation requirements%
o = addToCrewRequirements(o, data, 'arrayInst', 'term', hTerm);