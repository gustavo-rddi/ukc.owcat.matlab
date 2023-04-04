function data = getSiteSpecs(ExcelFile, siteType, year, scenario, field)

%get requested EXCEL worksheet%
ExcelSheet = ExcelFile.Sheets.Item(strcat('Type', siteType));

if isa(field, 'char') && ~(strcmpi(siteType, 'D') && strcmpi(field, 'cap'))

    switch lower(field)
        
        case 'cap';     row = 3;
        case 'dwater';  row = 4;
        case 'soiltype'; row = 5;
        case 'dshore';  row = 6;
        case 'vmean';   row = 7;
        
    end
    
    cellName = strcat('E', int2str(row));
    
else
        
    row = 51;
    
    if year == 2015
        
        col = 'E';
        
    elseif strcmpi(scenario, 'standardisation')
        
        col = char('E' + (year-2015)/5);
        
    elseif strcmpi(scenario, 'innovation')
        
        col = char('L' + (year-2015)/5);
        
%     elseif strcmpi(scenario, 'central')
%         
%         col = char('K' + (year-2015)/5);
%         
%     elseif strcmpi(scenario, 'best')
%     
%         col = char('N' + (year-2015)/5);
%     
%     elseif strcmpi(scenario, 'worst')
%     
%         col = char('Q' + (year-2015)/5);
    
    end
    
    cellName = strcat(col, int2str(row));
        
end

data = ExcelSheet.Range(cellName).Value;