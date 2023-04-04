function [vessel, equip, crew] = vesselSpecifications()

%%-----------------------------------------------------------------------%%
%%------GENERAL-SPECIFICATIONS-------------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.curr  = 'EUR';                 %stated currency for vessel prices %%
vessel.yrRef =  2021;                  %reference year for vessel prices %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------SELF-PROPELLED-JACK-UP-VESSEL------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.SPJU.dayRate  = {161000,'¤/day'};         %vessel active day-rate %%
vessel.SPJU.redStand = {-25,'%'};           %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.SPJU.vTravel  = {9.9,'kn'};                   %vessel transit speed %%
vessel.SPJU.vMove  = {9.9,'kn'};     %vessel transit speed between WTG %%
vessel.SPJU.hPos     = {8,'h'};       %vessel positioning time (jacking) %%
vessel.SPJU.nMob     = {14,'day'};             %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.SPJU.wOp      = {75,'%'};             %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.SPJU.cap.WTG  = 4;                %carrying capacity (small WTGs) %%
vessel.SPJU.cap.MP   = 4;            %carrying capacity (std. monopiles) %%
vessel.SPJU.cap.TP   = 4;             %carrying capacity (trans. pieces) %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------HEAVY-LIFT-JACK-UP-VESSEL----------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.HLJU.dayRate  = {221000,'¤/day'};                %vessel day-rate %%
vessel.HLJU.redStand = {-25,'%'};           %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.HLJU.vTravel  = {9.1,'kn'};                   %vessel transit speed %%
vessel.HLJU.vMove  = {4,'kn'};         %vessel transit speed between WTG%%
vessel.HLJU.hPos     = {9,'h'};       %vessel positioning time (jacking) %%
vessel.HLJU.nMob     = {14,'day'};             %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.HLJU.wOp      = {75,'%'};             %operational weather window %%
%%------------------9-----------------------------------------------------%%
vessel.HLJU.cap.WTG  = 4;                %carrying capacity (large WTGs) %%
vessel.HLJU.cap.MP   = 4;              %carrying capacity (XL monopiles) %%
vessel.HLJU.cap.TP   = 4;          %carrying capacity (XL trans. pieces) %%
vessel.HLJU.cap.sJKT = 3;               %carrying capacity (WTG jackets) %%
vessel.HLJU.cap.OTM  = 1;             %carrying capacity (OTM equipment) %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------HEAVY-LIFT-DYNAMIC-POSITIONING-VESSEL----------------------------%%
%%-----------------------------------------------------------------------%%
vessel.HLDP.dayRate  = {347490,'¤/day'};                %vessel day-rate %%
vessel.HLJU.redStand = {-25,'%'};           %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.HLDP.vTravel  = {10,'kn'};                  %vessel transit speed %%
vessel.HLDP.vMove  = {10,'kn'};      %vessel transit speed between WTG %%
vessel.HLDP.hPos     = {1,'h'};       %vessel positioning time (DP-mode) %%
vessel.HLDP.nMob     = {14,'day'};             %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.HLDP.wOp      = {70,'%'};             %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.HLDP.cap.MP   = 4;                 %carrying capacity (monopiles) %%
vessel.HLDP.cap.TP   = 4;             %carrying capacity (trans. pieces) %%
vessel.HLDP.cap.sJKT = 4;               %carrying capacity (WTG jackets) %%
vessel.HLDP.cap.PP   = 24;                 %carrying capacity (pin-pile) %%
vessel.HLDP.cap.OTM  = 2;             %carrying capacity (OTM equipment) %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------SHEERLEG-CRANE-VESSEL--------------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.SCV.dayRate   = {290000,'¤/day'};                %vessel day-rate %%
vessel.SCV.redStand  = {-25,'%'};           %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.SCV.vTravel  = {6,'kn'};                    %vessel transit speed %%
vessel.SCV.vMove  = {6,'kn'};        %vessel transit speed between WTG%%
vessel.SCV.hPos     = {3,'h'};        %vessel positioning time (DP-mode) %%
vessel.SCV.nMob     = {7,'day'};              %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.SCV.wOp      = {65,'%'};              %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.SCV.cap.WTG  = 1;                       %carrying capacity (WTGs) %%
vessel.SCV.cap.OHVS = 1;                      %carrying capacity (OHVSs) %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------CABLE-LAYING-VESSEL----------------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.CLV.dayRate  = {135000,'¤/day'};                  %vessel day-rate %%
vessel.CLV.redStand = {-25,'%'};            %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.CLV.vTravel  = {8.9,'kn'};                    %vessel transit speed %%
vessel.CLV.vMove  = {8.9,'kn'};       %vessel transit speed between WTG%%
vessel.CLV.hPos     = {1,'h'};        %vessel positioning time (DP-mode) %%
vessel.CLV.nMob     = {3,'day'};              %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.CLV.wOp      = {65,'%'};              %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.CLV.vLaySimp = {200,'m/h'}; %cable laying speed for simple soil %%
vessel.CLV.vLayComp = {75, 'm/h'}; %cable laying speed for complex soil %%
%%-----------------------------------------------------------------------%%


%%-----------------------------------------------------------------------%%
%%------CABLE-LAYING-VESSEL-Stemat Spirit for Blyth----------------------%%
%%-----------------------------------------------------------------------%%
vessel.Stemat.dayRate  = {121620,'¤/day'};                  %vessel day-rate %%
vessel.Stemat.redStand = {-25,'%'};            %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.Stemat.vTravel  = {9,'kn'};                    %vessel transit speed %%
vessel.Stemat.vMove  = {9,'kn'};       %vessel transit speed between WTG%%
vessel.Stemat.hPos     = {0,'h'};     %vessel positioning time included in cable laying speed (DP-mode) %%
vessel.Stemat.nMob     = {3,'day'};              %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.Stemat.wOp      = {65,'%'};              %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.Stemat.vLay     = {60,'m/h'};                   %cable laying speed %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------OFFSHORE-CONSTRUCTION-VESSEL-------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.OCV.dayRate  = {125000,'¤/day'};                 %vessel day-rate %%
vessel.OCV.redStand = {-25,'%'};            %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.OCV.vTravel  = {12,'kn'};                   %vessel transit speed %%
vessel.OCV.vMove  = {12,'kn'};          %vessel transit speed between WTG%%
vessel.OCV.hPos     = {1,'h'};        %vessel positioning time (DP-mode) %%
vessel.OCV.nMob     = {7,'day'};              %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.OCV.wOp      = {70,'%'};              %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.OCV.vLay     = {150,'m/h'};                   %cable laying speed %%
vessel.OCV.vTrench  = {50,'m/h'};                 %cable trenching speed %%
vessel.OCV.vSimul   = {35,'m/h'};       %simultaneous lay and bury speed %%
%%-----------------------------------------------------------------------%%
vessel.OCV.hLaunch  = {2,'h'};                 %ROV launch/recovery time %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------ROCK-DUMPING-VESSEL----------------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.RDV.dayRate  = {75290,'¤/day'};                  %vessel day-rate %%
vessel.RDV.redStand = {-50,'%'};            %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.RDV.vTravel  = {12,'kn'};                   %vessel transit speed %%
vessel.RDV.vMove  = {12,'kn'};        %vessel transit speed between WTG%%
vessel.RDV.hPos     = {1,'h'};        %vessel positioning time (DP-mode) %%
vessel.RDV.nMob     = {3,'day'};               %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.RDV.wOp      = {70,'%'};              %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.RDV.capSP    = {6500,'t'};            %material carrying capacity %%
vessel.RDV.vLoad    = {1500,'t/h'};              %material loading speed %%
vessel.RDV.vInst    = {250,'t/h'};          %material installation speed %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------OFFSHORE-TRANSPORT-BARGE-(AND-TUGS)------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.OTB.dayRate  = {23166,'¤/day'};                  %vessel day-rate %%
vessel.OTB.redStand = {-75,'%'};            %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.OTB.vTravel  = {7.8,'kn'};                   %vessel transit speed %%
vessel.OTB.vMove  = {7.8,'kn'};      %vessel transit speed between WTG%%
vessel.OTB.nMob     = {14,'day'};               %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.OTB.wOp      = {55,'%'};              %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.OTB.cap.WTG  = 4;              %carrying capacity (wind turbines) %%
vessel.OTB.cap.MP   = 6;                  %carrying capacity (monopiles) %%
vessel.OTB.cap.TP   = 8;              %carrying capacity (trans. pieces) %%
vessel.OTB.cap.sJKT = 4;                %carrying capacity (WTG jackets) %%
vessel.OTB.cap.hJKT = 2;              %carrying capacity (heavy jackets) %%
vessel.OTB.cap.PP   = 18;                  %carrying capacity (pin-pile) %%
vessel.OTB.cap.OTM  = 4;              %carrying capacity (OTM equipment) %%
vessel.OTB.cap.OHVS = 2;              %carrying capacity (OHVS topsides) %%
vessel.OTB.cap.VSC = 1;               %carrying capacity (OHVS topsides) %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------PLATFORM-SUPPLY-VESSEL-------------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.PSV.dayRate  = {86873,'¤/day'};                  %vessel day-rate %%
vessel.PSV.redStand = {-50,'%'};            %reduced rate during standby %%
%%-----------------------------------------------------------------------%%
vessel.PSV.vTravel  = {11.7,'kn'};                   %vessel transit speed %%
vessel.PSV.vMove  = {11.7,'kn'};     %vessel transit speed between WTG%%
vessel.PSV.nMob     = {2,'day'};               %vessel mobilisation time %%
%%-----------------------------------------------------------------------%%
vessel.PSV.wOp      = {70,'%'};              %operational weather window %%
%%-----------------------------------------------------------------------%%
vessel.PSV.cap.PP   = 6;                   %carrying capacity (pin-pile) %%
vessel.PSV.cap.OTM  = 1;              %carrying capacity (OTM equipment) %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------AUXILIARY-VESSELS------------------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.AHTS.dayRate = {28958,'¤/day'};     %anchor handling tug day-rate %%
vessel.AHTS.vTravel  = {12,'kn'};                   %vessel transit speed %%
vessel.AHTS.vMove  = {12,'kn'};       %vessel transit speed between WTG%%
vessel.AHTS.hPos     = {1,'h'};        %vessel positioning time (DP-mode) %%
vessel.AHTS.wOp      = {70,'%'};             %operational weather window %%
vessel.AHTS.cap.drag = 6;
vessel.AHTS.nMob = {7,'day'};

%%-----------------------------------------------------------------------%%
%%------AUXILIARY-VESSELS------------------------------------------------%%
%%-----------------------------------------------------------------------%%
vessel.CTV.dayRate  = {4050,'¤/day'};     %crew transfer vessel day-rate %%
vessel.ATV.dayRate  = {11583,'¤/day'};    %auxiliary tug vessel day-rate %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------OFFSHORE-CREWS-COSTS---------------------------------------------%%
%%-----------------------------------------------------------------------%%
crew.prep.dayRate = {23166,'¤/day'};    %pull-in and prep. crew day-rate %%
crew.term.dayRate = {63707,'¤/day'};    %cable termination crew day-rate %%
crew.comm.dayRate = {86873,'¤/day'};        %commissioning crew day-rate %%   
crew.dive.dayRate = {28958,'¤/day'};               %diving crew day-rate %%
%%-----------------------------------------------------------------------%%         

%-----------------------------------------------------------------------%%
%------ADDITIONAL-EQUIPMENT-COSTS---------------------------------------%%
%-----------------------------------------------------------------------%%
% For MP
equip.hammerMP = {28958,'¤/day'};  
equip.drillMP = {46332,'¤/day'};  

% For PP
equip.hammerPP = {13900,'¤/day'};  
equip.drillPP = {34749,'¤/day'}; 

% For JKT and TP
equip.grout = {46332,'¤/day'};  

%%-----------------------------------------------------------------------%%
equip.crane = {5791.5,'¤/day'};
equip.subBarge = {11583,'¤/day'};

% %%-----------------------------------------------------------------------%%
% %%------ADDITIONAL-EQUIPMENT-COSTS---------------------------------------%%
% %%-----------------------------------------------------------------------%%
% equip.hammer = {12000,'¤/day'};                  %piling hammer day-rate %%
% equip.grout  = {40000,'¤/day'};             %grouting equipment day-rate %%
% equip.drill  = {65000,'¤/day'};             %drilling equipment day-rate %%
% %%-----------------------------------------------------------------------%%
% equip.crane = {5000,'¤/day'};
% equip.subBarge = {10000,'¤/day'};