% if exist('MarketOpen', 'var') && MarketOpen
%     ExcelMarketFile.Close(false); 
% end

% if exist('SiteOpen', 'var') && SiteOpen
%     ExcelSiteFile.Close(true); 
% end

% if exist('ExcelOpen', 'var') && ExcelOpen
%     Excel.Quit; 
% end

close all; clear; clc;

warning off all;

[~, data] = prepareEnvironment('setup');

% Excel = actxserver('Excel.Application'); ExcelOpen = true;

marketFile = strcat(data.paths.runDir, filesep, 'CostReductionScenarios_CHypSE_2021_stand.xlsx');
% ExcelMarketFile = Excel.Workbooks.Open(marketFile, 0, true); MarketOpen = true;

siteFile = strcat(data.paths.runDir, filesep, 'Inputs_Stand_SSYREN_den6.xlsx');
% ExcelSiteFile = Excel.Workbooks.Open(siteFile, 0, false); SiteOpen = true;
% msgbox(excelColumnOffset('E', 84));
result = zeros(50,72);
for i = 29:29
    fprintf(1, '>> Running Case #%1d\n', i);
        
%     yearCOD = getFIDyear(ExcelSiteFile, i);
    
%     [projMods, techMods, markMods] = getCHypSEmarketSetup(ExcelMarketFile, yearCOD);

%     projMods = loadProjectData(ExcelSiteFile, projMods, i);
    
%     load('base_case_workspace.mat')
%     load('case_2.mat')
    load(strcat('case_',num2str(i),'.mat'))
    o = runModel('sensi', projMods, techMods, markMods);
    
%     writeOutputToEXCEL(o, ExcelSiteFile, i)
%     result = finalOutputs_rddi(o);
    result(:,i) = finalOutputs_rddi(o);
    
end

disp(' ');

% ExcelMarketFile.Close(false); MarketOpen = false;
% ExcelSiteFile.Close(true); SiteOpen = false;
% Excel.Quit; ExcelOpen = false;
    
    