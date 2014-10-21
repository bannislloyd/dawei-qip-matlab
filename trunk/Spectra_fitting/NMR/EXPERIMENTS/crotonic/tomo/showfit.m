function  showfit(spec,freq,fignum);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create frequency axis
 dt = 1/spec.swh;
 SI = length(spec.spec);
 fr = (1/dt)*(0:SI-1)/SI - spec.swh/2; 
 
%Funlist is a function with 64 lorentzians
for k=1:64
    funlist{2*k-1} = @(c,x) (1/(2*pi*c(1)))./((x - freq(k) + c(2)).^2 + (1/(2*pi*c(1)))^2);
    funlist{2*k}   = @(c,x) (x-freq(k) + c(2))./((x - freq(k) + c(2)).^2 + (1/(2*pi*c(1)))^2);
end

ylor = 0;

fr2 = min(fr):0.01:max(fr);

for k=1:64
    
    ylor =  ylor + spec.ILP(2*k-1)*funlist{2*k-1}(spec.INLP,fr2) + ...
            spec.ILP(2*k)*funlist{2*k}(spec.INLP,fr2);
end 

figure(fignum)
plot(fr,real(spec.spec),'b',fr2,real(ylor),'r')

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
