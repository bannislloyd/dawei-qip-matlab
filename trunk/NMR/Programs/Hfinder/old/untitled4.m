for ct1 = 1:1:7
    for ct2 = 1:1:7
        jcouplings(1) = ct1*10; jcouplings(2) = ct2*10;
        resnorm(ct1,ct2) = Hfinder('malonicHfinderparams');
        pause(2)
    end
end
