function loss = WTGtransformerLosses(capTrans, Vop, load)

switch Vop
    
    case 33000; a = 5.5/6000; c = 37.5/6000;
    case 66000; a = 6.5/6000; c = 38.5/6000;
    case 90000; a = 7.5/6000; c = 39.5/6000; %confirm with Matteo, Benoit or Sebastien
    case 132000; a = 8.5/6000; c = 40.5/6000; %confirm with Matteo, Benoit or Sebastien

end
        
loss = (a + c*load.^2) .* capTrans;