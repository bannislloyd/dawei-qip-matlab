function  Nqubitpauli(rou)

v=length(rou);    %ÊäÈë¾ØÕó½×Êý
N = sqrt(v);

Ix=0.5*[0,1;1,0]; Iy=0.5*[0,-i;i,0]; Iz=0.5*[1,0;0,-1]; I=eye(2);
    Pau=[Ix,Iy,Iz,I];
    
    script=['x','y','z','o'];
   
    
    A = eye(2);
    n = 1;
    
    for i1 = 1:4
        A = Pau(1:2,(2*i1-1):(2*i1))*A;
        if n == N
            





