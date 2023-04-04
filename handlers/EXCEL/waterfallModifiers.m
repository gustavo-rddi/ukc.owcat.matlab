function [projMods, techMods, markMods] = waterfallModifiers(ExcelFile, site, scenario, yearMod, group)

projMods = []; techMods = []; markMods = [];

yearRef = yearMod - 5;

yearDev = yearRef;
yearTurb = yearRef;
yearFnd = yearRef;
yearElec = yearRef;
yearOM = yearRef;
yearSupply = yearRef;
yearFin = yearRef;

switch lower(group)
    
    case 'development'; yearDev = yearMod;
    case 'turbine'; yearTurb = yearMod;
    case 'foundation'; yearFnd = yearMod;
    case 'electrical'; yearElec = yearMod;
    case 'maintenance'; yearOM = yearMod;
    case 'supplychain'; yearSupply = yearMod;    
    case 'finance'; yearFin = yearMod;
        
end

%----SITE-SPECIFICATIONS--------------------------------------------------%

capOWF = getSiteSpecs(ExcelFile, site, yearSupply, scenario, 'cap');
dWater = getSiteSpecs(ExcelFile, site, yearSupply, scenario, 'dWater');
dShore = getSiteSpecs(ExcelFile, site, yearSupply, scenario, 'dShore');
vMean = getSiteSpecs(ExcelFile, site, yearSupply, scenario, 'vMean');

projMods{end+1} = {'zone.cap', capOWF, 'MW'};
projMods{end+1} = {'zone.dWater', dWater, 'm'};
projMods{end+1} = {'zone.dLandfall', dShore, 'km'};
projMods{end+1} = {'zone.dPortCon', dShore, 'km'};
projMods{end+1} = {'zone.dPortOM', dShore, 'km'};
projMods{end+1} = {'zone.vWind', vMean, 'm/s'};

sigWind = getSiteData(ExcelFile, site, yearDev, scenario, 'uncwind');

cDev = getMarketData(ExcelFile, yearDev, scenario, 'cDev');
cGeo = getMarketData(ExcelFile, yearDev, scenario, 'cGeo');
cMet = getMarketData(ExcelFile, yearDev, scenario, 'cMet');

projMods{end+1} = {'OWF.sigWind', sigWind, '-'};

markMods{end+1} = {'dev.staff', cDev, '-', 'rel'};
markMods{end+1} = {'dev.geotech', cGeo, '-', 'rel'};
markMods{end+1} = {'dev.met', cMet, '-', 'rel'};

%----TURBINE-TECHNOLOGY---------------------------------------------------%

Pturb = getMarketData(ExcelFile, yearTurb, scenario, 'Pturb');
dRot = getMarketData(ExcelFile, yearTurb, scenario, 'dRot');

cTurbSupply = getMarketData(ExcelFile, yearSupply, scenario, 'cTurb');
cWTGmon = getMarketData(ExcelFile, yearOM, scenario, 'cWTGmon');
cWTGmaint = getMarketData(ExcelFile, yearOM, scenario, 'cWTGmaint');

hInstTurb = getMarketData(ExcelFile, yearTurb, scenario, 'hInstTurb');
vMaxInst = getMarketData(ExcelFile, yearTurb, scenario, 'vMaxInst');

fAvailWTG = getMarketData(ExcelFile, yearOM, scenario, 'fAvailWTG');

nOper = getMarketData(ExcelFile, yearOM, scenario, 'nOper');

projMods{end+1} = {'zone.WTGmodel', {sprintf('generic-%4.2f-%d', Pturb, dRot)}};

techMods{end+1} = {'WTG.hInstall', hInstTurb, 'h'};
techMods{end+1} = {'WTG.vMaxInst', vMaxInst, 'm/s'};
techMods{end+1} = {'WTG.cSpecDef', cTurbSupply, '€/kW'};
techMods{end+1} = {'WTG.fAvail', fAvailWTG, '-'};

techMods{end+1} = {'WTG.nOper', nOper, '-'};

markMods{end+1} = {'OM.turbInsp', cWTGmon, '-', 'rel'};
markMods{end+1} = {'OM.turbMaint', cWTGmaint, '-', 'rel'};

%----FOUNDATION-TECHNOLOGY------------------------------------------------%

fndType = getSiteData(ExcelFile, site, yearFnd, scenario, 'fndType');

if strcmpi(fndType, 'floater');
    projMods{end+1} = {'zone.fndType', {'semisub'}};
else
    projMods{end+1} = {'zone.fndType', {lower(fndType)}};
end

fMassMP = getMarketData(ExcelFile, yearFnd, scenario, 'fMassMP');
fMassTP = getMarketData(ExcelFile, yearFnd, scenario, 'fMassTP');

cManMP = getMarketData(ExcelFile, yearSupply, scenario, 'cManMP');
cManTP = getMarketData(ExcelFile, yearSupply, scenario, 'cManTP');
  
fMassJKT = getMarketData(ExcelFile, yearFnd, scenario, 'fMassJKT');
nPP = getMarketData(ExcelFile, yearFnd, scenario, 'nPP');

cManJKT = getMarketData(ExcelFile, yearSupply, scenario, 'cManJKT');
cManPP = getMarketData(ExcelFile, yearSupply, scenario, 'cManPP');

fMassSS = getMarketData(ExcelFile, yearFnd, scenario, 'fMassSS');

cManSS = getMarketData(ExcelFile, yearSupply, scenario, 'cManSS');
nMoor = getMarketData(ExcelFile, yearFnd, scenario, 'nMoor');

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
    
        hInstMP = getSiteData(ExcelFile, site, yearFnd, scenario, 'hInstMP');
        hInstTP = getSiteData(ExcelFile, site, yearFnd, scenario, 'hInstTP');
        
        techMods{end+1} = {'MP.hInstall', hInstMP, 'h'};
        techMods{end+1} = {'TP.hInstall', hInstTP, 'h'};
        
    case 'jacket'
        
        hInstJKT = getSiteData(ExcelFile, site, yearFnd, scenario, 'hInstJKT');
        hInstPP = getSiteData(ExcelFile, site, yearFnd, scenario, 'hInstPP');
                
        techMods{end+1} = {'sJKT.hInstall', hInstJKT, 'h'};
        techMods{end+1} = {'PP.hInstall', hInstPP, 'h'};
        
    case 'floater'
        
        hInstSS = getSiteData(ExcelFile, site, yearFnd, scenario, 'hInstSS');
        hInstMoor = getSiteData(ExcelFile, site, yearFnd, scenario, 'hInstMoor');
                
        techMods{end+1} = {'semi.hHookUp', hInstSS, 'h'};
        techMods{end+1} = {'drag.hInstall', hInstMoor, 'h'};
        
end

%----ELECTRICAL-TECHNOLOGY------------------------------------------------%

expType = getSiteData(ExcelFile, site, yearElec, scenario, 'expType');

projMods{end+1} = {'OWF.expType', expType};

Varray = getSiteData(ExcelFile, site, yearElec, scenario, 'Varray');

nOSS = getSiteData(ExcelFile, site, yearElec, scenario, 'nOSS');
platTypeAC = getSiteData(ExcelFile, site, yearElec, scenario, 'platTypeAC');
VexportAC = getSiteData(ExcelFile, site, yearElec, scenario, 'VexportAC');
osComp = getSiteData(ExcelFile, site, yearElec, scenario, 'osComp');

nConv = getSiteData(ExcelFile, site, yearElec, scenario, 'nConv');
VexportDC = getSiteData(ExcelFile, site, yearElec, scenario, 'VexportDC');

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

cElecHVAC = getMarketData(ExcelFile, yearSupply, scenario, 'cElecHVAC');
cElecHVDC = getMarketData(ExcelFile, yearSupply, scenario, 'cElecHVDC');
cCables = getMarketData(ExcelFile, yearSupply, scenario, 'cCables');

markMods{end+1} = {'HVAC.cost', cElecHVAC, '-', 'rel'};
markMods{end+1} = {'HVDC.cost', cElecHVDC, '-', 'rel'};
markMods{end+1} = {'cables.cost', cCables, '-', 'rel'};

%----FINANCING------------------------------------------------------------%

IRReq = getMarketData(ExcelFile, yearFin, scenario, 'IRReq');
cDebt = getMarketData(ExcelFile, yearFin, scenario, 'cDebt');
EURIBOR = getMarketData(ExcelFile, yearFin, scenario, 'EURIBOR');
fDebtMax = getMarketData(ExcelFile, yearFin, scenario, 'fDebtMax');
targDSCR = getMarketData(ExcelFile, yearFin, scenario, 'targDSCR');
fCont = getMarketData(ExcelFile, yearFin, scenario, 'fCont');
fDSU = getMarketData(ExcelFile, yearDev, scenario, 'fInsDSU');
fBI = getMarketData(ExcelFile, yearOM, scenario, 'fInsBI');

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