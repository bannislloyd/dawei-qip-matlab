function Crot_sp%(path)
expnb=101;
path='Crot_sp';
handle=fopen(path,'w+');
%fprintf(handle,'d1 40\n');


    for ii=1:20
    fprintf(handle,'iexpno %d\n',expnb);
    fprintf(handle,'re %d 1\n',expnb);
     power = 1.5+ii*0.02;
    for jj=1:14       
    fprintf(handle,'sp%d %d \n',jj,power);
    end
    expnb=expnb+1;
    end
end
