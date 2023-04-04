function [IchargeSBmax, IchargeUGmax, Qss, Qop, Qlf, Qgrid] = calculateChargingCurrents(o, lCableSB, AcableSB, lCableUG, AcableUG, fCompOff, QsupplyWTG)

%get charging current (in A/m) for subsea and underground cables%
iChargeSB = subseaACcableProperties('iCharge', AcableSB, o.design.Vexport);
iChargeUG = subseaACcableProperties('iCharge', AcableUG, o.design.Vexport);

%determine total reactive power per section%
QreactSB = sqrt(3)*o.design.Vexport*iChargeSB*lCableSB;
QreactUG = sqrt(3)*o.design.Vexport*iChargeUG*lCableUG;

if ~o.design.osComp && ~o.design.lfComp

    %determine reactive power supplied by offshore substation%
    QtotSS = min(max(QsupplyWTG, fCompOff*(QreactSB+QreactUG)), (QreactSB+QreactUG)/2);
    
    %calculate required grid-side supply%
    Qgrid = QreactSB + QreactUG - QtotSS;
    
    %calculate transfer at landfall%
    QtransLF = abs(Qgrid - QreactUG);
    
    %calculate maximum charging current intensity in cables%
    IchargeSBmax = max(QtotSS, QtransLF)/(sqrt(3)*o.design.Vexport);
    IchargeUGmax = max(Qgrid, QtransLF)/(sqrt(3)*o.design.Vexport);
    
    %no compensation%
    Qlf = NaN; Qop = NaN;
        
elseif o.design.lfComp
    
    %equal compensation of onshore section%
    Qgrid = QreactUG/2; Qlf = QreactUG/2;
    
    %calculate maximum onshore charging current%
    IchargeUGmax = (lCableUG/2) * iChargeUG;
    
    if o.design.osComp
        
        %determine reactive power supplied by offshore substation%
        QtotSS = min(max(QsupplyWTG, fCompOff*QreactSB/2), QreactSB/4);
        
        %compensation platform supply%
        Qop = 3*QreactSB/4 - QtotSS;
        
        %landfall substation supply%
        Qlf = Qlf + QreactSB/4;
    
        %calculate maximum offshore charging current%
        IchargeSBmax = (QreactSB/2 - QtotSS)/(sqrt(3)*o.design.Vexport);
        
    else
        
        %determine reactive power supplied by offshore substation%
        QtotSS = min(max(QsupplyWTG, fCompOff*QreactSB), QreactSB/2);
        
        %landfall substation supply%
        Qlf = Qlf + QreactSB - QtotSS;
        
        %calculate maximum offshore charging current%
        IchargeSBmax = (QreactSB - QtotSS)/(sqrt(3)*o.design.Vexport);
        
        %no offshore compensation%
        Qop = NaN;
        
    end
    
else
    
    %determine reactive power supplied by offshore substation%
    QtotSS = min(max(QsupplyWTG, fCompOff*QreactSB/2), QreactSB/4);
    
    %calculate required grid-side supply%
    Qgrid = (QreactUG/2 + QreactSB/4);
    
    %calculate total offshore compensation supply%
    Qop = (QreactUG/2 + QreactSB/4) + (QreactSB/2 - QtotSS);
    
    %calculate maximum charging current intensity in cables%
    IchargeUGmax = (QreactUG/2 + QreactSB/4)/(sqrt(3)*o.design.Vexport);
    IchargeSBmax = max(QreactSB/2 - QtotSS, QreactUG/2 + QreactSB/4)/(sqrt(3)*o.design.Vexport);
    
    %no landfall compensation%
    Qlf = NaN;
    
end

%determine net substation supply%
Qss = max(0, QtotSS - QsupplyWTG);