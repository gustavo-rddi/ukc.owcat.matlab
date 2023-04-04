
if exist('inputFileOpen', 'var') && inputFileOpen

    ExcelInputFile.Close(false); 

end

if exist('outputFileOpen', 'var') && outputFileOpen

    ExcelOutputFile.Close(true); 

end

if exist('ExcelOpen', 'var') && ExcelOpen

    Excel.Quit; 

end

close all; clear; clc;

warning off all;

[~, data] = prepareEnvironment('setup');

Excel = actxserver('Excel.Application'); ExcelOpen = true;

inputFile = strcat(data.paths.runDir, filesep, '20200120 - CostReductionScenarios_incCN.xlsx');

ExcelInputFile = Excel.Workbooks.Open(inputFile, 0, true); inputFileOpen = true;

outputFile = strcat(data.paths.runDir, filesep, '20200120 OWFC - Market and Site Data_incCN.xlsx');

ExcelOutputFile = Excel.Workbooks.Open(outputFile, 0, false); outputFileOpen = true;

site = {'A','B','C','D'};

scenario = {'Standardisation','Innovation'};

year = [2015 2020 2025 2030 2035 2040 2045 2050];

applyMarketSizeChange(ExcelInputFile, 1);

for i = 1 : numel(site)
    
    for j = 1 : numel(scenario)
        
        for k = 1 : numel(year)

              if i == 1 && j == 1; 
                  
                  fixedMarket(k) = getMarketData(ExcelInputFile, year(k), scenario{j}, 'fixedMarket'); 
                  floatMarket(k) = getMarketData(ExcelInputFile, year(k), scenario{j}, 'floatMarket'); 
              
              end
           
            [projMods, techMods, markMods] = generateModifiers(ExcelInputFile, site{i}, scenario{j}, year(k));
            
            display(sprintf('Site %s - %s %4d', site{i}, scenario{j}, year(k)));
            
            o = runModel('sensi', projMods, techMods, markMods);
            
            LCOE.(scenario{j})(i,k) = o.LCOE.real.total * 3.6e9;
            
            projIRR.(scenario{j})(i,k) = o.OWF.IRRproj;
            eqIRR.(scenario{j})(i,k) = o.finance.MARR;
            
            CAPEX.(scenario{j})(i,k) = o.CAPEX.real.total/o.OWF.cap;
            
            vLCOE.(scenario{j})(i,k,:) = LCOEvector(o) * 3.6e9;
            
            fFloat.(scenario{j})(k) = getMarketData(ExcelInputFile, year(k), scenario{j}, 'shareD');
            
            fFixed.(scenario{j})(i,k) = getMarketData(ExcelInputFile, year(k), scenario{j}, strcat('share',site{i}))/(1 - fFloat.(scenario{j})(k));
            
            writeFCOWdataToEXCEL(ExcelOutputFile, o, site{i}, scenario{j}, year(k));
            
        end
        
    end
    
end

ExcelInputFile.Close(false); inputFileOpen = false;
ExcelOutputFile.Close(true); outputFileOpen = false;
Excel.Quit; ExcelOpen = false;
        
close all

names = {'Standardisation','Innovation'};

color = [ [0 128 255]; [118 147 60]; [255 128 0] ] / 255;

figure('position', [50 75 1350 360]);

for i = 1 : min(numel(scenario), 3)
   
    subplot(1, min(numel(scenario), 3), i);
        
    h = bar(year, LCOE.(scenario{i})');
    
    xlabel('Year of COD', 'FontSize', 12);
    
    if i == 1; ylabel('Levelised Cost [€2020/MWh]', 'FontSize', 12); end
    
    title(names{i}, 'FontSize', 12);
    
    set(h(:),'facecolor', color(i,:));
    
    set(gca, 'XTick', year, 'YLim', [0 300], 'Xlim', [2012.5 2052.5]);
    
end

figure('position', [50 75 1350 360]);

limPlace = (numel(site)-1)/2 / (numel(site)+1);

xCorr = 5*linspace(-limPlace, limPlace, numel(site));

[~, legNames] = LCOEvector(o);

for i = 1 : min(numel(scenario), 3)
    
    for j = 1 : numel(site)
    
        subplot(1, min(numel(scenario), 3), i);  hold on; box on;

        h = bar(year+xCorr(j), squeeze(vLCOE.(scenario{i})(j,:,:)), 0.8/(numel(site)+1), 'stacked');
        
    end
   
    xlabel('Year of COD', 'FontSize', 12);
    
    if i == 1; ylabel('Levelised Cost [€2020/MWh]', 'FontSize', 12); end
    
    title(names{i}, 'FontSize', 12);
    
    set(gca, 'XTick', year, 'YLim', [0 300], 'Xlim', [2012.5 2052.5]);

end

legend(legNames, 'FontSize', 6);

figure('position', [150 175 857   360]);

plot([2012 2053], 100*[1 1], 'k:');

LCOEfixMin = sum(LCOE.Innovation(1:3,:).*fFixed.Innovation(1:3,:));
LCOEfixMax = sum(LCOE.Standardisation(1:3,:).*fFixed.Standardisation(1:3,:));

LCOEfloatMin = LCOE.Innovation(4,:);
LCOEfloatMax = LCOE.Standardisation(4,:);

subplot(1,2,1); hold on; box on;
patch([year, fliplr(year)], [LCOEfixMin, fliplr(LCOEfixMax)], [191 191 191]/256, 'edgecolor', 'none');

subplot(1,2,2); hold on; box on;
patch([year, fliplr(year)], [LCOEfloatMin, fliplr(LCOEfloatMax)], [191 191 191]/256, 'edgecolor', 'none');

for i = 1 : min(numel(scenario), 3)
   
    LCOEfix = sum(LCOE.(scenario{i})(1:3,:).*fFixed.(scenario{i})(1:3,:));
    
    LCOEfloat = LCOE.(scenario{i})(4,:);
   
    subplot(1,2,1); hold on; box on;
    
    plot([2012 2053], [100 100], 'k:');
    h(i) = plot(year, LCOEfix, '-o', 'LineWidth', 2);
    
    ylabel('Levelised Cost [€2020/MWh]', 'FontSize', 12);
    xlabel('Year of COD', 'FontSize', 12);
    
    title('Fixed Sites', 'FontSize', 12);
    
    set(gca, 'XTick', year, 'YLim', [0 300], 'Xlim', [2015 2050]);
    
    subplot(1,2,2); hold on; box on;
    
    plot([2012 2053], [100 100], 'k:');
    f(i) = plot(year, LCOEfloat, '-o', 'LineWidth', 2);
    
    xlabel('Year of COD', 'FontSize', 12);
    
     title('Floating Sites', 'FontSize', 12);
    
    set(gca, 'XTick', year, 'YLim', [0 300], 'Xlim', [2015 2050]);
    
    set(h(i),'color', color(i,:));
    set(f(i),'color', color(i,:));

    mLCOEfix(i,:) = LCOEfix;
    mLCOEfloat(i,:) = LCOEfloat;
    
    mMarketFix(i,:) = fixedMarket;
    mMarketFloat(i,:) = floatMarket;
    
end

legend(h, names, 'location', 'northwest')

%----COMPARISON---------------------------------------------------------%%

figure('position', [150 175 857   360]);

plot([2012 2053], 100*[1 1], 'k:');

LCOEfixMin = sum(LCOE.Standardisation(1:3,:).*fFixed.Standardisation(1:3,:));
LCOEfixMax = sum(LCOE.Innovation(1:3,:).*fFixed.Innovation(1:3,:));

LCOEfloatMin = LCOE.Standardisation(4,:);
LCOEfloatMax = LCOE.Innovation(4,:);

for i = 1 : min(numel(scenario), 3)
   
    LCOEfix(i,:) = sum(LCOE.(scenario{i})(1:3,:).*fFixed.(scenario{i})(1:3,:));
    
    LCOEfloat(i,:) = LCOE.(scenario{i})(4,:);
   
end

yearTCE = [2014 2017 2020];
LCOEcrown = [140 120 100] * 1.055362357 * 1.09251538567493 / 0.792778457024793;
LCOEcrownMin = [140 115 90] * 1.055362357 * 1.09251538567493 / 0.792778457024793;
LCOEcrownMax = [150 135 115] * 1.055362357 * 1.09251538567493 / 0.792778457024793;

colorCrown = [33 85 136]/255;

yearSiemens = [2020 2025 2030];
LCOEsiemens = [96 85 79] * 1.055362357;
LCOEsiemensMin = [96 79.5 72.5] * 1.055362357;
LCOEsiemensMax = [96 94 92.5] * 1.055362357;
colorSiemens = [0 153 153]/255;

yearPrognos = [2013 2017 2020 2023];
LCOEprognosMin = ([128 115 97 82] + [142 123 102 87] + [148 126 105 90])/3 * 1.055362357; 
LCOEprognosMax = ([128 117 102 91] + [142 125 109 97] + [148 128 112 100])/3 * 1.055362357; 
LCOEprognos = (LCOEprognosMin + LCOEprognosMax)/2;
colorPrognos =[238 29 35]/255;

colorEDF = [255 87 22]/255;

yearPelastar = [2020 2025 2030];
LCOEpelastar = [109 77 65] * 1.027736379 * 1.09251538567493 / 0.792778457024793;
LCOEpelastarMin = [92 68 57] * 1.027736379 * 1.09251538567493 / 0.792778457024793;
LCOEpelastarMax = [128 91 78] * 1.027736379 * 1.09251538567493 / 0.792778457024793;
colorPelastar = [0 74 97]/255;

yearCT = [2020 2025 2030];
LCOE_CT = [150 95 80] * 1.3;
LCOE_CTmin = [135 90 75] * 1.3;
LCOE_CTmax = [180 100 85] * 1.3;
colorCT = [0 151 220]/255;

subplot(1,2,1); hold on; box on;

patch([yearTCE, fliplr(yearTCE)], [LCOEcrownMin, fliplr(LCOEcrownMax)], 1 - (1-colorCrown)/3, 'edgecolor', 'none');

patch([yearPrognos, fliplr(yearPrognos)], [LCOEprognosMin, fliplr(LCOEprognosMax)], 1 - (1-colorPrognos)/3, 'edgecolor', 'none');
patch([yearSiemens, fliplr(yearSiemens)], [LCOEsiemensMin, fliplr(LCOEsiemensMax)], 1 - (1-colorSiemens)/3, 'edgecolor', 'none');

patch([year, fliplr(year)], [LCOEfixMin, fliplr(LCOEfixMax)], 1 - (1-colorEDF)/3, 'edgecolor', 'none');

plot([2012 2053], [100 100], 'k:');

plot(year, mean(LCOEfix), '-', 'LineWidth', 2.5, 'Color', colorEDF);
h(1) = plot(year, mean(LCOEfix), '-o', 'LineWidth', 2, 'Color', colorEDF);

h(2) = plot(yearTCE, LCOEcrown, 'r-o', 'LineWidth', 2, 'Color', colorCrown);
h(3) = plot(yearSiemens, LCOEsiemens, '-o', 'LineWidth', 2, 'Color', colorSiemens);
h(4) = plot(yearPrognos, LCOEprognos, '-o', 'LineWidth', 2, 'Color', colorPrognos);

plot(2016, 120*0.75392884*1.0013, 'kd', 'LineWidth', 2);
plot(2016, 167*0.75392884*1.0075, 'kd', 'LineWidth', 2);
plot(2018, 68, 'kd', 'LineWidth', 2);

ylabel('Levelised Cost [€2020/MWh]', 'FontSize', 12);
    xlabel('Year of COD', 'FontSize', 12);
    
    title('Fixed Sites', 'FontSize', 12);
    
    set(gca, 'XTick', year, 'YLim', [0 300], 'Xlim', [2015 2030], 'layer', 'top');

    legend(h, {'EDF R&D (2016)', 'The Crown Estate (2012)', 'North Sea Declaration (2016)', 'Fichtner/Prognos (2013)'})

    
    
subplot(1,2,2); hold on; box on;

patch([yearCT, fliplr(yearCT)], [LCOE_CTmin, fliplr(LCOE_CTmax)], 1 - (1-colorCT)/3, 'edgecolor', 'none');
patch([yearPelastar, fliplr(yearPelastar)], [LCOEpelastarMin, fliplr(LCOEpelastarMax)], 1 - (1-colorPelastar)/3, 'edgecolor', 'none');
patch([year, fliplr(year)], [LCOEfloatMin, fliplr(LCOEfloatMax)], 1 - (1-colorEDF)/3, 'edgecolor', 'none');

    plot([2012 2053], [100 100], 'k:');
    
    plot(year, mean(LCOEfloat), '-', 'LineWidth', 2.5, 'Color', colorEDF);
    h(1) = plot(year, mean(LCOEfloat), '-o', 'LineWidth', 2, 'Color', colorEDF);
    h(3) = plot(yearCT, LCOE_CT, '-o', 'LineWidth', 2, 'Color', colorCT);
    
    h(2) = plot(yearPelastar, LCOEpelastar, '-o', 'LineWidth', 2, 'Color', colorPelastar);
    
    plot(2015, 185*1.35, 'kd', 'LineWidth', 2);
    
    xlabel('Year of COD', 'FontSize', 12);
    
     title('Floating Sites', 'FontSize', 12);
    
    set(gca, 'XTick', year, 'YLim', [0 300], 'Xlim', [2015 2030]);

    legend(h, {'EDF R&D (2016)', 'Glosten Associates (2014)', 'The Carbon Trust (2016)'})
    

%----LEARNING-RATES-----------------------------------------------------%%

% vLCOEfix = reshape(mLCOEfix, numel(mLCOEfix), 1);
% vLCOEfloat = reshape(mLCOEfloat, numel(mLCOEfloat), 1);
% vMarketFix = reshape(mMarketFix, numel(mMarketFix), 1);
% vMarketFloat = reshape(mMarketFloat, numel(mMarketFloat), 1);
% 
% [pFix, LRfix] = findLRfit(vLCOEfix, vMarketFix);
% [pFloat, LRfloat] = findLRfit(vLCOEfloat, vMarketFloat);
% 
% [pFixStandardisation, LRfixStandardisation] = findLRfit(LCOEfixMin, vMarketFix(1:3:12)');
% [pFixInnovation, LRfixInnovation] = findLRfit(LCOEfixMax, vMarketFix(1:3:12)');
% 
% [pFloatStandardisation, LRfloatStandardisation] = findLRfit(LCOEfloatMin, vMarketFloat(1:3:12)');
% [pFloatInnovation, LRfloatInnovation] = findLRfit(LCOEfloatMax, vMarketFloat(1:3:12)');
% 
% xFix = linspace(10, 80);
% 
% yFixStandardisation = exp(polyval(pFixStandardisation, log(xFix)));
% yFixInnovation = exp(polyval(pFixInnovation, log(xFix)));
% 
% xFloat = linspace(eps, 8);
% 
% yFloatStandardisation = exp(polyval(pFloatStandardisation, log(xFloat)));
% yFloatInnovation = exp(polyval(pFloatInnovation, log(xFloat)));
% 
% figure('position', [150 175 857   360]);
% 
% subplot(1,2,1); hold on; box on;
% patch([xFix, fliplr(xFix)], [yFixStandardisation, fliplr(yFixInnovation)], [191 191 191]/256, 'edgecolor', 'none');
% 
% subplot(1,2,2); hold on; box on;
% patch([xFloat, fliplr(xFloat)], [yFloatStandardisation, fliplr(yFloatInnovation)], [191 191 191]/256, 'edgecolor', 'none');
% 
% plot([2012 2033], 100*[1 1], 'k:');
% 
% LCOEfixMin = sum(LCOE.Standardisation(1:3,:).*fFixed.Standardisation(1:3,:));
% LCOEfixMax = sum(LCOE.Innovation(1:3,:).*fFixed.Innovation(1:3,:));
% 
% LCOEfloatMin = LCOE.Standardisation(4,:);
% LCOEfloatMax = LCOE.Innovation(4,:);
% 
% subplot(1,2,1); hold on; box on;
% patch([year, fliplr(year)], [LCOEfixMin, fliplr(LCOEfixMax)], [191 191 191]/256, 'edgecolor', 'none');
% 
% subplot(1,2,2); hold on; box on;
% patch([year, fliplr(year)], [LCOEfloatMin, fliplr(LCOEfloatMax)], [191 191 191]/256, 'edgecolor', 'none');
% 
% addCap = ones(1,100)*4.5*20/100;
% fFloat = linspace(0.125, 0.35);
% 
% yFix = exp(polyval(pFix, log(xFix)));
% 
% yFloat= exp(polyval(pFloat, log(xFloat)));
% 
% for i = 1 : min(numel(scenario), 3)
%    
%     LCOEfix = sum(LCOE.(scenario{i})(1:3,:).*fFixed.(scenario{i})(1:3,:));
%     
%     LCOEfloat = LCOE.(scenario{i})(4,:);
%    
%     subplot(1,2,1); hold on; box on;
%     
%     plot([0 80], [100 100], 'k:');
%     plot(xFix, yFix, 'r-', 'LineWidth', 2.5);
%     h(i) = plot(fixedMarket, LCOEfix, 'o', 'LineWidth', 2);
%     
%     ylabel('Levelised Cost [€2020/MWh]', 'FontSize', 12);
%     xlabel('Installed Capacity [GW]', 'FontSize', 12);
%     
%     title('Fixed Sites', 'FontSize', 12);
%     
%     set(gca, 'YLim', [0 300], 'Xlim', [0 80]);
%     
%     subplot(1,2,2); hold on; box on;
%     
%     plot([0 8], [100 100], 'k:');
%     plot(xFloat, yFloat, 'r-', 'LineWidth', 2.5);
%     f(i) = plot(floatMarket, LCOEfloat, 'o', 'LineWidth', 2);
%     
%     xlabel('Installed Capacity [GW]', 'FontSize', 12);
%     
%      title('Floating Sites', 'FontSize', 12);
%     
%     set(gca, 'YLim', [0 300], 'Xlim', [0 8]);
%     
%     set(h(i),'color', color(i,:));
%     set(f(i),'color', color(i,:));
%     
% end

%-----------------------------------------------------------------------%%

for i = 1 : min(numel(scenario), 3)
   
    IRRfix(i,:) = sum(projIRR.(scenario{i})(1:3,:).*fFixed.(scenario{i})(1:3,:));
    eqIRRfix(i,:) = sum(eqIRR.(scenario{i})(1:3,:).*fFixed.(scenario{i})(1:3,:));
    
    CAPEXfix(i,:) = sum(CAPEX.(scenario{i})(1:3,:).*fFixed.(scenario{i})(1:3,:));
    
    CAPEXfloat(i,:) = CAPEX.(scenario{i})(4,:);
    
    IRRfloat(i,:) = projIRR.(scenario{i})(4,:);
    eqIRRfloat(i,:) = eqIRR.(scenario{i})(4,:);
    
end

CAPEXfixMin = min(CAPEX.Standardisation(1:3,:));
CAPEXfixMax = max(CAPEX.Innovation(1:3,:));

CAPEXfloatMin = CAPEX.Standardisation(4,:);
CAPEXfloatMax = CAPEX.Innovation(4,:);


figure('position', [150 175 857   355]); subplot(1,2,2); hold on; box on;
plot(year, mean(IRRfix)*100, 'b-o', 'LineWidth', 2)
plot(year, mean(IRRfloat)*100, 'r-o', 'LineWidth', 2);

xlabel('Year of COD', 'FontSize', 12);
ylabel('Project IRR [%]', 'FontSize', 12);



subplot(1,2,1); hold on; box on;
patch([year, fliplr(year)], 1000*[CAPEXfloatMin, fliplr(CAPEXfloatMax)], 1-(1-[1 0 0])/3, 'edgecolor', 'none');
patch([year, fliplr(year)], 1000*[CAPEXfixMin, fliplr(CAPEXfixMax)], 1-(1-[0 0 1])/3, 'edgecolor', 'none');
h(1) = plot(year, 1000*mean(CAPEXfix), 'b-o', 'LineWidth', 2);
h(2) = plot(year, 1000*mean(CAPEXfloat), 'r-o', 'LineWidth', 2);
   
set(gca,'layer','top','ylim', [0 9e3]);

xlabel('Year of COD', 'FontSize', 12);
ylabel('Project CAPEX [£2015/kW]', 'FontSize', 12);

legend(h, {'Fixed', 'Floating'});