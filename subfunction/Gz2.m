function Gz(rou)

 v=length(rou);    %ÊäÈë¾ØÕó½×Êý
 
if (v-2^round(log2(v)))==0
   
   N = log2(v);
   for m = 0:(v-1)
         
         for ii = 1:N
             a(ii) = 0;
         end
         ii = 1;
         jj = m;
         while (jj~=0)
             a(ii) = mod(jj,2);
             jj = (jj-a(ii))/2; 
             ii = ii+1;
         end
   
   
         
         for n = 0:(v-1)
             
             for ii = 1:N
             b(ii) = 0;
             end
             ii = 1;
             jj = n;
             while (jj~=0)
             b(ii) = mod(jj,2);
             jj = (jj-b(ii))/2; 
             ii = ii+1;
             end
             
             decoherence = 0;
             for ii = 1:N
                 decoherence = decoherence+a(ii)-b(ii);
             end

             if mod(decoherence,4)==0
                 
             else rou(m+1,n+1)=0;
             end
         end
   end
   

   rou

else fprintf('Error:This matrix is not a density matrix!!! \n')
end
 
         
             
   
   
 
 
 