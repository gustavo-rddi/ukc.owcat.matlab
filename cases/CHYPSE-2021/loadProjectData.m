function projMods = loadProjectData(ExcelFile, projMods, caseNum)

ExcelSheet = ExcelFile.Sheets.Item('Projects');

colCase = excelColumnOffset('E', caseNum);

projCap = ExcelSheet.Range([colCase, '5']).Value;
Azone = ExcelSheet.Range([colCase, '6']).Value;
dWater = ExcelSheet.Range([colCase, '7']).Value;
vWind = ExcelSheet.Range([colCase, '8']).Value;
dPortCon = ExcelSheet.Range([colCase, '9']).Value;
dPortOM = ExcelSheet.Range([colCase, '10']).Value;
dLandfall = ExcelSheet.Range([colCase, '11']).Value;
lOnshore = ExcelSheet.Range([colCase, '12']).Value;

if ischar(dPortOM) && strcmpi(dPortOM, 'offshore')
    dPortOM = 10;
end

capTurb = ExcelSheet.Range([colCase, '13']).Value;
dRotor = ExcelSheet.Range([colCase, '14']).Value;

fSpace = sqrt(Azone*capTurb/projCap)/(dRotor/1000);

turbModel = sprintf('generic-%4.2f-%3d', capTurb, dRotor);

fndType = lower(ExcelSheet.Range([colCase, '15']).Value);

soilType = lower(ExcelSheet.Range([colCase, '16']).Value);

switch soilType
    
    case 'simple'; fDrill = 0;
    case 'medium'; fDrill = 50;
    case 'complex'; fDrill = 100;
        
end

expType = upper(ExcelSheet.Range([colCase, '17']).Value);
platType = upper(ExcelSheet.Range([colCase, '18']).Value);

nOSS = ExcelSheet.Range([colCase, '19']).Value;
nConv = ExcelSheet.Range([colCase, '20']).Value;

osComp = strcmpi(ExcelSheet.Range([colCase, '21']).Value, 'Yes');
lfComp = strcmpi(ExcelSheet.Range([colCase, '22']).Value, 'Yes');

Varray = ExcelSheet.Range([colCase, '23']).Value;
Vexport = ExcelSheet.Range([colCase, '24']).Value;

projMods{end+1} = {'zone.cap', projCap, 'MW'};
projMods{end+1} = {'zone.dWater', dWater, 'm'};
projMods{end+1} = {'zone.fDrill', fDrill, '%'};   
projMods{end+1} = {'zone.vWind', vWind, 'm/s'};
projMods{end+1} = {'zone.dLandfall', dLandfall, 'km'};
projMods{end+1} = {'OWF.lOnshore', lOnshore, 'km'};
projMods{end+1} = {'zone.dPortCon', dPortCon, 'km'};
projMods{end+1} = {'zone.dPortOM', dPortOM, 'km'};

projMods{end+1} = {'zone.fndType', {fndType}};
projMods{end+1} = {'zone.WTGmodel', {turbModel}};
projMods{end+1} = {'design.fSpace', fSpace};

projMods{end+1} = {'OWF.expType', {expType}};
projMods{end+1} = {'design.expConf', {platType}};
projMods{end+1} = {'OWF.nOSS', nOSS};
projMods{end+1} = {'OWF.nConv', nConv};
projMods{end+1} = {'design.osComp', osComp};
projMods{end+1} = {'design.lfComp', lfComp};
projMods{end+1} = {'design.Varray', Varray, 'kV'};
projMods{end+1} = {'design.Vexport', Vexport, 'kV'};