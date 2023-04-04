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

marketFile = strcat(data.paths.runDir, filesep, 'CostReductionScenarios_CHypSE_2023_OWCAT');
ExcelMarketFile = Excel.Workbooks.Open(marketFile, 0, true); MarketOpen = true;

siteFile = strcat(data.paths.runDir, filesep, '20230119-OWCAT Codling CA-EUR v2');
ExcelSiteFile = Excel.Workbooks.Open(siteFile, 0, false); SiteOpen = true;


for i = 1:17

    fprintf(1, '>> Running Case #%1d\n', i);
        
    [yearFID, yearCOD] = getFIDyear(ExcelSiteFile, i);
    %msgbox(int2str(yearCOD));
    [projMods, techMods, markMods] = getCHypSEmarketSetup(ExcelMarketFile, yearCOD);

    projMods = loadProjectData(ExcelSiteFile, projMods, i);
    
    o = runModel('sensi', projMods, techMods, markMods);
    
    writeOutputToEXCEL(o, ExcelSiteFile, i)
    
    vLCOE = LCOEvector(o) * 3.6e9;
    
end

disp(' ');

ExcelMarketFile.Close(false); MarketOpen = false;
ExcelSiteFile.Close(true); SiteOpen = false;
Excel.Quit; ExcelOpen = false;