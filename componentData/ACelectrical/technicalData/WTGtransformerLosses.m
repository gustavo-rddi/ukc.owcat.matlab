function loss = WTGtransformerLosses(capTrans, Vop, load)

switch Vop
    
    case 33000; a = 5.5/6000; c = 37.5/6000;
    case 66000; a = 6.5/6000; c = 38.5/6000;

end
        
loss = (a + c*load.^2) .* capTrans;