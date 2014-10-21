function Genmultizg%(path)
expnb=1201;
path='node34mac';
handle=fopen(path,'w+');
%fprintf(handle,'d1 40\n');


    for ii=1:37
    fprintf(handle,'iexpno %d\n',expnb);
    fprintf(handle,'re %d 1\n',expnb);
    fprintf(handle,'spnam21 TCE_node34_%d_C\n',ii);
    fprintf(handle,'spnam22 TCE_node34_%d_H\n',ii);
    expnb=expnb+1;
    end
end