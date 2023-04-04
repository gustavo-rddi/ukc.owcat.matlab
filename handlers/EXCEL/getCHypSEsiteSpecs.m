function data = getCHypSEsiteSpecs(ExcelFile, siteType, year, field)

if ~(strcmpi(siteType, 'D') && strcmpi(field, 'cap'))

    %get requested EXCEL worksheet%
    ExcelSheet = ExcelFile.Sheets.Item(strcat('Type', siteType));   
    
    switch lower(field)
        
        case 'cap';     row = 3;
        case 'dwater';  row = 4;
        case 'soiltype'; row = 5;
        case 'dshore';  row = 6;
        case 'vmean';   row = 7;
        
    end
    
    col = 'E';
    
else
    
    %get requested EXCEL worksheet%
    ExcelSheet = ExcelFile.Sheets.Item('Market');   
    
    row = 23;
    
    switch year
        
        case 2018; col = 'E';
        case 2020; col = 'F';
        case 2023; col = 'G';
        case 2025; col = 'H';
        case 2030; col = 'I';
        case 2035; col = 'J';
        case 2040; col = 'K';
                        
            
        otherwise
    
%             col = char('I' + (year-2025)/5);
            
    end
        
end

cellName = strcat(col, int2str(row));

data = ExcelSheet.Range(cellName).Value;