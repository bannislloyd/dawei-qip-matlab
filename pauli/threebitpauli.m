function threebitpauli(rou)

 v=length(rou);    % ‰»Îæÿ’ÛΩ◊ ˝
 pp=1;
 for m=1:8       %
     for n=1:8
         B((n-1)*8+m,1)=rou(n,m);
     end
 end
 %if rou==rou'      %≈–∂œæÿ’Û «≤ª «√‹∂»æÿ’Û
     
    Ix=0.5*[0,1;1,0]; Iy=0.5*[0,-i;i,0]; Iz=0.5*[1,0;0,-1]; I=eye(2);
    Pau=[Ix,Iy,Iz,I];
   
    script=['x','y','z','o'];
   
      for ii=1:4
         for jj=1:4
            for kk=1:4
                    A(:,:)=kron(Pau(1:2,(2*ii-1):(2*ii)),kron(Pau(1:2,(2*jj-1):(2*jj)),Pau(1:2,(2*kk-1):(2*kk))));
                    for m=1:8
                          for n=1:8
                              AA((n-1)*8+m,pp)=A(n,m);
                          end
                    end
                    pp=pp+1;    
                
                
                
            end
        end
    end
 
 X=AA\B;
 
  
 for n=0:63
     if X(n+1,1)==0
     else
         
         jj=mod(n,4);
         j=floor(n/4);
         kk=mod(j,4);
         k=floor(j/4);
         ii=mod(k,4);
         
         fprintf('I%cI%cI%c , %g \n',script(ii+1),script(kk+1),script(jj+1),X(n+1,1))
         
         
     end
 end
 
 
 
 
 
 
 %else fprintf('Error:This matrix is not a density matrix!!! \n')
 %end
 
 
 