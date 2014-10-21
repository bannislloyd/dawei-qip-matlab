function [termsx,termsy,termsz]=observablesM(n)

%First version O.Moussa feb2004

u=  sparse([1,0;0,1]);
x = sparse([0,1;1,0]);  
y = sparse([0,-i;i,0]);
z = sparse([1,0;0,-1]);


for(k=1:n)
    m=1;
    termx=1;
    termy=1;
    termz=1;
    while(m<=n)
        
        if(m==k)
            termx=kron(termx,x);
            termy=kron(termy,y);
            termz=kron(termz,z);
        else
            termx=kron(termx,u);
            termy=kron(termy,u);
            termz=kron(termz,u);
        end
        m=m+1;
    end
    termsx{k}=termx;
    termsy{k}=termy;
    termsz{k}=termz;
end

return