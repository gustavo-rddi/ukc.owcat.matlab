function WTG = WTGmodelData(model)

switch lower(model)
    
    case 'haliade-6-150'
        
        WTG.cap    = 6000000;
        WTG.dRot   =     150;
        WTG.mHub   =  360000;
        WTG.mTower =  250000;
    
    case 'siemens-3.6-120'
        
        WTG.cap    = 3600000;
        WTG.dRot   =     120;
        WTG.mHub   =  225000;
        WTG.mTower =  225000;        
    
    case 'siemens-4-120'
        
        WTG.cap    = 4000000;
        WTG.dRot   =     120;
        WTG.mHub   =  225000;
        WTG.mTower =  225000;          
        
    case 'siemens-3.6-107'
        
        WTG.cap    = 3600000;
        WTG.dRot   =     107;
        WTG.mHub   =  220000;
        WTG.mTower =  180000;        
        
    case 'siemens-6-154'
        
        WTG.cap    = 6000000;
        WTG.dRot   =     154;
        WTG.mHub   =  360000;
        WTG.mTower =  285000;
        
    case 'siemens-7-154'
        
        WTG.cap    = 7000000;
        WTG.dRot   =     154;
        WTG.mHub   =  375000;
        WTG.mTower =  285000;
        
    case 'vestas-3.3-112'
        
        WTG.cap    = 3300000;
        WTG.dRot   =     112;
        WTG.mHub   =  155000;
        WTG.mTower =  130000;        
        
    case 'vestas-8-164'
        
        WTG.cap    = 8000000;
        WTG.dRot   =     164;
        WTG.mHub   =  495000;
        WTG.mTower =  330000;
        
  case 'vestas-8.3-164'
        
        WTG.cap    = 8300000;
        WTG.dRot   =     164;
        WTG.mHub   =  495000;
        WTG.mTower =  330000;
        
end