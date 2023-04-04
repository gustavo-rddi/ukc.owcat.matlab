function WTG = WTGspecifications()

%%-----------------------------------------------------------------------%%
%%------WIND-TURBINE-SPECIFICATIONS--------------------------------------%%
%%-----------------------------------------------------------------------%%
WTG.hClear   = {25,'m'};            %blade tip clearance above sea level %%
%%-----------------------------------------------------------------------%%
WTG.hLoad    = {12,'h'};               %WTG shore-to-vessel loading time %% 
WTG.hInstall = {24,'h'};                  %average WTG installation time %%
WTG.hComm    = {72,'h'};                 %average WTG commissioning time %%
WTG.fDecom   = {-50,'%'};                %time factor for decomissioning %%
WTG.vMaxInst = {10,'m/s'};    %max. wind speed for installation (at hub) %%
%%-----------------------------------------------------------------------%%
WTG.instVes  = 'HLJU';                          %WTG installation vessel %%
WTG.compSup  = 'self';      %component supply vessel during installation %%
%%-----------------------------------------------------------------------%%
WTG.LRinst   = {5,'%'};             %learning rate for WTG installation %%
WTG.Nref     = 70;          %reference number of units for learning rate %%
WTG.LRman   = {0.5,'%'};             %learning rate for WTG installation %%
%%-----------------------------------------------------------------------%%
WTG.fAvail   = {95,'%'};                  %average wind WTG availability %%
WTG.fDegr    = {0.5,'%'};               %yearly power output degradation %%
%%-----------------------------------------------------------------------%%
WTG.nOper    = 25;                  %number of years of operational life %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------GENERIC-TURBINE-DESIGN-DATA--------------------------------------%%
%%-----------------------------------------------------------------------%%
WTG.vCutIn   = {3.5,'m/s'};                  %designed cut-in wind speed %%
WTG.vCutOut  = {30,'m/s'};                  %designed cut-out wind speed %%
%%-----------------------------------------------------------------------%%
WTG.effBetz  = {75,'%'};                   %design-point Betz efficiency %%
%%-----------------------------------------------------------------------%%
WTG.rhoNom   = {1.225,'kg/m3'};                %design-point air density %%
%%-----------------------------------------------------------------------%%
WTG.cSpecDef = {1081,strcat(char(8364),'/kW')};        %default WTG cost for generic units %%
WTG.currDef  = 'EUR';                         %default WTG cost currency %%
WTG.yearRef  = 2015;                    %default WTG cost reference year %%