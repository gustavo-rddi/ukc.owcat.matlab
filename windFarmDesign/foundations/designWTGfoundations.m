function o = designWTGfoundations(o, ~, stocVar, markMods)

for i = 1 : o.OWF.nWTG
   
    %determine foundation type%
    switch lower(o.WTG(i).fndType)
        
        case 'monopile';
            
            %calculate monopile and transition piece masses%
            [o.WTG(i).mMP, o.WTG(i).mTP] = MPfoundationMass(o.WTG(i).hHub, o.WTG(i).dRot, o.WTG(i).dWater);
                        
            %apply any stochastic and market modifiers to foundation design%
            o.WTG(i).mMP = o.WTG(i).mMP * scenarioModifier('MP.mass', stocVar, markMods);
            o.WTG(i).mTP = o.WTG(i).mTP * scenarioModifier('TP.mass', stocVar, markMods);
            
        case 'jacket';
            
            %calculate jacket and pin-pile masses%
            [o.WTG(i).mJKT, o.WTG(i).mPP] = JKTfoundationMass(o.WTG(i).mHub+o.WTG(i).mTower, o.WTG(i).dWater);
            
            %apply any stochastic and market modifiers to foundation design%
            o.WTG(i).mJKT = o.WTG(i).mJKT * scenarioModifier('sJKT.mass', stocVar, markMods);
            o.WTG(i).mPP = o.WTG(i).mPP * scenarioModifier('PP.mass', stocVar, markMods);
            
    end
        
end