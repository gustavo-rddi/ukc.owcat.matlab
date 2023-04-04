function [fnd, MP, TP, sJKT, hJKT, PP, GBF, semiS, sparS, tlpS, brgC, brgS, moor, drag, rope, pileAnch] = foundationSpecifications()

%%-----------------------------------------------------------------------%%
%%------GENERAL-SPECIFICATIONS-------------------------------------------%%
%%-----------------------------------------------------------------------%%
fnd.curr   = 'EUR';      %stated currency for steel manufacturing prices %%
fnd.yrRef  =  2021;       %reference year for steel manufacturing prices %%
%%-----------------------------------------------------------------------%%
fnd.fManSS = 4/5;              %secondary steel manufacturing cost share %%
%%-----------------------------------------------------------------------%%
fnd.cScour = {40,'¤/t'};                %scour protection material price %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%-------MONOPILE-SPECIFICATIONS-----------------------------------------%%
%%-----------------------------------------------------------------------%%
MP.cSteel   = {1230,'¤/t'};               %monopile finished steel price %%
% MP.cSecSteel = {750000,'¤'};     %monopile secondary steel price per unit%%
% MP.cFit = {900000,'¤'};                  %monopile fittings cost per unit%%
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
MP.Nref     = 50;           %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
MP.mSPmat   = {2000,'t'};            %required scour protection material %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%-------TRANSITION-PIECE-SPECIFICATIONS---------------------------------%%
%%-----------------------------------------------------------------------%%
TP.cSteel   = {1723,'¤/t'};       %transition piece finished steel price %%
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
TP.Nref     = 50;           %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------SMALL-(WTG)-JACKET-SPECIFICATIONS--------------------------------%%
%%-----------------------------------------------------------------------%%
sJKT.cSteel   = {3400,'¤/t'};           %WTG jacket finished steel price %%
sJKT.fMan     = 2/3;                %WTG jacket manufacturing cost share %%
% sJKT.cSecSteel = {240325,'¤'}; %WTG jacket secondary steel cost per unit %%
% sJKT.cFit = {545969,'¤'};              %WTG jacket fittings cost per unit%%
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
sJKT.Nref     = 50;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
sJKT.nPP      = 4;                   %number of pin-piles per WTG jacket %%
sJKT.mSPmat   = {850,'t'};           %required scour protection material %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------HEAVY-(SUBSTATION)-JACKET-SPECIFICATIONS-------------------------%%
%%%----------------------------------------------------------------------%%
hJKT.cSteel   = {3400,'¤/t'};         %heavy jacket finished steel price %%
hJKT.fMan     = 3/4;              %heavy jacket manufacturing cost share %%
% hJKT.cSecSteel = {240325,'¤'};%heavy jacket secondary steel cost per unit%%
% hJKT.cFit = {545969,'¤'};            %heavy jacket fittings cost per unit%%
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
PP.cSteel   = {1257,'¤/t'};               %pin-pile finished steel price %%
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
PP.Nref     = 200;           %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------GRAVITY-BASED-SPECIFICATIONS-----------------------------------%%
%%-----------------------------------------------------------------------%%

GBF.cSteel   = {4500,'¤/t'};     %GBF finished steel price %%
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

%%-----------------------------------------------------------------------%%
%%------SEMISUBMERSIBLE-STEEL-SPECIFICATIONS-----------------------------------%%
%%-----------------------------------------------------------------------%%
semiS.cSteel   = {1000,'¤/t'}; %semi-sub steel floater finished steel price 2020 prices, mid 2021 €4800/t%%
semiS.cSecSteel = {3500,'¤/t'}; %Steel semi-sub secondary steel unit cost %%
semiS.cCorrProt = {4370,'¤/t'}; %Steel semi-sub corrosion protection unit cost%%
semiS.cCoating = {92.2,'¤/m2'}; %Coating corrosion protection%%
semiS.cConcr   = {0,'¤/t'};      %No concrete modelled for semi sub steel%%
semiS.cBall   = {0,'¤/t'};      %water used as ballast for steel semi sub%%
semiS.cLoadOut = {100,'¤/t'}; %Load out unit cost%%
semiS.fMan     = 2/3;         %semi-sub floater manufacturing cost share %%
semiS.hr     = {6400,'pmonth'};  %semi-sub manufacturing person month per unit%%
%%-----------------------------------------------------------------------%%
semiS.hLoadOut = {24,'h'};       %time taken to get structure into water for port side installation/ life structure onto barge for offshore installation%%
%%-----------------------------------------------------------------------%%
semiS.hLaunch  = {24, 'h'};
semiS.hAsbuilt  = {3, 'h'};
semiS.hPrep    = {6,'h'};          %average WTG jacket installation time %%
semiS.hHookUp  = {7,'h'};          %hook up time & tensioning per mooring line%%
semiS.hBallast = {0,'h'};
semiS.hInstallOS = {24,'h'}; %time taken to life foundation from barge into water%%
semiS.fDecom   = {-50,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
semiS.instVes  = 'AHTS';                 %WTG jacket installation vessel %%
semiS.Ntug     = 2;                            %number of auxiliary tugs %%
semiS.ballVes  = 'OTB';
semiS.TranspVes  = 'SST';             %Semi submersible Transport vessel %%
semiS.AssemblyOS = 'WIV';     %Crane barge for positioning WTG onto floater
semiS.compSup  = 'self';    %supply vessel during port side installation %%
semiS.compSupOS  = 'ATV';    %supply vessel during offshore installation %%
semiS.vTow     = {3,'kn'};
semiS.launch   = 'subBarge';
%%-----------------------------------------------------------------------%%
semiS.LRman    = {2,'%'}; %learning rate for steel semisub manufacturing %%
semiS.LRinst   = {2,'%'};         %learning rate for jacket installation %%
semiS.Nref     = 27;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
semiS.rMoor  = {750,'m'};            
semiS.cChain = {500,'€/m'};
semiS.cRope = {200,'€/m'};
semiS.mblChain = {500, 'N'};
semiS.mblRope = {500, 'N'};
semiS.nBuoy = 1;
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------SPAR-STEEL-SPECIFICATIONS----------------------------------------%%
%%-----------------------------------------------------------------------%%
sparS.cSteel   = {2860,'¤/t'};     %steel spar floater finished steel price pre pandemic levels%%
sparS.cConcr   = {0,'¤/t'};      %No concrete modelled for steel spar%%
sparS.cBall   = {33.9,'¤/t'};  %concrete ballast depending WTG rating, estimated in floaterBallastCost module%%
sparS.fMan     = 2/3;          %semi-sub floater manufacturing cost share %%
%%-----------------------------------------------------------------------%%
sparS.hLoadOut = {24,'h'};       %time taken to get structure into water for port side installation/ life structure onto barge for offshore installation%%
%%-----------------------------------------------------------------------%%
sparS.hLaunch  = {24, 'h'};
sparS.hPrep    = {6,'h'};          %average WTG jacket installation time %%
sparS.hHookUp  = {11.5,'h'};          %hook up time & tensioning per mooring line %%
sparS.hBallast = {0,'h'};
sparS.hInstallOS = {24,'h'}; %time taken to life foundation from barge into water%%
sparS.fDecom   = {-50,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
sparS.instVes  = 'AHTS';                  %WTG jacket installation vessel %%
sparS.Ntug     = 2;           %number of auxiliary tugs %%
sparS.ballVes  = 'OTB';
sparS.compSup  = 'self';     %supply vessel during port side installation %%
sparS.compSupOS  = 'OTB';    %supply vessel during offshore installation %%
sparS.vTow     = {3,'kn'};
sparS.launch   = 'subBarge';
%%-----------------------------------------------------------------------%%
sparS.LRman    = {10,'%'};         %learning rate for monopile manufacturing %%
sparS.LRinst   = {5,'%'};         %learning rate for jacket installation %%
sparS.Nref     = 10;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
sparS.rMoor  = {750,'m'};            
sparS.cChain = {500,'€/m'};
sparS.cRope = {200,'€/m'};
sparS.mblChain = {500, 'N'};
sparS.mblRope = {500, 'N'};
sparS.nBuoy = 1;
%%-----------------------------------------------------------------------%%


%%-----------------------------------------------------------------------%%
%%------TENSION-LEG-PLATFORM-STEEL-SPECIFICATIONS------------------------%%
%%-----------------------------------------------------------------------%%
tlpS.cSteel   = {4080,'¤/t'}; %tlp steel floater finished steel price 2020 prices, mid 2021 1.2*€4800/t, 20% premium compared to steel semisub assumed%%
tlpS.cConcr   = {0,'¤/t'};      %No concrete modelled for steel tlp%%
tlpS.cBall   = {0,'¤/t'};      %no ballast used in tlp substructure%%
tlpS.fMan     = 2/3;         %semi-sub floater manufacturing cost share %%
%%-----------------------------------------------------------------------%%
tlpS.hLoadOut = {24,'h'};       %time taken to get structure into water for port side installation/ life structure onto barge for offshore installation%%
%%-----------------------------------------------------------------------%%
tlpS.hLaunch  = {24, 'h'};
tlpS.hPrep    = {6,'h'};          %average WTG jacket installation time %%
tlpS.hHookUp  = {11.5,'h'};          %hook up time & tensioning per mooring line %%
tlpS.hBallast = {0,'h'};
tlpS.hInstallOS = {24,'h'}; %time taken to life foundation from barge into water%%
tlpS.fDecom   = {-50,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
tlpS.instVes  = 'AHTS';                  %WTG jacket installation vessel %%
tlpS.Ntug     = 2;           %number of auxiliary tugs %%
tlpS.ballVes  = 'OTB';
tlpS.compSup  = 'self';       %supply vessel during port side installation %%
tlpS.compSupOS  = 'OTB';      %supply vessel during offshore installation %%
tlpS.vTow     = {3,'kn'};
tlpS.launch   = 'subBarge';
%%-----------------------------------------------------------------------%%
tlpS.LRman    = {10,'%'}; %learning rate for steel semisub manufacturing %%
tlpS.LRinst   = {5,'%'};         %learning rate for jacket installation %%
tlpS.Nref     = 10;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
tlpS.rMoor  = {750,'m'};            
tlpS.cChain = {500,'€/m'};
tlpS.cRope = {200,'€/m'};
tlpS.mblChain = {500, 'N'};
tlpS.mblRope = {500, 'N'};
tlpS.nBuoy = 1;
%%-----------------------------------------------------------------------%%
%%------BARGE-CONCRETE-SPECIFICATIONS---------------------0--------------%%
%%-----------------------------------------------------------------------%%
brgC.cSteel   = {720,'¤/t'};       %mid 2021 costs €1200, 30% premium EU HRC €900/t, pre pandemic EU HRC €550/t assumed %%
brgC.cSecSteel = {3500,'¤/t'}; %Steel semi-sub secondary steel unit cost %%
brgC.cCorrProt = {4370,'¤/t'}; %Steel semi-sub corrosion protection unit cost%%
brgC.cCoating = {92.2,'¤/m2'}; %Coating corrosion protection%%
brgC.cConcr   = {730,'¤/t'}; %concrete barge finished concrete price 2021%%
brgC.cBall   = {0,'¤/t'};                          %water used as ballast%%
brgC.cLoadOut = {100,'¤/t'};                          %Load out unit cost%%
brgC.fMan     = 2/3;         %semi-sub floater manufacturing cost share %%
brgC.hr     = {6400,'pmonth'};  %same as semi-sub manufacturing person month per unit%%
%%-----------------------------------------------------------------------%%
brgC.hLoadOut = {24,'h'};       %time taken to get structure into water for port side installation/ life structure onto barge for offshore installation%%
%%-----------------------------------------------------------------------%%
brgC.hLaunch  = {24, 'h'};
brgC.hAsbuilt  = {3, 'h'};
brgC.hPrep    = {6,'h'};          %average WTG jacket installation time %%
brgC.hHookUp  = {7,'h'};          %hook up time & tensioning per mooring line %%
brgC.hBallast = {0,'h'};
brgC.hInstallOS = {24,'h'}; %time taken to life foundation from barge into water%%
brgC.fDecom   = {-50,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
brgC.instVes  = 'AHTS';                  %WTG jacket installation vessel %%
brgC.Ntug     = 2;           %number of auxiliary tugs %%
brgC.ballVes  = 'OTB'; 
brgC.TranspVes  = 'SST';             %Semi submersible Transport vessel %%
brgC.compSup  = 'self';    %supply vessel during port side installation %%
brgC.compSupOS  = 'OTB';   %supply vessel during offshore installation %%
brgC.vTow     = {3,'kn'};
brgC.launch   = 'subBarge';
%%-----------------------------------------------------------------------%%
brgC.LRman    = {10,'%'}; %learning rate for steel semisub manufacturing %%
brgC.LRinst   = {5,'%'};         %learning rate for jacket installation %%
brgC.Nref     = 10;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
brgC.rMoor  = {750,'m'};            
brgC.cChain = {500,'€/m'};
brgC.cRope = {200,'€/m'};
brgC.mblChain = {500, 'N'};
brgC.mblRope = {500, 'N'};
brgC.nBuoy = 1;

%%-----------------------------------------------------------------------%%
%%------BARGE-STEEL-SPECIFICATIONS---------------------------------------%%
%%-----------------------------------------------------------------------%%
brgS.cSteel   = {3200,'¤/t'};  %2020 reference costs €3200/t pre pandemic%%
brgS.cConcr   = {0,'¤/t'};       %no concrete considered for steel barges%%
brgS.cBall   = {0,'¤/t'};        %water used as ballast%%
brgS.fMan     = 2/3;          %semi-sub floater manufacturing cost share %%
%%-----------------------------------------------------------------------%%
brgS.hLoadOut = {24,'h'};       %time taken to get structure into water for port side installation/ life structure onto barge for offshore installation%%
%%-----------------------------------------------------------------------%%
brgS.hLaunch  = {24, 'h'};
brgS.hAsbuilt  = {3, 'h'};
brgS.hPrep    = {6,'h'};          %average WTG jacket installation time %%
brgS.hHookUp  = {11.5,'h'};          %hook up & tensioning time per mooring line %%
brgS.hBallast = {0,'h'};
brgS.hInstallOS = {24,'h'}; %time taken to life foundation from barge into water%%
brgS.fDecom   = {-50,'%'};               %time factor for decomissioning %%
%%-----------------------------------------------------------------------%%
brgS.instVes  = 'AHTS';                  %WTG jacket installation vessel %%
brgS.Ntug     = 2;           %number of auxiliary tugs %%
brgS.ballVes  = 'OTB';
brgS.compSup  = 'self';    %supply vessel during port side installation %%
brgS.compSupOS  = 'OTB';   %supply vessel during offshore installation %%
brgS.vTow     = {3,'kn'};
brgS.launch   = 'subBarge';
%%-----------------------------------------------------------------------%%
brgS.LRman    = {10,'%'}; %learning rate for steel semisub manufacturing %%
brgS.LRinst   = {5,'%'};         %learning rate for jacket installation %%
brgS.Nref     = 10;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
brgS.rMoor  = {750,'m'};            
brgS.cChain = {500,'€/m'};
brgS.cRope = {200,'€/m'};
brgS.mblChain = {500, 'N'};
brgS.mblRope = {500, 'N'};
brgS.nBuoy = 1;

%%-----------------------------------------------------------------------%%
%%------STEEL-CHAIN-SPECIFICATIONS---------------------------------------%%
%%-----------------------------------------------------------------------%%
moor.fMan = 1/3;
moor.Nref = 81;
moor.LRman = {5, '%'};
moor.LRinst = {5, '%'};
moor.fDecom   = {-25,'%'};                 

%%-----------------------------------------------------------------------%%
%%------DRAG-ANCHOR-SPECIFICATIONS---------------------------------------%%
%%-----------------------------------------------------------------------%%
drag.cMan = {12, '€/kN'};
drag.fMan = 2/3;           
drag.Nref = 81;  %tbc%           
drag.LRman = {5, '%'};
drag.LRinst = {5, '%'};
drag.fDecom   = {-25,'%'}; 

%%-----------------------------------------------------------------------%%
%%------POLYESTER-ROPE-SPECIFICATIONS------------------------------------%%
%%-----------------------------------------------------------------------%%
rope.fMan = 1/3;            %inspired by pin pile%
rope.Nref = 81;             %cost per drilled pile benchmarked against PPI%
rope.LRman = {10, '%'};      
rope.LRinst = {5, '%'};     
rope.fDecom   = {-25,'%'}; 

%%-----------------------------------------------------------------------%%
%%------PILE-ANCHOR-SPECIFICATIONS--------------------------%%
%%-----------------------------------------------------------------------%%
pileAnch.cMan = {32,'€/kN'};
pileAnch.Nref = 81;             %cost per drilled pile benchmarked against PPI%
pileAnch.LRman = {1, '%'}; 
pileAnch.LRinst = {5, '%'};     %inspired by pin pile%
pileAnch.fMan   = 1/4; 
pileAnch.fDecom   = {-25,'%'}; 