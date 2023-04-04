function data = getMarketData(ExcelFile, year, scenario, field)

ExcelSheet = ExcelFile.Sheets.Item('Market');

listIndep = {'fMassMP', 'fMassTP', 'fMassPP', 'fMassSS', 'vMaxInst', 'EURIBOR', 'cDebt', 'shareA', 'shareB', 'shareC', 'shareD', 'marketSize', 'fixedMarket', 'floatMarket'};

if year == 2015
    
    col = 'E';
    
elseif strcmpi(scenario, 'standardisation') || any(strcmpi(field, listIndep))

    col = char('E' + (year-2015)/5);
    
elseif strcmpi(scenario, 'innovation')
    
%     col = char('H' + (year-2015)/5);
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
%     
end

if isa(field, 'char')

    switch lower(field)
        
        case 'marketsize'; row = 18;
        
        case 'cdev';      row = 34;
        case 'cgeo';      row = 35;
        case 'cmet';      row = 36;
        
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
        case 'pturb';     row = 37;
        case 'drot';      row = 38;
        case 'cturb';     row = 41;
        case 'hinstturb'; row = 42;
        
        %operation & maintenance%
        case 'noper';     row = 43;
        case 'favailwtg'; row = 44;
        case 'cwtgmon';   row = 45;
        case 'cwtgmaint'; row = 46;
            
        %foundation technology%
        
        case 'cmanmp';    row = 48;
        case 'hdrivemp';  row = 49;
        case 'hdrillmp';  row = 50;
        case 'cmantp';    row = 51;
        case 'hinsttp';   row = 52;
        case 'cmanjkt';   row = 54;
        case 'hinstjkt';  row = 55;   
        case 'npp';       row = 56;
        case 'cmanpp';    row = 58;
        case 'hdrivepp';  row = 59;
        case 'hdrillpp';  row = 60;   
        case 'cmanss';    row = 62;
        case 'hhookss';   row = 63;
        case 'nmoor';     row = 64;
        case 'hlaymoor';  row = 65;
            
        %electrical technology%
        case 'celechvac'; row = 68;    
        case 'celechvdc'; row = 69;
        case 'ccables';   row = 70;
            
        %financing%
        case 'irreq';     row = 71; 
        case 'fdebtmax';  row = 72;
        case 'targdscr';  row = 73;
        case 'fcont';     row = 74;
            
        %insurance%
        case 'finscar';   row = 75;
        case 'finsdsu';   row = 76; 
        case 'finspd';    row = 77;
        case 'finsbi';    row = 78;
            
        case 'fixedmarket'; row = 80;
        case 'floatmarket'; row = 81;
        
    end
    
end

cellName = strcat(col,int2str(row));

data = ExcelSheet.Range(cellName).Value;

if isa(data, 'char') && (strcmpi(data, '(calc)') || strcmpi(data, '(ref)'))
    data = 0;
end