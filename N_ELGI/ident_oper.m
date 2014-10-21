function op=ident_oper(stri)

[Ix,Iy,Iz,~,~,~,sIHz] = prodop(1/2,4);

op1=eye(16);
for j=1:length(stri)
    if stri(j)=='I'
        op = eye(16);
    end    
    if stri(j)=='X'
        op = Ix(:,:,j);
    end    
    if stri(j)=='Y'
        op = Iy(:,:,j);
    end    
    if stri(j)=='Z'
        op = Iz(:,:,j);
    end  
    op=op1*op;
end


