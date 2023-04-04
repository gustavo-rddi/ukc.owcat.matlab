function array = arraySpecifications()

%%-----------------------------------------------------------------------%%
%%------ARRAY-CABLE-SPECIFICATIONS---------------------------------------%%
%%-----------------------------------------------------------------------%%
array.fSlack  = {2,'%'};              %additional length due to slacking %%
array.lInt    = {40,'m'};           %additional length for WTG interface %%
array.fSpare  = {8.5,'%'};                  %spare cable length to order %%
%%-----------------------------------------------------------------------%%
array.hPrep   = {12,'h'};  %average time to prepare section installation %%
array.hPullIn = {6,'h'};       %average time to pull-in single cable end %%
array.hTerm   = {12,'h'};       %average time for cable end  termination %%
%%-----------------------------------------------------------------------%%
array.LRinst  = {5,'%'};           %learning rate for cable installation %%
array.LRterm  = {10,'%'};           %learning rate for cable termination %%
array.Nref    = 74;         %reference number of units for learning rate %%
%%-----------------------------------------------------------------------%%
array.fAvail  = {99,'%'};                 %electrical array availability %%
%%-----------------------------------------------------------------------%%
array.AmaxCu  = 630;                     %maximum cable section (copper) %%
array.AmaxAl  = 800;                  %maximum cable section (aluminium) %%
%%-----------------------------------------------------------------------%%
%%-----------------------------------------------------------------------%%

%available cable sections for array%
array.Asect = [95 150 300 400 500 630 800];