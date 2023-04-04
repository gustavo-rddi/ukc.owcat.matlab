function o = offshoreStructuralMasses(o, ~, stocVar, markMods)

for i = 1 : o.OWF.nWTG
   
    %determine foundation type%
    switch lower(o.WTG(i).fndType)
        
        case 'monopile';
            
            %calculate monopile and transition piece masses%
            [o.WTG(i).mMP, o.WTG(i).mTP] = MPfoundationMass(o.WTG(i).dRot, o.WTG(i).dWater);
                        
            %apply any stochastic and market modifiers to foundation design%
            o.WTG(i).mMP = o.WTG(i).mMP * scenarioModifier('MP.mass', stocVar, markMods);
            o.WTG(i).mTP = o.WTG(i).mTP * scenarioModifier('TP.mass', stocVar, markMods);
            
        case 'jacket';
            
            %calculate jacket and pin-pile masses%
            [o.WTG(i).mJKT, o.WTG(i).mPP] = JKTfoundationMass(o.WTG(i).mHub+o.WTG(i).mTower, o.WTG(i).dWater);
            
            %apply any stochastic and market modifiers to foundation design%
            o.WTG(i).mJKT = o.WTG(i).mJKT * scenarioModifier('sJKT.mass', stocVar, markMods);
            o.WTG(i).mPP = o.WTG(i).mPP * scenarioModifier('PP.mass', stocVar, markMods);
            
        case 'semisub';
            
            %calculate jacket and pin-pile masses%
            o.WTG(i).mSS = SSfoundationMass(o.WTG(i).mHub+o.WTG(i).mTower, o.WTG(i).dRot);
                   
            o.WTG(i).mSS = o.WTG(i).mSS * scenarioModifier('SS.mass', stocVar, markMods);
            
    end
        
end

for i = 1 : o.OWF.nOSS
    
    switch upper(o.design.expConf)
        
        case {'OHVS', 'VSC'}
    
            %calculate mass of OHVS topside and jacket foundation%
            o.offshoreSS(i).mTopside = HVACtopsideMass(o.offshoreSS(i).nTrans*o.offshoreSS(i).capTrans, o.offshoreSS(i).Qoffshore, o.design.Vexport);
            [o.offshoreSS(i).mJKT, o.offshoreSS(i).mPP] = JKTfoundationMass(o.offshoreSS(i).mTopside, o.offshoreSS(i).dWater);
            
            %apply any stochastic and market modifiers to foundation design%
            o.offshoreSS(i).mJKT = o.offshoreSS(i).mJKT * scenarioModifier('hJKT.mass', stocVar, markMods);
            o.offshoreSS(i).mPP = o.offshoreSS(i).mPP * scenarioModifier('PP.mass', stocVar, markMods);
            
        case 'OTM'
            
            %calculate mass of OHVS topside%
            o.offshoreSS(i).mTopside = 630000;
            
            if ~o.OWF.fndShare
                
                %calculate jacket and pin-pile masses%
                [o.offshoreSS(i).mJKT, o.offshoreSS(i).mPP] = JKTfoundationMass(o.offshoreSS(i).mTopside, o.offshoreSS(i).dWater);
                
                %apply any stochastic and market modifiers to foundation design%
                o.offshoreSS(i).mJKT = o.offshoreSS(i).mJKT * scenarioModifier('sJKT.mass', stocVar, markMods);
                o.offshoreSS(i).mPP = o.offshoreSS(i).mPP * scenarioModifier('PP.mass', stocVar, markMods);
                
            else
                
                %determine shared WTG number%
                iWTGshare = o.offshoreSS(i).iWTGshare;
                
                %re-design WTG foundation to support added mass of OTM structure%
                [o.WTG(iWTGshare).mJKT, o.WTG(iWTGshare).mPP] = JKTfoundationMass(o.WTG(iWTGshare).mHub+o.WTG(iWTGshare).mTower+o.offshoreSS(i).mTopside, o.WTG(iWTGshare).dWater);
                
                %apply any stochastic and market modifiers to foundation design%
                o.WTG(iWTGshare).mJKT = o.WTG(iWTGshare).mJKT * scenarioModifier('sJKT.mass', stocVar, markMods);
                o.WTG(iWTGshare).mPP = o.WTG(iWTGshare).mPP * scenarioModifier('PP.mass', stocVar, markMods);
                
            end
            
    end
    
end

if o.design.osComp
    
    %calculate OCP topside mass%
    o.offshoreCP.mTopside = HVACtopsideMass(0, 2/3*o.offshoreCP.capComp, o.design.Vexport);
    [o.offshoreCP.mJKT, o.offshoreCP.mPP] = JKTfoundationMass(o.offshoreCP.mTopside, o.offshoreCP.dWater);
    
    %apply any stochastic and market modifiers to foundation design%
    o.offshoreCP.mJKT = o.offshoreCP.mJKT * scenarioModifier('hJKT.mass', stocVar, markMods);
    o.offshoreCP.mPP = o.offshoreCP.mPP * scenarioModifier('PP.mass', stocVar, markMods);
    
end

if strcmpi(o.design.expConf, 'VSC')

    for i = 1 : o.OWF.nConv
        
        o.offshoreConv(i).mTopside = 10000000;
       
        %calculate jacket and pin-pile masses%
        [o.offshoreConv(i).mJKT, o.offshoreConv(i).mPP] = JKTfoundationMass(o.offshoreConv(i).mTopside, o.offshoreConv(i).dWater);
        
    end
    
end