function [projMods, techMods, markMods] = getCHypSEmarketSetup(ExcelFile, year)

projMods = []; techMods = []; markMods = [];

%----TURBINE-TECHNOLOGY---------------------------------------------------%

cTurbSupply = getCHypSEmarketData(ExcelFile, year, 'cTurb');
cWTGmon = getCHypSEmarketData(ExcelFile, year, 'cWTGmon');
cWTGmaint = getCHypSEmarketData(ExcelFile, year, 'cWTGmaint');

hInstTurb = getCHypSEmarketData(ExcelFile, year, 'hInstTurb');
vMaxInst = getCHypSEmarketData(ExcelFile, year, 'vMaxInst');

fAvailWTG = getCHypSEmarketData(ExcelFile, year, 'fAvailWTG');

nOper = getCHypSEmarketData(ExcelFile, year, 'nOper');

cWTGmon = getCHypSEmarketData(ExcelFile, year, 'cWTGmon');
cWTGmaint = getCHypSEmarketData(ExcelFile, year, 'cWTGmaint');

techMods{end+1} = {'WTG.hInstall', hInstTurb, 'h'};
techMods{end+1} = {'WTG.vMaxInst', vMaxInst, 'm/s'};
techMods{end+1} = {'WTG.cSpecDef', cTurbSupply, '€/kW'};
techMods{end+1} = {'WTG.fAvail', fAvailWTG, '-'};

techMods{end+1} = {'WTG.nOper', nOper, '-'};

markMods{end+1} = {'OM.turbInsp', cWTGmon, '-', 'rel'};
markMods{end+1} = {'OM.turbMaint', cWTGmaint, '-', 'rel'};

%----FOUNDATION-TECHNOLOGY------------------------------------------------%

fMassMP = getCHypSEmarketData(ExcelFile, year, 'fMassMP');
fMassTP = getCHypSEmarketData(ExcelFile, year, 'fMassTP');

cManMP = getCHypSEmarketData(ExcelFile, year, 'cManMP');
cManTP = getCHypSEmarketData(ExcelFile, year, 'cManTP');

% cSecSteelMP = getCHypSEmarketData(ExcelFile, year, 'cSecSteelMP');
% cFitMP = getCHypSEmarketData(ExcelFile, year, 'cFitMP');
  
fMassJKT = getCHypSEmarketData(ExcelFile, year, 'fMassJKT');
nPP = getCHypSEmarketData(ExcelFile, year, 'nPP');

cManJKT = getCHypSEmarketData(ExcelFile, year, 'cManJKT');
cManPP = getCHypSEmarketData(ExcelFile, year, 'cManPP');

% cSecSteelJKT = getCHypSEmarketData(ExcelFile, year, 'cSecSteelJKT');
% cFitJKT = getCHypSEmarketData(ExcelFile, year, 'cFitJKT');

fMassSS = getCHypSEmarketData(ExcelFile, year, 'fMassSS');

cManSS = getCHypSEmarketData(ExcelFile, year, 'cManSS');
nMoor = getCHypSEmarketData(ExcelFile, year, 'nMoor');

techMods{end+1} = {'MP.cSteel', cManMP, '¤/t'};
techMods{end+1} = {'TP.cSteel', cManTP, '¤/t'};

% techMods {end+1} = {'MP.cSecSteel', cSecSteelMP, '-'};
% techMods {end+1} = {'MP.cFit', cFitMP, '-'};

markMods{end+1} = {'MP.mass', fMassMP, '-', 'rel'};
markMods{end+1} = {'TP.mass', fMassTP, '-', 'rel'};
      
techMods{end+1} = {'sJKT.cSteel', cManJKT, '¤/t'};
techMods{end+1} = {'hJKT.cSteel', cManJKT, '¤/t'};
techMods{end+1} = {'sJKT.nPP', nPP};
techMods{end+1} = {'PP.cSteel', cManPP, '¤/t'};

% techMods {end+1} = {'sJKT.cSecSteel', cSecSteelJKT, '-'};
% techMods {end+1} = {'hJKT.cSecSteel', cSecSteelJKT, '-'};
% techMods {end+1} = {'sJKT.cFit', cFitJKT, '-'};
% techMods {end+1} = {'hJKT.cFit', cFitJKT, '-'};

markMods{end+1} = {'sJKT.mass', fMassJKT, '-', 'rel'};
markMods{end+1} = {'hJKT.mass', fMassJKT, '-', 'rel'};
markMods{end+1} = {'PP.mass', fMassMP, '-', 'rel'};

techMods{end+1} = {'semi.cSteel', cManSS, '¤/t'};
techMods{end+1} = {'semi.nMoor', nMoor};

markMods{end+1} = {'SS.mass', fMassSS, '-', 'rel'};

hDriveMP = getCHypSEmarketData(ExcelFile, year, 'hDriveMP');
hDrillMP = getCHypSEmarketData(ExcelFile, year, 'hDrillMP');
hInstTP = getCHypSEmarketData(ExcelFile, year, 'hInstTP');

techMods{end+1} = {'MP.hInstall', hDriveMP, 'h'};
techMods{end+1} = {'MP.dhDrill', hDrillMP-hDriveMP, 'h'};
techMods{end+1} = {'TP.hInstall', hInstTP, 'h'};

hInstJKT = getCHypSEmarketData(ExcelFile, year, 'hInstJKT');
hDrivePP = getCHypSEmarketData(ExcelFile, year, 'hDrivePP');
hDrillPP = getCHypSEmarketData(ExcelFile, year, 'hDrillPP');

techMods{end+1} = {'sJKT.hInstall', hInstJKT, 'h'};
techMods{end+1} = {'PP.hInstall', hDrivePP, 'h'};
techMods{end+1} = {'PP.dhDrill', hDrillPP-hDrivePP, 'h'};

%----ELECTRICAL-TECHNOLOGY------------------------------------------------%

cElecHVAC = getCHypSEmarketData(ExcelFile, year, 'cElecHVAC');
cElecHVDC = getCHypSEmarketData(ExcelFile, year, 'cElecHVDC');
cCables = getCHypSEmarketData(ExcelFile, year, 'cCables');

markMods{end+1} = {'HVAC.cost', cElecHVAC, '-', 'rel'};
markMods{end+1} = {'HVDC.cost', cElecHVDC, '-', 'rel'};
markMods{end+1} = {'cables.cost', cCables, '-', 'rel'};

%----FINANCING------------------------------------------------------------%

IRReq = getCHypSEmarketData(ExcelFile, year, 'IRReq');
cDebt = getCHypSEmarketData(ExcelFile, year, 'cDebt');
EURIBOR = getCHypSEmarketData(ExcelFile, year, 'EURIBOR');
fDebtMax = getCHypSEmarketData(ExcelFile, year, 'fDebtMax');
targDSCR = getCHypSEmarketData(ExcelFile, year, 'targDSCR');
fCont = getCHypSEmarketData(ExcelFile, year, 'fCont');
fCAR = getCHypSEmarketData(ExcelFile, year, 'fInsCAR');
fDSU = getCHypSEmarketData(ExcelFile, year, 'fInsDSU');
fPD = getCHypSEmarketData(ExcelFile, year, 'fInsPD');
fBI = getCHypSEmarketData(ExcelFile, year, 'fInsBI');

projMods{end+1} = {'finance.MARR', IRReq, '-'};
projMods{end+1} = {'finance.iDebtCon', EURIBOR+cDebt/1e4, '-'};
projMods{end+1} = {'finance.iDebtRe', EURIBOR+cDebt/1e4, '-'};

techMods{end+1} = {'econ.fDebtMax', fDebtMax, '-'};
techMods{end+1} = {'econ.DSCRtarg', targDSCR};
techMods{end+1} = {'econ.fComm', cDebt/1e4, '-'};
techMods{end+1} = {'econ.contCon', fCont, '-'};
techMods{end+1} = {'econ.contOp', 0 , '-'};
techMods{end+1} = {'econ.fInsCAR', fCAR, '-'};
techMods{end+1} = {'econ.fInsDSU', fDSU, '-'};
techMods{end+1} = {'econ.fInsPD', fPD, '-'};
techMods{end+1} = {'econ.fInsBI', fBI, '-'};