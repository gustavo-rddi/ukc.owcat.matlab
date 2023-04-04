function model = modellingConstants()

%%-----------------------------------------------------------------------%%
%%------MODELLING-CONSTANTS----------------------------------------------%%
%%-----------------------------------------------------------------------%%
model.maxIter  = 50;                  %maximum internal model iterations %%
model.tolConv  = 1e-6;                      %model convergence tolerance %%
%%-----------------------------------------------------------------------%%
model.hWindRef = {100,'m'};             %reference height for wind speed %%
model.lRough   = {2e-4,'m'};                      %site roughness length %%
%%-----------------------------------------------------------------------%%