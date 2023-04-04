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
%    msgbox(int2str(year))
if year == 2015
    switch year
        case 2015; col = 'E';
    end
elseif year < 2023 && year ~= 2015
    
    data_low = getCHypSEmarketData(ExcelFile, 2015, field);
    data_high = getCHypSEmarketData(ExcelFile, 2023, field);
    
    data = data_low + ((year-2015)/8)*(data_high - data_low);
    %    msgbox(int2str(data));
    return
elseif year > 2023 && year < 2028
    data_low = getCHypSEmarketData(ExcelFile, 2023, field);
    data_high = getCHypSEmarketData(ExcelFile, 2028, field);
    
    data = data_low + ((year-2023)/5)*(data_high - data_low);
    return
elseif year > 2028 && year < 2030
    data_low = getCHypSEmarketData(ExcelFile, 2028, field);
    data_high = getCHypSEmarketData(ExcelFile, 2030, field);
    
    data = data_low + ((year-2027)/2)*(data_high - data_low);
    return
elseif year > 2030 && year < 2035
    data_low = getCHypSEmarketData(ExcelFile, 2030, field);
    data_high = getCHypSEmarketData(ExcelFile, 2035, field);
    
    data = data_low + ((year-2030)/5)*(data_high - data_low);
    %    msgbox(int2str(data))
    return
elseif year > 2035 && year < 2040
    data_low = getCHypSEmarketData(ExcelFile, 2035, field);
    data_high = getCHypSEmarketData(ExcelFile, 2040, field);
    
    data = data_low + ((year-2035)/5)*(data_high - data_low);
    return
elseif year > 2040 && year < 2045
    data_low = getCHypSEmarketData(ExcelFile, 2040, field);
    data_high = getCHypSEmarketData(ExcelFile, 2045, field);
    
    data = data_low + ((year-2040)/5)*(data_high - data_low);
    return
elseif year > 2045 && year < 2050
    data_low = getCHypSEmarketData(ExcelFile, 2045, field);
    data_high = getCHypSEmarketData(ExcelFile, 2050, field);
    
    data = data_low + ((year-2045)/5)*(data_high - data_low);
    return
elseif year > 2050 && year < 2055
    data_low = getCHypSEmarketData(ExcelFile, 2050, field);
    data_high = getCHypSEmarketData(ExcelFile, 2055, field);
    
    data = data_low + ((year-2050)/5)*(data_high - data_low);
    return
elseif year > 2055 && year < 2060
    data_low = getCHypSEmarketData(ExcelFile, 2055, field);
    data_high = getCHypSEmarketData(ExcelFile, 2060, field);
    
    data = data_low + ((year-2055)/5)*(data_high - data_low);
    return
else
    switch year
        case 2023; col = 'F';
        case 2028; col = 'G';
        case 2030; col = 'H';
        case 2035; col = 'I';
        case 2040; col = 'J';
        case 2045; col = 'K';
        case 2050; col = 'L';
        case 2055; col = 'M';
        case 2060; col = 'N';

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
        case 'pturb';     row = 35;
        case 'drot';      row = 36;
        case 'cturb';     row = 40;
        case 'hinstturb'; row = 41;
            
            %operation & maintenance%
        case 'noper';     row = 42;
        case 'favailwtg'; row = 43;
        case 'cwtgmon';   row = 44;
        case 'cwtgmaint'; row = 45;
            
            %foundation technology%
        case 'cmanmp';    row = 47;
            %             case 'csecsteelmp'; row = 46;
            %             case 'cfitmp';    row = 47;
        case 'hdrivemp';  row = 48;
        case 'hdrillmp';  row = 49;
            
        case 'cmantp';    row = 50;
        case 'hinsttp';   row = 51;
            
        case 'cmansjkt';  row = 53;
        case 'cmanhjkt';  row = 54;
            
            %             case 'csecsteeljkt'; row = 54;
            %             case 'cfitjkt';   row = 55;
        case 'hinstjkt';  row = 55;
        case 'npp';       row = 56;
        case 'cmanpp';    row = 58;
        case 'hdrivepp';  row = 59;
        case 'hdrillpp';  row = 60;
            
        case 'cmanss';    row = 62;
        case 'csecss';    row = 63;
        case 'ccorrprotss';row = 64;
        case 'hrss';    row = 65;
        case 'hhookss';   row = 66;
            %             case 'nmoor';     row = 65;
        case 'cmanpileanch';     row = 67;
            %             case 'hlaymoor';  row = 68;
        case'cmandraganch'; row = 69;
            
            %electrical technology%
        case 'cumult20'; row = 71;
        case 'cumult22'; row = 72;
        case 'celechvac'; row = 75;
        case 'celechvdc'; row = 76;
        case 'ccables';   row = 77;
            
            %financing%
        case 'irreq';     row = 78;
        case 'fdebtmax';  row = 79;
        case 'targdscr';  row = 80;
        case 'fcont';     row = 81;
            
            %insurance%
        case 'finscar';   row = 82;
        case 'finsdsu';   row = 83;
        case 'finspd';    row = 84;
        case 'finsbi';    row = 85;
            %             case 'wakeopt';   row = 78;
            
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