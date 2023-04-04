function data = getCHypSEmarketData(ExcelFile, year, field)

ExcelSheet = ExcelFile.Sheets.Item('Market');


% if year is 2019, then interpolate between 2018 and 2020 
%if year == 2019

%    data_low = getCHypSEmarketData(ExcelFile, 2018, field);
%    data_high = getCHypSEmarketData(ExcelFile, 2020, field);
     
%    data = data_low + 0.5*(data_high - data_low);

%    checkYr = 2019;
    
% for years <2020 not divisble by 5, interpolate between nearest 2
% multiples of 5 years. Exception is 2018, which does not require
% interpolate at Chypse 2018 has values for 2018
%elseif rem(year, 5) ~= 0 && year ~= 2018
    
%    data_low = getCHypSEmarketData(ExcelFile, 5*floor(year/5), field);
%    data_high = getCHypSEmarketData(ExcelFile, 5*ceil(year/5), field);
    
%    data = data_low + (rem(year,5)/5)*(data_high - data_low);
%    checkYr = year;
    
%else
  
%        switch year
%            case 2018; col = 'F';
%            case 2019; col = 'F';
%            case 2020; col = 'F';
%            case 2021; col = 'F';    
%            case 2022; col = 'F';
%            case 2023; col = 'F';
%            case 2024; col = 'G';    
%            case 2025; col = 'G';
%            case 2026; col = 'G';    
%            case 2030; col = 'H';  
%            case 2035; col = 'I';  
%            case 2040; col = 'J';  
%        end
        
%        cellName = strcat('F',int2str(16));
%        checkYr = ExcelSheet.Range(cellName).Value;

    
    % if incorrect col still being referred to then something else is being
    % used and manual intervention needed
if year == 2015
    switch year
            case 2015; col = 'E';
    end
elseif year < 2021 && year ~= 2015
    
    data_low = getCHypSEmarketData(ExcelFile, 2015, field);
    data_high = getCHypSEmarketData(ExcelFile, 2021, field);
     
    data = data_low + ((2021-year)/6)*(data_high - data_low);
%    msgbox(int2str(data));
    return
elseif year > 2021 && year < 2026
    data_low = getCHypSEmarketData(ExcelFile, 2021, field);
    data_high = getCHypSEmarketData(ExcelFile, 2026, field);
     
    data = data_low + ((2026-year)/5)*(data_high - data_low);
    return
elseif year > 2026 && year < 2030
    data_low = getCHypSEmarketData(ExcelFile, 2026, field);
    data_high = getCHypSEmarketData(ExcelFile, 2030, field);
     
    data = data_low + ((2030-year)/4)*(data_high - data_low);
    return
elseif year > 2030 && rem(year, 5) ~= 0
    data_low = getCHypSEmarketData(ExcelFile, 5*floor(year/5), field);
    data_high = getCHypSEmarketData(ExcelFile, 5*ceil(year/5), field);
     
    data = data_low + ((5*ceil(year/5)-year)/5)*(data_high - data_low);
%    msgbox(int2str(data))
    return
else
    switch year
            case 2021; col = 'F';
            case 2026; col = 'G';  
            case 2030; col = 'H';
            case 2035; col = 'I';
            case 2040; col = 'J';
            case 2045; col = 'K';
            case 2050; col = 'L';    
    end
end
    
%    if year ~= checkYr 
%        msg = msgbox('ERROR WITH REFERRING TO CORRECT YEAR IN CHYPSE INPUTS SHEET. ARE YOU USING SOMETHING OTHER THAN CHYPSE 2017 OR 2018? EDIT getCHypSEmarketData REQUIRED.');
%    end
    
    
    if isa(field, 'char')

        switch lower(field)

            case 'marketsize'; row = 18;

            case 'sharea';    row = 19;
            case 'shareb';    row = 20;
            case 'sharec';    row = 21;
            case 'shared';    row = 22;

            case 'fmassmp';   row = 24;
            case 'fmasstp';   row = 24;
            case 'fmasspp';   row = 24;
            case 'fmassjkt';  row = 25;
            case 'fmassss';   row = 26;
            case 'vmaxinst';  row = 27;
            case 'euribor';   row = 29;    
            case 'cdebt';     row = 30;

            %WTG technology%
            case 'pturb';     row = 34;
            case 'drot';      row = 35;
            case 'cturb';     row = 38;
            case 'hinstturb'; row = 39;

            %operation & maintenance%
            case 'noper';     row = 40;
            case 'favailwtg'; row = 41;
            case 'cwtgmon';   row = 42;
            case 'cwtgmaint'; row = 43;

            %foundation technology%
            case 'cmanmp';    row = 45;
            case 'hdrivemp';  row = 46;
            case 'hdrillmp';  row = 47;
            case 'cmantp';    row = 48;
            case 'hinsttp';   row = 49;

            case 'cmanjkt';   row = 51;
            case 'hinstjkt';  row = 52;   
            case 'npp';       row = 53;
            case 'cmanpp';    row = 55;
            case 'hdrivepp';  row = 56;
            case 'hdrillpp';  row = 57;  

            case 'cmanss';    row = 59;
            case 'hhookss';   row = 60;
            case 'nmoor';     row = 61;
            case 'hlaymoor';  row = 62;

            %electrical technology%
            case 'celechvac'; row = 65;    
            case 'celechvdc'; row = 66;
            case 'ccables';   row = 67;

            %financing%
            case 'irreq';     row = 68; 
            case 'fdebtmax';  row = 69;
            case 'targdscr';  row = 70;
            case 'fcont';     row = 71;

            %insurance%
            case 'finscar';   row = 72;
            case 'finsdsu';   row = 73; 
            case 'finspd';    row = 74;
            case 'finsbi';    row = 75;
            case 'wakeopt';    row = 76;

        end

    end
    

    cellName = strcat(col,int2str(row));

    data = ExcelSheet.Range(cellName).Value;
%    msgbox(int2str(data));
    if isa(data, 'char') && (strcmpi(data, '(calc)') || strcmpi(data, '(ref)'))
        data = 0;
    end
end
% end