function econ = economicSpecifications()

%%-----------------------------------------------------------------------%%
%%------GENERAL-ECONOMIC-SPECIFICATIONS----------------------------------%%
%%-----------------------------------------------------------------------%%
econ.contCon = {12,'%'};           %construction contingency requirement %%
econ.contOp  = {0,'%'};              %operation contingency requirement %%
%%-----------------------------------------------------------------------%%
econ.fInsCAR = {0.50,'%'};           %contractor-all-risk insurance rate %%
econ.fInsDSU = {3.00,'%'};              %delayed start-up insurance rate %%
econ.fInsPD  = {0.25,'%'};               %property damage insurance rate %%
econ.fInsBI  = {1.25,'%'};            %loss-of-production insurance rate %%
%%-----------------------------------------------------------------------%%
econ.discPPA = {10,'%'};              %discount on PPA offtake agreement %%
%%-----------------------------------------------------------------------%%
econ.fArr    = {1.0,'%'};
econ.fComm   = {1.5,'%'};

econ.yrDRA   = 10;
econ.iRes    = {1.5,'%'};
%%-----------------------------------------------------------------------%%
econ.fDebtMax = {70,'%'};      %debt share during construction (PF) %%
econ.DSCRtarg = 1.4;


%%-----------------------------------------------------------------------%%
%%------UK-SPECIFIC-ITEMS------------------------------------------------%%
%%-----------------------------------------------------------------------%%
econ.UK.curr    = 'GBP';                            %local currency unit %%
%%-----------------------------------------------------------------------%%
econ.UK.yrReal  = 2022;         %reference year for real cashflow values %%
econ.UK.yrPrice = 2022;        %reference year for subsidy/market prices %%
%%-----------------------------------------------------------------------%%
econ.UK.nCFD    = 15;                %number of years of subsidy revenue %%
%%-----------------------------------------------------------------------%%
econ.UK.taxCorp = {20,'%'};                        %corporation tax rate %%
econ.UK.taxIns  = {6,'%'};                   %insurance premium tax rate %%
econ.UK.SBlease = {0,'%'};                       %seabed lease royalties %%
%%-----------------------------------------------------------------------%%
econ.UK.Pwhole  = {35.0,'£/MWh'};  %wholesale price (for reference year) %%
econ.UK.grWhole = {1.0,'%'};                %real wholesale price growth %%
econ.UK.mitFees = {2627,'£/MW'};   %annual mitigation payments (indexed) %%
%%-----------------------------------------------------------------------%%
econ.UK.CArate  = {18,'%'};       %capital allowance rate (depreciation) %%
%%-----------------------------------------------------------------------%%
econ.UK.recOFTO = {95,'%'};             %recoverable OFTO CAPEX fraction %%
econ.UK.IDCcap  = {7,'%'};                   %cap on IDC for OFTO resale %%
%%-----------------------------------------------------------------------%%

%%-----------------------------------------------------------------------%%
%%------FRANCE-SPECIFIC-ITEMS--------------------------------------------%%
%%-----------------------------------------------------------------------%%
econ.FR.curr    = 'EUR';                            %local currency unit %%
%%-----------------------------------------------------------------------%%
econ.FR.yrReal  = 2022;         %reference year for real cashflow values %%
econ.FR.yrPrice = 2022;        %reference year for subsidy/market prices %%
%%-----------------------------------------------------------------------%%
econ.FR.nSub    = 20;                %number of years of subsidy revenue %%
%%-----------------------------------------------------------------------%%
econ.FR.taxCorp = 0.3; %1/3;                             %corporation tax rate %%
econ.FR.taxIns  = {9,'%'};                   %insurance premium tax rate %%
econ.FR.sCharge = 0; %{3.3,'%'};                      %social surcharge rate %%
%%-----------------------------------------------------------------------%%
econ.FR.Pwhole  = {45.0,'€/MWh'};  %wholesale price (for reference year) %%
econ.FR.grWhole = {2,'%'};                %real wholesale price growth %%
econ.FR.OWtax   = {14148*1.075,'€/MW'};    %annual offshore wind tax (indexed) %%
%%-----------------------------------------------------------------------%%
econ.FR.accDepr = 2.25;                 %accelerated depreciation factor %%
%%-----------------------------------------------------------------------%%
econ.FR.ROEcap  = {7.25,'%'};            %max. ROI for connection assets %%
%%-----------------------------------------------------------------------%%
econ.FR.trSale  = false;                  %allow transmission asset sale %%
econ.FR.IRRtran = {5,'%'};                %allow transmission asset sale %%
%%-----------------------------------------------------------------------%%