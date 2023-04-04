function projMods = loadProjectData(ExcelFile, projMods, caseNum)

ExcelSheet = ExcelFile.Sheets.Item('Projects');

colCase = excelColumnOffset('E', caseNum);

projCap = ExcelSheet.Range([colCase, '5']).Value;
Azone = ExcelSheet.Range([colCase, '6']).Value;
fSpace0 = ExcelSheet.Range([colCase, '7']).Value;
dWater = ExcelSheet.Range([colCase, '8']).Value;
vWind = ExcelSheet.Range([colCase, '9']).Value;
%lWake = ExcelSheet.Range([colCase, '10']).Value;
dPortCon = ExcelSheet.Range([colCase, '10']).Value;
dPortOM = ExcelSheet.Range([colCase, '11']).Value;
dLandfall = ExcelSheet.Range([colCase, '12']).Value;
lOnshore = ExcelSheet.Range([colCase, '13']).Value;

if ischar(dPortOM) && strcmpi(dPortOM, 'offshore')
    dPortOM = 10;
end

capTurb = ExcelSheet.Range([colCase, '14']).Value;
dRotor = ExcelSheet.Range([colCase, '15']).Value;
mTopSide = ExcelSheet.Range([colCase, '16']).Value; %New variable

fSpace = min(sqrt(Azone*capTurb/projCap)/(dRotor/1000),fSpace0);

turbModel = sprintf('generic-%4.2f-%3d', capTurb, dRotor);

fndType =   lower(ExcelSheet.Range([colCase, '17']).Value);

soilType0 = lower(ExcelSheet.Range([colCase, '18']).Value);

switch soilType0
    
    case 'simple'; soilType = 0;   %New variable
    case 'medium'; soilType = 0.5; %New variable
    case 'complex'; soilType = 1;  %New variable
        
end
switch soilType0
    
    case 'simple'; fDrill = 0;
    case 'medium'; fDrill = 50;
    case 'complex'; fDrill = 100;
        
end

%fdnMass = ExcelSheet.Range([colCase, '18']).Value;
%compMass = ExcelSheet.Range([colCase, '19']).Value;

expType = upper(ExcelSheet.Range([colCase, '19']).Value);
platType = upper(ExcelSheet.Range([colCase, '20']).Value);

nOSS = ExcelSheet.Range([colCase, '21']).Value;
nConv = ExcelSheet.Range([colCase, '22']).Value;

osComp = strcmpi(ExcelSheet.Range([colCase, '23']).Value, 'Yes');
lfComp = strcmpi(ExcelSheet.Range([colCase, '24']).Value, 'Yes');

Varray = ExcelSheet.Range([colCase, '25']).Value;
Vexport = ExcelSheet.Range([colCase, '26']).Value;

yrOper = ExcelSheet.Range([colCase, '28']).Value;

% opex = ExcelSheet.Range([colCase, '29']).Value;

projMods{end+1} = {'zone.cap', projCap, 'MW'};
projMods{end+1} = {'zone.dWater', dWater, 'm'};
projMods{end+1} = {'zone.fDrill', fDrill, '%'};   
projMods{end+1} = {'zone.vWind', vWind, 'm/s'};
%projMods{end+1} = {'OWF.lWake', lWake, '%'};
projMods{end+1} = {'zone.dLandfall', dLandfall, 'km'};
projMods{end+1} = {'OWF.lOnshore', lOnshore, 'km'};
projMods{end+1} = {'zone.dPortCon', dPortCon, 'km'};
projMods{end+1} = {'zone.dPortOM', dPortOM, 'km'};

projMods{end+1} = {'zone.fndType', {fndType}};
projMods{end+1} = {'zone.soilType', soilType};   
projMods{end+1} = {'zone.WTGmodel', {turbModel}};
projMods{end+1} = {'zone.mTopSide', mTopSide, 't'};
projMods{end+1} = {'design.fSpace', fSpace};

projMods{end+1} = {'OWF.expType', {expType}};
projMods{end+1} = {'design.expConf', {platType}};
projMods{end+1} = {'OWF.nOSS', nOSS};
projMods{end+1} = {'OWF.nConv', nConv};
projMods{end+1} = {'design.osComp', osComp};
projMods{end+1} = {'design.lfComp', lfComp};
projMods{end+1} = {'design.Varray', Varray, 'kV'};
projMods{end+1} = {'design.Vexport', Vexport, 'kV'};

%projMods{end+1} = {'OWF.fdnMass', fdnMass, 't'};
%projMods{end+1} = {'OWF.compMass', compMass, 't'};
projMods{end+1} = {'OWF.yrOper', yrOper};
% projMods{end+1} = {'OWF.opex', opex, '€/day'};
