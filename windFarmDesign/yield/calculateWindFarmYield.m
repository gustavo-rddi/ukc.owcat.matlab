function o = calculateWindFarmYield(o, data, stocVar, markMods)

%determine availability of array cables (incl. ring redundancy)%
fAvailArray = 1 - (1 - data.array.fAvail)*(1 - 0.5*strcmpi(o.design.arrConf, 'ring'));

switch upper(o.OWF.expType)
    
    case 'HVAC'; 
        
        %detemine availability of standard HVAC export system%
        fAvailExp = data.(o.design.expConf).fAvail * data.HVAC.fAvailSS;
        
        %include availability of compensation substations%
        if o.design.lfComp; fAvailExp = fAvailExp * data.HVAC.fAvailSS; end
        if o.design.osComp; fAvailExp = fAvailExp * data.OHVS.fAvail; end
            
    case 'HVDC';
        
        %detemine availability of standard HVDC export system%
        fAvailExp = data.OHVS.fAvail * data.VSC.fAvail * data.HVAC.fAvailSS;
   
    case 'MVAC';
        
        fAvailExp = 1;
        
end

%determine OWF wake losses%
o.OWF.lWake = WTGwakeLosses(o.OWF.nWTG, o.design.fSpace);

%Add conservative points on OWF wake losses%
% o.OWF.lWake = o.OWF.lWake +o.OWF.lWakeconservative;
    
%apply any stochastic and market modifiers to OWF wake losses%
o.OWF.lWake = o.OWF.lWake * scenarioModifier('OWF.lWake', stocVar, markMods);

%get array efficiency for all wind turbines%
idealYield = [o.WTG.idealYield];
effArray = [o.arrayString([o.WTG.stringCon]).effString];

%determine ideal gross yield of entire wind farm%
idealOWFyield = sum(reshape(idealYield, numel(idealYield)/o.OWF.nWTG, o.OWF.nWTG),2)';

%determine ideal electrical yield of entire wind farm%
idealOWFyieldElec = sum(reshape(idealYield.*effArray, numel(idealYield)/o.OWF.nWTG, o.OWF.nWTG),2)';

%calculate annual gross and net wind farm AEP%
o.OWF.AEPgross = idealOWFyield * (1 - o.OWF.lWake);
o.OWF.AEPnet = idealOWFyieldElec * (1 - o.OWF.lWake) * data.WTG.fAvail*fAvailArray*fAvailExp;

%determine OWF annual yield vector%
o.OWF.annYield = o.OWF.AEPnet .* (1 - data.WTG.fDegr).^max(0, o.OWF.yrProj - o.OWF.yrOper);

%determine OWF yield during commissioning years%
yrComm = (o.OWF.yrProj >= o.OWF.yrOper-o.OWF.nComm) & (o.OWF.yrProj < o.OWF.yrOper);
o.OWF.annYield(yrComm) = o.OWF.annYield(yrComm) .* ((1:o.OWF.nComm) - 3/4)/o.OWF.nComm;

%determine mean gros and net wind farm AEP%
o.OWF.AEPgross = sum(o.OWF.AEPgross)/sum(o.OWF.AEPgross~=0);
o.OWF.AEPnet = sum(o.OWF.AEPnet)/sum(o.OWF.AEPnet~=0);



%determine wind farm capacity factor%
o.OWF.fCap = o.OWF.AEPnet / (o.OWF.cap*SImultiplier('yr'));

if strcmpi(o.finance.type, 'project')
    
    %get array efficiency for all wind turbines%
    idealYieldP90 = [o.WTG.idealYieldP90];
    effArrayP90 = [o.arrayString([o.WTG.stringCon]).effStringP90];
    
    %determine ideal gross yield of entire wind farm%
    idealOWFyieldP90 = sum(reshape(idealYieldP90, numel(idealYieldP90)/o.OWF.nWTG, o.OWF.nWTG),2)';
    
    %determine ideal electrical yield of entire wind farm%
    idealOWFyieldElecP90 = sum(reshape(idealYieldP90.*effArrayP90, numel(idealYieldP90)/o.OWF.nWTG, o.OWF.nWTG),2)';
    
    %calculate annual gross and net wind farm AEP%
    o.OWF.AEPgrossP90 = idealOWFyieldP90 * (1 - o.OWF.lWake);
    o.OWF.AEPnetP90 = idealOWFyieldElecP90 * (1 - o.OWF.lWake) * data.WTG.fAvail*fAvailArray*fAvailExp;

    %determine OWF annual yield vector%
    o.OWF.annYieldP90 = o.OWF.AEPnetP90 .* (1 - data.WTG.fDegr).^max(0, o.OWF.yrProj - o.OWF.yrOper);
    
    %determine OWF yield during commissioning years%
    yrComm = (o.OWF.yrProj >= o.OWF.yrOper-o.OWF.nComm) & (o.OWF.yrProj < o.OWF.yrOper);
    o.OWF.annYieldP90(yrComm) = o.OWF.annYieldP90(yrComm) .* ((1:o.OWF.nComm) - 3/4)/o.OWF.nComm;
    
    %determine mean gros and net wind farm AEP%
    o.OWF.AEPgrossP90 = sum(o.OWF.AEPgrossP90)/sum(o.OWF.AEPgrossP90~=0);
    o.OWF.AEPnetP90 = sum(o.OWF.AEPnetP90)/sum(o.OWF.AEPnetP90~=0);

    %determine wind farm capacity factor%
    o.OWF.fCapP90 = o.OWF.AEPnetP90 / (o.OWF.cap*SImultiplier('yr'));
    
end