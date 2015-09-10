function Genmultizg%(path)
% expnb=2002;
% path='twqubit_pps_phasecycling';
% handle=fopen(path,'w+');
% %fprintf(handle,'d1 40\n');
% 
% 
%     for ii=2:24
%     fprintf(handle,'iexpno %d\n',expnb);
%     fprintf(handle,'re %d 1\n',expnb);
%     fprintf(handle,'pulprog twqubit_pps_%d\n',ii);
%     expnb=expnb+1;
%     end
% end

expnb=2001;
path='twqubit_pps_phasecycling';
handle=fopen(path,'w+');
%fprintf(handle,'d1 40\n');


    for ii=1:24
    fprintf(handle,'iexpno %d\n',expnb);
    fprintf(handle,'re %d 1\n',expnb);
    fprintf(handle,'NS 35\n');
    expnb=expnb+1;
    end
end