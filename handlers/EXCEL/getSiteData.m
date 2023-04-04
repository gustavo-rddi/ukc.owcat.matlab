function data = getSiteData(ExcelFile, siteType, year, scenario, field)

%get requested EXCEL worksheet%
ExcelSheet = ExcelFile.Sheets.Item(strcat('Type', siteType));

if year == 2015
    
    col = 'E';
    
elseif strcmpi(scenario, 'standardisation')

    col = char('E' + (year-2015)/5);
    
elseif strcmpi(scenario, 'innovation')
    
    col = char('L' + (year-2015)/5);
    
% elseif strcmpi(scenario, 'central')
%     
%     col = char('K' + (year-2015)/5);
%     
% elseif strcmpi(scenario, 'best')
%     
%     col = char('N' + (year-2015)/5);
%     
% elseif strcmpi(scenario, 'worst')
%     
%     col = char('Q' + (year-2015)/5);
     
end

if isa(field, 'char')

    switch lower(field)
        
        %wind speed uncertainty%
        case 'uncwind';      row = 15;
        
        %WTG technology%
        case 'lwake';        row = 20;
        
        %foundation technology%
        case 'fndtype';      row = 25;
        case 'wwfndinstall'; row = 26;
        case 'hinstmp';      row = 29;
        case 'hinsttp';      row = 32;
        case 'hinstjkt';     row = 35;
        case 'hinstpp';      row = 38;
        case 'hinstss';      row = 41;
        case 'hinstmoor';    row = 42;
        
        %electrical technology%
        case 'varray';       row = 43;    
        case 'exptype';      row = 44;    
        case 'plattypeac';   row = 45;
        case 'noss';         row = 46;
        case 'oscomp';       row = 47;
        case 'vexportac';    row = 48;
        case 'nconv';        row = 49;
        case 'vexportdc';    row = 50;
        
    end
    
end

cellName = strcat(col,int2str(row));

data = ExcelSheet.Range(cellName).Value;

if isa(data, 'char') && strcmpi(data, '(calc)')
    data = 0;
end