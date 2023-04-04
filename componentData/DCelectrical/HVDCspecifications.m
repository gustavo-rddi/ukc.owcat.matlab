function [HVDC VSC] = HVDCspecifications()

%%-----------------------------------------------------------------------%%
%%------HVAC-COMPONENT-SPECIFICATIONS------------------------------------%%
%%-----------------------------------------------------------------------%%
HVDC.capMaxConv = {1000,'MW'};        %max. capacity of converter (SQSS) %%
HVDC.capMaxCBL  = {1320,'MW'};       %max. allowed cable capacity (SQSS) %%
%%-----------------------------------------------------------------------%%
HVDC.VgridCon   = {400,'kV'};                   %grid connection voltage %%
HVDC.fAvailSS   = {99,'%'};        %onshore HVDC substation availability %%
HVDC.fAvailCBL  = {99,'%'};                   %export cable availability %%
%%-----------------------------------------------------------------------%%
HVDC.fRoute     = {5,'%'};       %additional cable length due to routing %%
HVDC.lInt       = {40,'m'};   %additional length to switchgear interface %%
HVDC.fSpare     = {3.5,'%'};                %spare cable length to order %%
%%-----------------------------------------------------------------------%%
HVDC.hPrep      = {24,'h'};  %average time to prepare cable installation %%
HVDC.hPullIn    = {12,'h'};    %average time to pull-in single cable end %%
HVDC.hTerm      = {24,'h'};     %average time for cable end  termination %%
%%-----------------------------------------------------------------------%%
HVDC.LRinst     = {5,'%'};         %learning rate for cable installation %%
HVDC.LRterm     = {10,'%'};         %learning rate for cable termination %%
HVDC.Nref       = 1;        %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
HVDC.fRedund    = {0,'%'};     %design redundancy for export components %%
%%-----------------------------------------------------------------------%%

%available sections for HVDC cable%
HVDC.Asect = [300 400 500 630 800 1000 1200 1400 1600 1800 2000 2400];

%%-----------------------------------------------------------------------%%
%%------OFFSHORE-SUBSTATION-SPECIFICATIONS-------------------------------%%
%%-----------------------------------------------------------------------%%
VSC.fAvail   = {99,'%'};                             %VSC availability %%
%%-----------------------------------------------------------------------%%
VSC.hLoad    = {24,'h'};     %VSC topside shore-to-vessel loading time %%
VSC.hInstall = {36,'h'};        %average VSC topside installation time %%
VSC.hComm    = {168,'h'};      %average VSC topside commissioning time %%
VSC.fDecom   = {-25,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
VSC.instVes  = 'SCV';                         %VSC installation vessel %%
VSC.compSup  = 'OTB';      %component supply vessel during installation %%
%%-----------------------------------------------------------------------%%
VSC.cosPhi = 1;