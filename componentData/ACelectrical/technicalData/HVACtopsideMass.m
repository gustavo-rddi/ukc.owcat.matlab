function mHVACSS = HVACtopsideMass(capTrans, capComp, vExport)

%calculate equivalent capacity of substation%
capEq = capTrans + (2/3)*capComp;

%calculate mass from correlation%
mHVACSS = 399300 + 100.6*((capEq/1e6)^1.033)*((vExport/1e3)^0.7233);