function Pout = inc_error(Pin,error_tol)



for j=1:8
%     error_tol = 1*error_tol_percentage/1000; 
    Pout(j)=Pin(j) -error_tol + (error_tol*2)*rand;
end

Pout(9)=1-sum(Pout(1:8));




    


