if exist('MarketOpen', 'var') && MarketOpen
    ExcelMarketFile.Close(false); 
end

if exist('SiteOpen', 'var') && SiteOpen
    ExcelSiteFile.Close(true); 
end

if exist('ExcelOpen', 'var') && ExcelOpen
    Excel.Quit; 
end

close all; clear; clc;

warning off all;

[~, data] = prepareEnvironment('setup');

Excel = actxserver('Excel.Application'); ExcelOpen = true;

marketFile = strcat(data.paths.runDir, filesep, 'CostReductionScenarios_CHypSE_2022.xlsx');
ExcelMarketFile = Excel.Workbooks.Open(marketFile, 0, true); MarketOpen = true;

siteFile = strcat(data.paths.runDir, filesep, '20220126-chypse22_site_and_outputs_file-new_wacc_V2.xlsx');
ExcelSiteFile = Excel.Workbooks.Open(siteFile, 0, false); SiteOpen = true;

for i = 1:21
    
    %apply site name considering each site is modelled for 7 different years%
    if i <= 7; site = 'A';
    elseif (7 < i) && (i <= 14); site = 'B';
    elseif (14 < i) && (i <= 21); site = 'C';
    elseif (21 < i) && (i <= 28); site = 'D';
    elseif (28 < i) && (i <= 35); site = 'E';
    end

    fprintf(1, '>> Running Case #%1d\n', i);
    
    site
        
    [yearFID, yearCOD] = getFIDyear(ExcelSiteFile, i);
    
    %msgbox(int2str(yearCOD));

    [projMods, techMods, markMods] = getCHypSEmarketSetup(ExcelMarketFile, yearCOD);

    projMods = loadProjectData(ExcelSiteFile, projMods, i);
    
    o = runModel('sensi', projMods, techMods, markMods);
    
    writeCHypSEdataToEXCEL(ExcelSiteFile, o, site, yearCOD)
    
end

disp(' ');

ExcelMarketFile.Close(false); MarketOpen = false;
ExcelSiteFile.Close(true); SiteOpen = false;
Excel.Quit; ExcelOpen = false;
    
    