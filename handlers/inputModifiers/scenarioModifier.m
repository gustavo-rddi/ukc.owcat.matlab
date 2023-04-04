function modVal = scenarioModifier(mod, stocVar, markMods)

%default%
modVal = 1;

if isNestedField(stocVar, mod)
    modVal = modVal * getNestedField(stocVar, mod);
end

if isNestedField(markMods, mod)
    modVal = modVal * getNestedField(markMods, mod);
end