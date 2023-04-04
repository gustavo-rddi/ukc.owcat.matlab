function [fnd, MP, TP, sJKT, hJKT, PP, semi, drag, GBF] = foundationSpecifications()

%%-----------------------------------------------------------------------%%
%%------GENERAL-SPECIFICATIONS-------------------------------------------%%
%%-----------------------------------------------------------------------%%
fnd.curr   = 'EUR';      %stated currency for steel manufacturing prices %%
fnd.yrRef  =  2015;       %reference year for steel manufacturing prices %%
%%-----------------------------------------------------------------------%%
fnd.fManSS = 4/5;              %secondary steel manufacturing cost share %%
%%-----------------------------------------------------------------------%%
fnd.cScour = {40,strcat(char(8364),'/t')};                %scour protection material price %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%-------MONOPILE-SPECIFICATIONS-----------------------------------------%%
%%-----------------------------------------------------------------------%%
MP.cSteel   = {1230,strcat(char(8364),'/t')};               %monopile finished steel price %%
MP.fMan     = 1/3;                    %monopile manufacturing cost share %%
%%-----------------------------------------------------------------------%%
MP.hLoad    = {6,'h'};            %monopile shore-to-vessel loading time %%
MP.hInstall = {36,'h'};              %average monopile installation time %%
MP.dhDrill  = {72,'h'};                   %additional time when drilling %%
MP.fDecom   = {-25,'%'};                 %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
MP.instVes  = 'HLJU';                      %monopile installation vessel %%
MP.compSup  = 'self';       %component supply vessel during installation %%
MP.instEquip = 'hammerMP'; 
%%-----------------------------------------------------------------------%%
MP.LRman    = {3,'%'};         %learning rate for monopile manufacturing %%
MP.LRinst   = {5,'%'};         %learning rate for monopile installation %%
MP.Nref     = 80;           %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
MP.mSPmat   = {2000,'t'};            %required scour protection material %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%-------TRANSITION-PIECE-SPECIFICATIONS---------------------------------%%
%%-----------------------------------------------------------------------%%
TP.cSteel   = {1723,strcat(char(8364),'/t')};       %transition piece finished steel price %%
TP.fMan     = 1/2;            %transition piece manufacturing cost share %%
%%-----------------------------------------------------------------------%%
TP.hLoad    = {6,'h'};    %transition piece shore-to-vessel loading time %%
TP.hInstall = {18,'h'};      %average transition piece installation time %%
TP.fDecom   = {-50,'%'};                 %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
TP.instVes  = 'HLDP';              %transition piece installation vessel %%
TP.compSup  = 'self';       %component supply vessel during installation %%
TP.instEquip = 'grout' ;
%%-----------------------------------------------------------------------%%
TP.LRman    = {5,'%'};     %learning rate for trans. piece manufacturing %%
TP.LRinst   = {5,'%'};     %learning rate for trans. piece installation %%
TP.Nref     = 80;           %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------SMALL-(WTG)-JACKET-SPECIFICATIONS--------------------------------%%
%%-----------------------------------------------------------------------%%
sJKT.cSteel   = {3400,strcat(char(8364),'/t')};           %WTG jacket finished steel price %%
sJKT.fMan     = 2/3;                %WTG jacket manufacturing cost share %%
%%-----------------------------------------------------------------------%%
sJKT.hLoad    = {12,'h'};       %WTG jacket shore-to-vessel loading time %%
sJKT.hInstall = {24,'h'};          %average WTG jacket installation time %%
sJKT.fDecom   = {-50,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
sJKT.instVes  = 'HLJU';                  %WTG jacket installation vessel %%
sJKT.compSup  = 'self';     %component supply vessel during installation %%
sJKT.instEquip = 'grout' ;
%%-----------------------------------------------------------------------%%
sJKT.LRman    = {5,'%'};        %learning rate for jacket manufacturing %%
sJKT.LRinst   = {5,'%'};         %learning rate for jacket installation %%
sJKT.Nref     = 70;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
sJKT.nPP      = 4;                   %number of pin-piles per WTG jacket %%
sJKT.mSPmat   = {850,'t'};           %required scour protection material %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------HEAVY-(SUBSTATION)-JACKET-SPECIFICATIONS-------------------------%%
%%%----------------------------------------------------------------------%%
hJKT.cSteel   = {3400,strcat(char(8364),'/t')};         %heavy jacket finished steel price %%
hJKT.fMan     = 3/4;              %heavy jacket manufacturing cost share %%
%%-----------------------------------------------------------------------%%
hJKT.hLoad    = {24,'h'};     %heavy jacket shore-to-vessel loading time %%
hJKT.hInstall = {48,'h'};        %average heavy jacket installation time %%
hJKT.fDecom   = {-50,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
hJKT.instVes  = 'SCV';                 %heavy jacket installation vessel %%
hJKT.compSup  = 'OTB';      %component supply vessel during installation %%
hJKT.instEquip = 'grout' ;
%%-----------------------------------------------------------------------%%
hJKT.LRman    = {5,'%'};        %learning rate for jacket manufacturing %%
hJKT.LRinst   = {5,'%'};         %learning rate for jacket installation %%
hJKT.Nref     = 2;          %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
hJKT.nPP      = 8;                 %number of pin-piles per heavy jacket %%
hJKT.mSPmat   = {2500,'t'};          %required scour protection material %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------PIN-PILE-SPECIFICATIONS------------------------------------------%%
%%%----------------------------------------------------------------------%%
PP.cSteel   = {1257,strcat(char(8364),'/t')};               %pin-pile finished steel price %%
PP.fMan     = 1/3;                    %pin-pile manufacturing cost share %%
%%%----------------------------------------------------------------------%%
PP.hLoad    = {3,'h'};            %pin-pile shore-to-vessel loading time %%
PP.hInstall = {24,'h'};              %average pin-pile installation time %%
PP.dhDrill  = {48, 'h'};                  %additional time when drilling %%
PP.fDecom   = {-25,'%'};                 %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
PP.instVes  = 'SPJU';                      %pin-pile installation vessel %%
PP.compSup  = 'OTB';        %component supply vessel during installation %%
PP.instEquip = 'hammerPP';
%%-----------------------------------------------------------------------%%
PP.LRman    = {3,'%'};         %learning rate for pin-pile manufacturing %%
PP.LRinst   = {5,'%'};         %learning rate for pin-pile installation %%
PP.Nref     = 70;           %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------SEMISUBMERSIBLE-SPECIFICATIONS-----------------------------------%%
%%-----------------------------------------------------------------------%%
semi.cSteel   = {4500,strcat(char(8364),'/t')};     %semi-sub floater finished steel price %%
semi.fMan     = 2/3;          %semi-sub floater manufacturing cost share %%
%%-----------------------------------------------------------------------%%
semi.hLoadOut = {12,'h'};       %semi-sub floater quayside load-out time %%
%%-----------------------------------------------------------------------%%
semi.hLaunch  = {24, 'h'};
semi.hPrep    = {6,'h'};          %average WTG jacket installation time %%
semi.hHookUp  = {120,'h'};          %average WTG jacket installation time %%
semi.hBallast = {0,'h'};
semi.fDecom   = {-50,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
semi.instVes  = 'AHTS';                  %WTG jacket installation vessel %%
semi.Ntug     = 2;           %number of auxiliary tugs %%
semi.ballVes  = 'OTB';
semi.compSup  = 'float';    %component supply vessel during installation %%
semi.vTow     = {3,'kn'};
semi.launch   = 'subBarge';
%%-----------------------------------------------------------------------%%
semi.LRman    = {0,'%'};         %learning rate for monopile manufacturing %%
semi.LRinst   = {0,'%'};         %learning rate for jacket installation %%
semi.Nref     = 3;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
semi.nMoor  = 3;                    %number of pin-piles per WTG jacket %%
semi.rMoor  = {750,'m'};            
semi.moorType = 'chain';
semi.anchType = 'drag';
%%-----------------------------------------------------------------------%%

drag.instVes = 'AHTS';
drag.hLoad = {3,'h'};
drag.hInstall = {144,'h'};
drag.hSurvey = {'6','h'};
drag.Naux = 2;
drag.fDecom   = {-25,'%'};               %time factor for decomissioning %%

drag.compSup  = 'self';       %component supply vessel during installation %%
drag.cost = 250000;

drag.LRinst   = {0,'%'};         %learning rate for jacket installation %%
drag.Nref     = 3;         %reference number of units for learning rate %%

%%-----------------------------------------------------------------------%%
%%------GRAVITY-BASED-SPECIFICATIONS-----------------------------------%%
%%-----------------------------------------------------------------------%%

GBF.cSteel   = {4500,strcat(char(8364),'/t')};     %GBF finished steel price %%
GBF.fMan     = 2/3;          %GBF manufacturing cost share %%
%%-----------------------------------------------------------------------%%
GBF.hLoadOut = {12,'h'};       %GBF quayside load-out time %%
%%-----------------------------------------------------------------------%%
GBF.hLaunch  = {24, 'h'};            %average GBF seabed launch time %%
GBF.hPrep    = {6,'h'};              %average GBF seabed preparation time %%
GBF.hBallast = {0,'h'};              %average GBF installation time %%
GBF.fDecom   = {-50,'%'};            %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
GBF.instVes  = 'AHTS';                  %GBF installation vessel %%
GBF.Ntug     = 2;                       %number of auxiliary tugs %%
GBF.ballVes  = 'OTB';      %component supply vessel during ballasting %%
GBF.compSup  = 'float';    %component supply vessel during installation %%
GBF.vTow     = {3,'kn'};    
GBF.launch   = 'subBarge';  %component supply vessel during launching%%

%%-----------------------------------------------------------------------%%
GBF.LRman    = {0,'%'};         %learning rate for GBF manufacturing %%
GBF.LRinst   = {5,'%'};         %learning rate for GBF installation %%
GBF.Nref     = 5;         %reference number of units for learning rate %%

