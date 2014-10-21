function   A=pauli(n)

Ix=0.5*[0,1;1,0]; Iy=0.5*[0,-i;i,0]; Iz=0.5*[1,0;0,-1]; I=eye(2); %¶¨ÒåpauliËã×Ó
    
Pau=[Ix,Iy,Iz,I]; 

if  n==0
    
    A=1;
    
    
else 
    for ii=1:4
        
        A(:,:)= kron(pauli(n-1),Pau(1:2,(2*ii-1):(2*ii)))
        
    end
end