function [tran ff T2 opR opI] = transitions(N,sp)
% [tran ff T2 opR opI] = transitions(N,sp)
% Calculate the operators associated to each line of the spectrum 
% Tran{k} - > Transition associate to the line k 
% ff - > Frequencies associated to the line k   
% T2 for the spin sp
% opR{k}  - > Operators associated to the line k in Real part 
% opI  - > Operators associated to the line k in Real part 
%
% N - > Number of spins
% sp -> Spin to caculate the the operators   
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% transitions
% st1 is all possible states
% st2 is equal to st1 with the spin (sp) inverted
mm =1;

for k=0:2^N-1; 
    
    st = dec2bin(k,N);  
    
    if st(sp) == '0'; 
        st1{mm} = st;   
        st2{mm} = st; 
        st2{mm}(sp) = '1'; 
        mm = mm +1;
    end
   
end

for k=1:length(st1); tran{k} = [st1{k} ' <--> ' st2{k}]; end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%frequency
%If the neighour spin is in state 0 the frequecy in shifted by -J/2
%If the neighour spin is in state 1 the frequecy in shifted by +J/2

for k=1:length(st1);
    
    freq{k} = [ 'W(' mat2str(sp) ')'];
    
    for m=1:N;
        if m ~= sp 
            
            if st1{k}(m) == '0'; sinal(m) = '-';else; sinal(m) = '+'; end
            
            jj = mat2str(sort([sp m]));
            
            freq{k} = [ freq{k}  sinal(m) 'J' jj '/2'  ];
            
        end
        
    end
    
end

%Read molucule file to find numerical values to freqs
global spins

jtable = spins.jfreqs;
   
vec = [2 3 4 6 7 8 9];
aux = 1:7;

 T2 = spins.T2(vec(sp));

for m =1:7
        if m ~= sp
            J(sp,m) = jtable(vec(sp),vec(m));
        end
        
        if sp == m; aux(m) =[]; end 
end

for k=1:length(freq);
   
    
    ff(k) = 0;
    
    sigmm = freq{k}(5:9:end);

    for m=1:6
    
    if sigmm(m) == '+'; ff(k) = ff(k) + J(sp,aux(m)); else;  ff(k) = ff(k) - J(sp,aux(m)); end
    
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Operators Using rules of PHYSICAL REVIEW A 69, 052302 (2004)
%

 
 for k =1:length(st1)
     
     for m=1:N;
         
        if m == sp 
            
            aux2{k}(m) = 'X';  auy2{k}(m) = 'Y';
            
        else
            
            if st1{k}(m) == '0'; 
                aux2{k}(m) = 'I';  auy2{k}(m) = 'I';
            else 
                aux2{k}(m) = 'Z'; auy2{k}(m) = 'Z';
            end
            
        end
            
     end
     
    %---------------------------------------------------------------------

 end

 HH = hadamard(length(st1));
 
 for k =1:length(st1)
     
    for m = 1:length(st1)
     
        if HH(k,m) == 1; 
            
            sinalx{k}(m) = '+'; sinaly{k}(m) = '-'; 
      
        else 
            sinalx{k}(m) = '-'; sinaly{k}(m) = '+'; 
     
        end
        
 end
     
 end
 
 
for k =1:length(st1)
    
    opR{k} = [sinalx{k}(1) aux2{1}];
    
    opI{k} = [sinaly{k}(1) auy2{1}];

    for m =2:length(st1)
        
        opR{k} = [opR{k} sinalx{k}(m)  aux2{m}];
        
        opI{k} = [opI{k} sinaly{k}(m)  auy2{m}];
    end

end
     