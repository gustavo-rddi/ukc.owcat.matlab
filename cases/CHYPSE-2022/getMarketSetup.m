function [projMods, techMods, markMods] = getMarketSetup(ExcelFile, year, scenario)

projMods = []; techMods = []; markMods = [];

%----TURBINE-TECHNOLOGY---------------------------------------------------%

cTurbSupply = getMarketData(ExcelFile, year, scenario, 'cTurb');
cWTGmon = getMarketData(ExcelFile, year, scenario, 'cWTGmon');
cWTGmaint = getMarketData(ExcelFile, year, scenario, 'cWTGmaint');

hInstTurb = getMarketData(ExcelFile, year, scenario, 'hInstTurb');
vMaxInst = getMarketData(ExcelFile, year, scenario, 'vMaxInst');

fAvailWTG = getMarketData(ExcelFile, year, scenario, 'fAvailWTG');

nOper = getMarketData(ExcelFile, year, scenario, 'nOper');

techMods{end+1} = {'WTG.hInstall', hInstTurb, 'h'};
techMods{end+1} = {'WTG.vMaxInst', vMaxInst, 'm/s'};
techMods{end+1} = {'WTG.cSpecDef', cTurbSupply, '€/kW'};
techMods{end+1} = {'WTG.fAvail', fAvailWTG, '-'};

techMods{end+1} = {'WTG.nOper', nOper, '-'};

% markMods{end+1} = {'OM.turbInsp', cWTGmon, '-', 'rel'};
% markMods{end+1} = {'OM.turbMaint', cWTGmaint, '-', 'rel'};

%----FOUNDATION-TECHNOLOGY------------------------------------------------%

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

hDriveMP = getMarketData(ExcelFile, year, scenario, 'hDriveMP');
hDrillMP = getMarketData(ExcelFile, year, scenario, 'hDrillMP');
hInstTP = getMarketData(ExcelFile, year, scenario, 'hInstTP');

techMods{end+1} = {'MP.hInstall', hDriveMP, 'h'};
techMods{end+1} = {'MP.dhDrill', hDrillMP-hDriveMP, 'h'};
techMods{end+1} = {'TP.hInstall', hInstTP, 'h'};

hInstJKT = getMarketData(ExcelFile, year, scenario, 'hInstJKT');
hDrivePP = getMarketData(ExcelFile, year, scenario, 'hDrivePP');
hDrillPP = getMarketData(ExcelFile, year, scenario, 'hDrillPP');

techMods{end+1} = {'sJKT.hInstall', hInstJKT, 'h'};
techMods{end+1} = {'PP.hInstall', hDrivePP, 'h'};
techMods{end+1} = {'PP.dhDrill', hDrillPP-hDrivePP, 'h'};

%----ELECTRICAL-TECHNOLOGY------------------------------------------------%

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