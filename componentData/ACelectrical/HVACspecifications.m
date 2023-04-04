function [HVAC, OHVS, OTM] = HVACspecifications()

%%-----------------------------------------------------------------------%%
%%------HVAC-COMPONENT-SPECIFICATIONS------------------------------------%%
%%-----------------------------------------------------------------------%%
HVAC.nMinTrans  = 2;          %min. number of transformers per SS (SQSS) %%
HVAC.capMaxTran = {1000,'MW'};     %max. capacity of transformers (SQSS) %%
HVAC.capMaxCBL  = {350,'MW'};       %max. allowed cable capacity (SQSS) %%
%%-----------------------------------------------------------------------%%
HVAC.VgridCon   = {400,'kV'};                   %grid connection voltage %%
HVAC.fAvailSS   = {99,'%'};        %onshore HVAC substation availability %%
HVAC.fAvailCBL  = {99,'%'};                   %export cable availability %%
HVAC.cosPhiGC   = 0.95;                  %grid-code reactive requirement %%
%%-----------------------------------------------------------------------%%
HVAC.fRoute     = {5,'%'};       %additional cable length due to routing %%
HVAC.lInt       = {40,'m'};   %additional length to switchgear interface %%
HVAC.fSpare     = {3.5,'%'};                %spare cable length to order %%
%%-----------------------------------------------------------------------%%
HVAC.hPrep      = {24,'h'};  %average time to prepare cable installation %%
HVAC.hPullIn    = {12,'h'};    %average time to pull-in single cable end %%
HVAC.hTerm      = {24,'h'};     %average time for cable end  termination %%
%%-----------------------------------------------------------------------%%
HVAC.LRinst     = {5,'%'};         %learning rate for cable installation %%
HVAC.LRterm     = {10,'%'};         %learning rate for cable termination %%
HVAC.Nref       = 2;        %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
HVAC.fRedund    = {50,'%'};     %design redundancy for export components %%
%%-----------------------------------------------------------------------%%

%available sections for HVAC cable%
HVAC.AsectSB = [400 500 630 800 1000 1200 1400 1600];
HVAC.AsectUG = [400 500 630 800 1000 1200 1400 1600 1800 2000 2500];

%%-----------------------------------------------------------------------%%
%%------OFFSHORE-SUBSTATION-SPECIFICATIONS-------------------------------%%
%%-----------------------------------------------------------------------%%
OHVS.fAvail   = {99,'%'};                             %OHVS availability %%
OHVS.fCompOff = {35,'%'};     %fraction of offshore reactive compensation %%
OHVS.cosPhi   = 1.00;                        %WTG power factor set-point %%
%%-----------------------------------------------------------------------%%
OHVS.hLoad    = {24,'h'};     %OHVS topside shore-to-vessel loading time %%
OHVS.hInstall = {36,'h'};        %average OHVS topside installation time %%
OHVS.hComm    = {168,'h'};      %average OHVS topside commissioning time %%
OHVS.fDecom   = {-25,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
OHVS.instVes  = 'SCV';                         %OHVS installation vessel %%
OHVS.compSup  = 'OTB';      %component supply vessel during installation %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------OFFSHORE-TRANSFORMER-MODULE-SPECIFICATIONS-----------------------%%
%%-----------------------------------------------------------------------%%
OTM.capMax   = {300,'MW'};                     %max. OTM export capacity %%
OTM.fAvail   = {99,'%'};                               %OTM availability %%
OTM.cosPhi   = 0.97;                         %WTG power factor set-point %%
%%-----------------------------------------------------------------------%% 
OTM.hLoad    = {12,'h'};                     %OTM equipment loading time %%
OTM.hInstall = {24,'h'};                %OTM equipment installation time %%
OTM.hComm    = {72,'h'};               %OTM equipment commissioning time %%
OTM.fDecom   = {-25,'%'};                %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
OTM.instVes  =  'HLJU';                         %OTM installation vessel %%
OTM.compSup  =  'self';         %installation vessel component transport %%
%%-----------------------------------------------------------------------%%