function [projMods, techMods, markMods] = generateEquityModifiers(ExcelFile, site, scenario, year)

projMods = []; techMods = []; markMods = [];

%----SITE-SPECIFICATIONS--------------------------------------------------%

capOWF = getSiteSpecs(ExcelFile, site, 2015, scenario, 'cap');
dWater = getSiteSpecs(ExcelFile, site, 2015, scenario, 'dWater');
dShore = getSiteSpecs(ExcelFile, site, 2015, scenario, 'dShore');
vMean = getSiteSpecs(ExcelFile, site, 2015, scenario, 'vMean');

projMods{end+1} = {'zone.cap', capOWF, 'MW'};
projMods{end+1} = {'zone.dWater', dWater, 'm'};
projMods{end+1} = {'zone.dLandfall', dShore, 'km'};
projMods{end+1} = {'zone.dPortCon', dShore, 'km'};
projMods{end+1} = {'zone.dPortOM', dShore, 'km'};
projMods{end+1} = {'zone.vWind', vMean, 'm/s'};

sigWind = getSiteData(ExcelFile, site, 2015, scenario, 'uncwind');

cDev = getMarketData(ExcelFile, 2015, scenario, 'cDev');
cGeo = getMarketData(ExcelFile, 2015, scenario, 'cGeo');
cMet = getMarketData(ExcelFile, 2015, scenario, 'cMet');

projMods{end+1} = {'OWF.sigWind', sigWind, '-'};

markMods{end+1} = {'dev.staff', cDev, '-', 'rel'};
markMods{end+1} = {'dev.geotech', cGeo, '-', 'rel'};
markMods{end+1} = {'dev.met', cMet, '-', 'rel'};

%----TURBINE-TECHNOLOGY---------------------------------------------------%

Pturb = getMarketData(ExcelFile, 2015, scenario, 'Pturb');
dRot = getMarketData(ExcelFile, 2015, scenario, 'dRot');

cTurbSupply = getMarketData(ExcelFile, 2015, scenario, 'cTurb');
cWTGmon = getMarketData(ExcelFile, 2015, scenario, 'cWTGmon');
cWTGmaint = getMarketData(ExcelFile, 2015, scenario, 'cWTGmaint');

hInstTurb = getMarketData(ExcelFile, 2015, scenario, 'hInstTurb');
vMaxInst = getMarketData(ExcelFile, 2015, scenario, 'vMaxInst');

fAvailWTG = getMarketData(ExcelFile, 2015, scenario, 'fAvailWTG');

nOper = getMarketData(ExcelFile, 2015, scenario, 'nOper');

projMods{end+1} = {'zone.WTGmodel', {sprintf('generic-%4.2f-%d', Pturb, dRot)}};

techMods{end+1} = {'WTG.hInstall', hInstTurb, 'h'};
techMods{end+1} = {'WTG.vMaxInst', vMaxInst, 'm/s'};
techMods{end+1} = {'WTG.cSpecDef', cTurbSupply, '€/kW'};
techMods{end+1} = {'WTG.fAvail', fAvailWTG, '-'};

techMods{end+1} = {'WTG.nOper', nOper, '-'};

markMods{end+1} = {'OM.turbInsp', cWTGmon, '-', 'rel'};
markMods{end+1} = {'OM.turbMaint', cWTGmaint, '-', 'rel'};

%----FOUNDATION-TECHNOLOGY------------------------------------------------%

fndType = getSiteData(ExcelFile, site, 2015, scenario, 'fndType');

if strcmpi(fndType, 'floater');
    projMods{end+1} = {'zone.fndType', {'semisub'}};
else
    projMods{end+1} = {'zone.fndType', {lower(fndType)}};
end

fMassMP = getMarketData(ExcelFile, 2015, scenario, 'fMassMP');
fMassTP = getMarketData(ExcelFile, 2015, scenario, 'fMassTP');

cManMP = getMarketData(ExcelFile, 2015, scenario, 'cManMP');
cManTP = getMarketData(ExcelFile, 2015, scenario, 'cManTP');
  
fMassJKT = getMarketData(ExcelFile, 2015, scenario, 'fMassJKT');
nPP = getMarketData(ExcelFile, 2015, scenario, 'nPP');

cManJKT = getMarketData(ExcelFile, 2015, scenario, 'cManJKT');
cManPP = getMarketData(ExcelFile, 2015, scenario, 'cManPP');

fMassSS = getMarketData(ExcelFile, 2015, scenario, 'fMassSS');

cManSS = getMarketData(ExcelFile, 2015, scenario, 'cManSS');
nMoor = getMarketData(ExcelFile, 2015, scenario, 'nMoor');

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
    
        hInstMP = getSiteData(ExcelFile, site, 2015, scenario, 'hInstMP');
        hInstTP = getSiteData(ExcelFile, site, 2015, scenario, 'hInstTP');
        
        techMods{end+1} = {'MP.hInstall', hInstMP, 'h'};
        techMods{end+1} = {'TP.hInstall', hInstTP, 'h'};
        
    case 'jacket'
        
        hInstJKT = getSiteData(ExcelFile, site, 2015, scenario, 'hInstJKT');
        hInstPP = getSiteData(ExcelFile, site, 2015, scenario, 'hInstPP');
                
        techMods{end+1} = {'sJKT.hInstall', hInstJKT, 'h'};
        techMods{end+1} = {'PP.hInstall', hInstPP, 'h'};
        
    case 'floater'
        
        hInstSS = getSiteData(ExcelFile, site, 2015, scenario, 'hInstSS');
        hInstMoor = getSiteData(ExcelFile, site, 2015, scenario, 'hInstMoor');
                
        techMods{end+1} = {'semi.hHookUp', hInstSS, 'h'};
        techMods{end+1} = {'drag.hInstall', hInstMoor, 'h'};
        
end

%----ELECTRICAL-TECHNOLOGY------------------------------------------------%

expType = getSiteData(ExcelFile, site, 2015, scenario, 'expType');

projMods{end+1} = {'OWF.expType', expType};

Varray = getSiteData(ExcelFile, site, 2015, scenario, 'Varray');

nOSS = getSiteData(ExcelFile, site, 2015, scenario, 'nOSS');
platTypeAC = getSiteData(ExcelFile, site, 2015, scenario, 'platTypeAC');
VexportAC = getSiteData(ExcelFile, site, 2015, scenario, 'VexportAC');
osComp = getSiteData(ExcelFile, site, 2015, scenario, 'osComp');

nConv = getSiteData(ExcelFile, site, 2015, scenario, 'nConv');
VexportDC = getSiteData(ExcelFile, site, 2015, scenario, 'VexportDC');

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

cElecHVAC = getMarketData(ExcelFile, 2015, scenario, 'cElecHVAC');
cElecHVDC = getMarketData(ExcelFile, 2015, scenario, 'cElecHVDC');
cCables = getMarketData(ExcelFile, 2015, scenario, 'cCables');

markMods{end+1} = {'HVAC.cost', cElecHVAC, '-', 'rel'};
markMods{end+1} = {'HVDC.cost', cElecHVDC, '-', 'rel'};
markMods{end+1} = {'cables.cost', cCables, '-', 'rel'};

%----FINANCING------------------------------------------------------------%

IRReq = getMarketData(ExcelFile, 2015, scenario, 'IRReq');
cDebt = getMarketData(ExcelFile, 2015, scenario, 'cDebt');
EURIBOR = getMarketData(ExcelFile, 2015, scenario, 'EURIBOR');
fDebtMax = getMarketData(ExcelFile, 2015, scenario, 'fDebtMax');
targDSCR = getMarketData(ExcelFile, 2015, scenario, 'targDSCR');
fCont = getMarketData(ExcelFile, 2015, scenario, 'fCont');
fDSU = getMarketData(ExcelFile, 2015, scenario, 'fInsDSU');
fBI = getMarketData(ExcelFile, 2015, scenario, 'fInsBI');

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