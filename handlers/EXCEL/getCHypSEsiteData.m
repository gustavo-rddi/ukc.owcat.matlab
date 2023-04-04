function data = getCHypSEsiteData(ExcelFile, siteType, year, field)

%get requested EXCEL worksheet%
ExcelSheet = ExcelFile.Sheets.Item(strcat('Type', siteType));

switch year
    
    case 2018; col = 'E';
    case 2020; col = 'F';
    case 2023; col = 'G';
    case 2025; col = 'H';
    case 2030; col = 'I';
    case 2035; col = 'J';
    case 2040; col = 'K';
        
%     otherwise
%         
%         col = char('I' + (year-2025)/5);
%         
end

if isa(field, 'char')

    switch lower(field)
        
        %foundation technology%
        case 'fndtype';      row = 17;
        case 'wwfndinstall'; row = 18;
        case 'hinstmp';      row = 21;
        case 'hinsttp';      row = 24;
        case 'hinstjkt';     row = 27;
        case 'hinstpp';      row = 30;
        case 'hinstss';      row = 33;
        case 'hinstmoor';    row = 34;
        
        %electrical technology%
        case 'varray';       row = 35;    
        case 'exptype';      row = 36;    
        case 'plattypeac';   row = 37;
        case 'noss';         row = 38;
        case 'oscomp';       row = 39;
        case 'vexportac';    row = 40;
        case 'nconv';        row = 41;
        case 'vexportdc';    row = 42;
        
    end
    
end

cellName = strcat(col,int2str(row));

data = ExcelSheet.Range(cellName).Value;

if isa(data, 'char') && strcmpi(data, '(calc)')
    data = 0;
end