function o = defaultProjectSpecifications(o)

%%-----------------------------------------------------------------------%%
%%------GENERAL-WIND-FARM-SPECIFICATIONS---------------------------------%%
%%-----------------------------------------------------------------------%%
o.OWF.loc      = 'FR';                  %wind farm geographical location %%
%%-----------------------------------------------------------------------%%
o.OWF.yrOper   = 2023;                     %first year of full operation %%
o.OWF.nComm    = 1;            %number of years to bring all WTGs online %%
%%-----------------------------------------------------------------------%%
o.OWF.nOSS     = 2;                      %number of offshore substations %%
o.OWF.nConv    = 1;               %number of offshore converter stations %%
%%-----------------------------------------------------------------------%%
o.OWF.expType  = 'MVAC';                    %substation configuration %%
o.OWF.lOnshore = {15,'km'};                 %onshore export cable length %%
o.OWF.fndShare = true;
o.OWF.sigWind  = {13,'%'};
%o.OWF.lWake = {7, '%'};
%%-----------------------------------------------------------------------%%
o.OWF.zTNUoS   = 26;                     %grid connection zone (UK-only) %%
%o.OWF.fdnMass = {1500,'tonnes'};                         %foundation mass%%
%o.OWF.compMass = {550,'tonnes'};                         %foundation mass%%
% o.OWF.opex = {40000000, 'EUR'};                        %default opex cost%%

%%-----------------------------------------------------------------------%%
%%------ZONAL-SPECIFICATIONS---------------------------------------------%%
%%-----------------------------------------------------------------------%%
o.zone(1).cap       = {500,'MW'};            %maximum installed capacity %%
o.zone(1).dWater    = {125,'m'};                     %average water depth %%
o.zone(1).vWind     = {9,'m/s'};         %average wind speed (at 100m) %%
o.zone(1).dLandfall = {25,'km'};       %distance to cable landfall point %%
o.zone(1).dPortCon  = {25,'km'};          %distance to construction port %%
o.zone(1).dPortOM   = {25,'km'};           %distance to maintenance port %%
o.zone(1).WTGmodel  = 'generic-6-150';               %selected WTG model %%
o.zone(1).mTopSide  = {684,'t'};               %default mass WTG %%
o.zone(1).soilType  = 0;                       %Soil type %%
o.zone(1).fndType   = 'semisub';               %selected WTG foundation %%
o.zone(1).fDrill    = {0,'%'};    %fraction of sites requiring drilling %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------SYSTEM-DESIGN-SPECIFICATIONS-------------------------------------%%
%%-----------------------------------------------------------------------%%
o.design.fSpace   = 6.5;              %turbine spacing (rotor diameters) %%
%%-----------------------------------------------------------------------%%
o.design.arrConf  = 'ring';           %inter-array cable configuration %%
o.design.Varray   = {66,'kV'};                %inter-array cable voltage %%
o.design.arrCond  = 'Cu';          %inter-array cable conductor material %%
%%-----------------------------------------------------------------------%%
o.design.expConf  = 'OTM';                    %substation configuration %%
o.design.Vexport  = {220,'kV'};                    %export cable voltage %%
o.design.expCond  = 'Cu';               %export cable conductor material %%
%%-----------------------------------------------------------------------%%
o.design.Vcoll    = {132,'kV'};                 %collector cable voltage %%
o.design.collCond = 'Cu';               %export cable conductor material %%
%%-----------------------------------------------------------------------%%
o.design.osComp   = false;                        %offshore compensation %%
o.design.lfComp   = false;                        %landfall compensation %%
o.design.intConSS = false;          %interconnection between substations %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------FINANCING-SPECIFICATIONS-----------------------------------------%%
%%-----------------------------------------------------------------------%%
o.finance.type     = 'project';          %project or corporate financing %%
%%-----------------------------------------------------------------------%%
o.finance.kHurdle  = {7.84,'%'};      %corporate finance hurdle rate (CF) %%
%%-----------------------------------------------------------------------%%
o.finance.MARR     = {15,'%'};    %minimum rate of return on equity (PF) %%
%%-----------------------------------------------------------------------%%
o.finance.iDebtCon = {3.5,'%'};      %interest on construction debt (PF) %%
o.finance.nDebt    = 15;        %number of years for debt repayment (PF) %%
%%-----------------------------------------------------------------------%%
o.finance.refin    = false;         %refinancing after commissioning (PF) %%
o.finance.iDebtRe  = {3.5,'%'};        %interest on refinanced debt (PF) %%
o.finance.CuMult20  = 1;       %Cu price assumed same as 2020 for base case%%
o.finance.CuMult22  = 1;       %Cu price assumed same as 2022 for base case%%
%%-----------------------------------------------------------------------%%