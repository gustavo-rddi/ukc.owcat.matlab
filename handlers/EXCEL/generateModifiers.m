function [projMods, techMods, markMods] = generateModifiers(ExcelFile, site, scenario, year)

projMods = []; techMods = []; markMods = [];

%----SITE-SPECIFICATIONS--------------------------------------------------%

capOWF = getSiteSpecs(ExcelFile, site, year, scenario, 'cap');
dWater = getSiteSpecs(ExcelFile, site, year, scenario, 'dWater');
dShore = getSiteSpecs(ExcelFile, site, year, scenario, 'dShore');
vMean = getSiteSpecs(ExcelFile, site, year, scenario, 'vMean');

projMods{end+1} = {'zone.cap', capOWF, 'MW'};
projMods{end+1} = {'zone.dWater', dWater, 'm'};
projMods{end+1} = {'zone.dLandfall', dShore, 'km'};
projMods{end+1} = {'zone.dPortCon', dShore, 'km'};
projMods{end+1} = {'zone.dPortOM', dShore, 'km'};
projMods{end+1} = {'zone.vWind', vMean, 'm/s'};

sigWind = getSiteData(ExcelFile, site, year, scenario, 'uncwind');

cDev = getMarketData(ExcelFile, year, scenario, 'cDev');
cGeo = getMarketData(ExcelFile, year, scenario, 'cGeo');
cMet = getMarketData(ExcelFile, year, scenario, 'cMet');

projMods{end+1} = {'OWF.sigWind', sigWind, '-'};

markMods{end+1} = {'dev.staff', cDev, '-', 'rel'};
markMods{end+1} = {'dev.geotech', cGeo, '-', 'rel'};
markMods{end+1} = {'dev.met', cMet, '-', 'rel'};

%----TURBINE-TECHNOLOGY---------------------------------------------------%

Pturb = getMarketData(ExcelFile, year, scenario, 'Pturb');
dRot = getMarketData(ExcelFile, year, scenario, 'dRot');

cTurbSupply = getMarketData(ExcelFile, year, scenario, 'cTurb');
cWTGmon = getMarketData(ExcelFile, year, scenario, 'cWTGmon');
cWTGmaint = getMarketData(ExcelFile, year, scenario, 'cWTGmaint');

hInstTurb = getMarketData(ExcelFile, year, scenario, 'hInstTurb');
vMaxInst = getMarketData(ExcelFile, year, scenario, 'vMaxInst');

fAvailWTG = getMarketData(ExcelFile, year, scenario, 'fAvailWTG');

nOper = getMarketData(ExcelFile, year, scenario, 'nOper');

projMods{end+1} = {'zone.WTGmodel', {sprintf('generic-%4.2f-%d', Pturb, dRot)}};

techMods{end+1} = {'WTG.hInstall', hInstTurb, 'h'};
techMods{end+1} = {'WTG.vMaxInst', vMaxInst, 'm/s'};
techMods{end+1} = {'WTG.cSpecDef', cTurbSupply, '€/kW'};
techMods{end+1} = {'WTG.fAvail', fAvailWTG, '-'};

techMods{end+1} = {'WTG.nOper', nOper, '-'};

markMods{end+1} = {'OM.turbInsp', cWTGmon, '-', 'rel'};
markMods{end+1} = {'OM.turbMaint', cWTGmaint, '-', 'rel'};

%----FOUNDATION-TECHNOLOGY------------------------------------------------%

fndType = getSiteData(ExcelFile, site, year, scenario, 'fndType');

if strcmpi(fndType, 'floater');
    projMods{end+1} = {'zone.fndType', {'semisub'}};
else
    projMods{end+1} = {'zone.fndType', {lower(fndType)}};
end

fMassMP = getMarketData(ExcelFile, year, scenario, 'fMassMP');
fMassTP = getMarketData(ExcelFile, year, scenario, 'fMassTP');

cManMP = getMarketData(ExcelFile, year, scenario, 'cManMP');
cManTP = getMarketData(ExcelFile, year, scenario, 'cManTP');
  
fMassJKT = getMarketData(ExcelFile, year, scenario, 'fMassJKT');
nPP = getMarketData(ExcelFile, year, scenario, 'nPP');

cManJKT = getMarketData(ExcelFile, year, scenario, 'cManJKT');
cManPP = getMarketData(ExcelFile, year, scenario, 'cManPP');

fMassSS = getMarketData(ExcelFile, year, scenario, 'fMassSS');

cManSS = getMarketData(ExcelFile, year, scenario, 'cManSS');
nMoor = getMarketData(ExcelFile, year, scenario, 'nMoor');

techMods{end+1} = {'MP.cSteel', cManMP, '¤/t'};
techMods{end+1} = {'TP.cSteel', cManTP, '¤/t'};

markMods{end+1} = {'MP.mass', fMassMP, '-', 'rel'};
markMods{end+1} = {'TP.mass', fMassTP, '-', 'rel'};
      
techMods{end+1} = {'sJKT.cSteel', cManJKT, '¤/t'};
techMods{end+1} = {'hJKT.cSteel', cManJKT, '¤/t'};
techMods{end+1} = {'sJKT.nPP', nPP};
techMods{end+1} = {'PP.cSteel', cManPP, '¤/t'};

markMods{end+1} = {'sJKT.mass', fMassJKT, '-', 'rel'};
markMods{end+1} = {'hJKT.mass', fMassJKT, '-', 'rel'};
markMods{end+1} = {'PP.mass', fMassMP, '-', 'rel'};

techMods{end+1} = {'semi.cSteel', cManSS, '¤/t'};
techMods{end+1} = {'semi.nMoor', nMoor};

markMods{end+1} = {'SS.mass', fMassSS, '-', 'rel'};

switch lower(fndType)

    case 'monopile'
    
        hInstMP = getSiteData(ExcelFile, site, year, scenario, 'hInstMP');
        hInstTP = getSiteData(ExcelFile, site, year, scenario, 'hInstTP');
        
        techMods{end+1} = {'MP.hInstall', hInstMP, 'h'};
        techMods{end+1} = {'TP.hInstall', hInstTP, 'h'};
        
    case 'jacket'
        
        hInstJKT = getSiteData(ExcelFile, site, year, scenario, 'hInstJKT');
        hInstPP = getSiteData(ExcelFile, site, year, scenario, 'hInstPP');
                
        techMods{end+1} = {'sJKT.hInstall', hInstJKT, 'h'};
        techMods{end+1} = {'PP.hInstall', hInstPP, 'h'};
        
    case 'floater'
        
        hInstSS = getSiteData(ExcelFile, site, year, scenario, 'hInstSS');
        hInstMoor = getSiteData(ExcelFile, site, year, scenario, 'hInstMoor');
                
        techMods{end+1} = {'semi.hHookUp', hInstSS, 'h'};
        techMods{end+1} = {'drag.hInstall', hInstMoor, 'h'};
        
end

%----ELECTRICAL-TECHNOLOGY------------------------------------------------%

expType = getSiteData(ExcelFile, site, year, scenario, 'expType');

projMods{end+1} = {'OWF.expType', expType};

Varray = getSiteData(ExcelFile, site, year, scenario, 'Varray');

nOSS = getSiteData(ExcelFile, site, year, scenario, 'nOSS');
platTypeAC = getSiteData(ExcelFile, site, year, scenario, 'platTypeAC');
VexportAC = getSiteData(ExcelFile, site, year, scenario, 'VexportAC');
osComp = getSiteData(ExcelFile, site, year, scenario, 'osComp');

nConv = getSiteData(ExcelFile, site, year, scenario, 'nConv');
VexportDC = getSiteData(ExcelFile, site, year, scenario, 'VexportDC');

projMods{end+1} = {'design.Varray', Varray, 'kV'};

if Varray > 33
    
    markMods{end+1} = {'array.lCable', -0.1, '-', 'rel'};
    
end    

switch upper(expType)
    
    case 'HVAC'
        
        projMods{end+1} = {'OWF.nOSS', nOSS};
        projMods{end+1} = {'design.expConf', platTypeAC};
        projMods{end+1} = {'design.Vexport', VexportAC, 'kV'};
        projMods{end+1} = {'design.osComp', osComp};
        
    case 'HVDC'
        
        projMods{end+1} = {'OWF.nOSS', nOSS};
        projMods{end+1} = {'design.expConf', 'VSC'};
        projMods{end+1} = {'design.Vcoll', VexportAC, 'kV'};
        projMods{end+1} = {'OWF.nConv', nConv};
        projMods{end+1} = {'design.Vexport', VexportDC, 'kV'};
        
end

cElecHVAC = getMarketData(ExcelFile, year, scenario, 'cElecHVAC');
cElecHVDC = getMarketData(ExcelFile, year, scenario, 'cElecHVDC');
cCables = getMarketData(ExcelFile, year, scenario, 'cCables');

markMods{end+1} = {'HVAC.cost', cElecHVAC, '-', 'rel'};
markMods{end+1} = {'HVDC.cost', cElecHVDC, '-', 'rel'};
markMods{end+1} = {'cables.cost', cCables, '-', 'rel'};

%----FINANCING------------------------------------------------------------%

IRReq = getMarketData(ExcelFile, year, scenario, 'IRReq');
cDebt = getMarketData(ExcelFile, year, scenario, 'cDebt');
EURIBOR = getMarketData(ExcelFile, year, scenario, 'EURIBOR');
fDebtMax = getMarketData(ExcelFile, year, scenario, 'fDebtMax');
targDSCR = getMarketData(ExcelFile, year, scenario, 'targDSCR');
fCont = getMarketData(ExcelFile, year, scenario, 'fCont');
fDSU = getMarketData(ExcelFile, year, scenario, 'fInsDSU');
fBI = getMarketData(ExcelFile, year, scenario, 'fInsBI');

projMods{end+1} = {'finance.MARR', IRReq, '-'};
projMods{end+1} = {'finance.iDebtCon', EURIBOR+cDebt/1e4, '-'};
projMods{end+1} = {'finance.iDebtRe', EURIBOR+cDebt/1e4, '-'};

techMods{end+1} = {'econ.fDebtMax', fDebtMax, '-'};
techMods{end+1} = {'econ.DSCRtarg', targDSCR};
techMods{end+1} = {'econ.fComm', cDebt/1e4, '-'};
techMods{end+1} = {'econ.contCon', fCont, '-'};
techMods{end+1} = {'econ.contOp', fCont/2, '-'};
techMods{end+1} = {'econ.fInsDSU', fDSU, '-'};
techMods{end+1} = {'econ.fInsBI', fBI, '-'};