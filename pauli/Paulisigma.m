function Paulisigma(rou)

 v=length(rou);    %����������
 pp=1;
 for m=1:16       %
     for n=1:16
         B((n-1)*16+m,1)=rou(n,m);
     end
 end
 if rou==rou'      %�жϾ����ǲ����ܶȾ���
     
    Sx=[0,1;1,0]; Sy=[0,-i;i,0]; Sz=[1,0;0,-1]; I=eye(2);
    Pau=[Sx,Sy,Sz,I];
   
    script=['x','y','z','o'];
   
      for ii=1:4
         for jj=1:4
            for kk=1:4
                for ll=1:4
                    A(:,:)=kron(Pau(1:2,(2*ii-1):(2*ii)),kron(Pau(1:2,(2*jj-1):(2*jj)),kron(Pau(1:2,(2*kk-1):(2*kk)),Pau(1:2,(2*ll-1):(2*ll)))));
                    for m=1:16
                          for n=1:16
                              AA((n-1)*16+m,pp)=A(n,m);
                          end
                    end
                    pp=pp+1;    
                
                
                end
            end
        end
    end
 
 X=AA\B;
 
  
 for n=0:255
     if X(n+1,1)==0
     else
         
         jj=mod(n,4);
         j=floor(n/4);
         kk=mod(j,4);
         k=floor(j/4);
         ll=mod(k,4);
         l=floor(k/4);
         ii=mod(l,4);
         
         fprintf('S%cS%cS%cS%c , %g \n',script(ii+1),script(ll+1),script(kk+1),script(jj+1),X(n+1,1))
         
         
     end
 end
 
 
 
 
 
 
 else fprintf('Error:This matrix is not a density matrix!!! \n')
 end
 
 
 