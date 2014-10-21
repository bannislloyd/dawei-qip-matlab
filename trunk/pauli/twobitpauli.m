function twobitpauli(rou)

 v=length(rou);    %输入矩阵阶数
 pp=1;
 for m=1:4       %
     for n=1:4
         B((n-1)*4+m,1)=rou(n,m);
     end
 end
 %if rou==rou'      %判断矩阵是不是密度矩阵
     
    Ix=0.5*[0,1;1,0]; Iy=0.5*[0,-i;i,0]; Iz=0.5*[1,0;0,-1]; I=eye(2);
    Pau=[Ix,Iy,Iz,I];
   
    script=['x','y','z','o'];
   
      for ii=1:4
         for jj=1:4
            
                    A(:,:)=kron(Pau(1:2,(2*ii-1):(2*ii)),Pau(1:2,(2*jj-1):(2*jj)));
                    for m=1:4
                          for n=1:4
                              AA((n-1)*4+m,pp)=A(n,m);
                          end
                    end
                    pp=pp+1;    
                
                
                
            
        end
    end
 
 X=AA\B;
 
  
 for n=0:15
     if X(n+1,1)==0
     else
         
      
         kk=mod(n,4);
         k=floor(n/4);
         ii=mod(k,4);
         
         fprintf('I%cI%c, %g \n',script(ii+1),script(kk+1),X(n+1,1))
         
         
     end
 end
 
 
 
 
 
 
 %else fprintf('Error:This matrix is not a density matrix!!! \n')
 %end
 
 
 