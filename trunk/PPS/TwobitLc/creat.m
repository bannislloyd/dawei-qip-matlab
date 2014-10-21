function [MaxP,tm]=creat(PX,PY,filename,TotalTime)

PY=-PY;
tm=TotalTime*1e6;
N=length(PX);
for ii=1:N
    Pls=PX(ii)+i*PY(ii);
    Pw(ii)=abs(Pls);
    Ph(ii)=angle(Pls)/pi*180;
    if Ph(ii)<0
        Ph(ii)=Ph(ii)+360;
    end
end
Pw=Pw'; Ph=Ph';

MaxPower=max(Pw)-mod(max(Pw),100)+100;
Pw=Pw/MaxPower*100;

% subplot(2,1,1)
% bar(Pw)
% subplot(2,1,2)
% bar(Ph)

fid=fopen(filename,'w');

fprintf(fid,'##TITLE= GRAPE');
fprintf(fid,'\n');
fprintf(fid,'##JCAMP-DX= 5.00 $$ Bruker JCAMP library');
fprintf(fid,'\n');
fprintf(fid,'##DATA TYPE= Shape Data');
fprintf(fid,'\n');
fprintf(fid,'##ORIGIN= USTC MPHY');
fprintf(fid,'\n');
fprintf(fid,'##OWNER= <Jing.ZHU>');
fprintf(fid,'\n');
fprintf(fid,'##DATE= 08/08/08');
fprintf(fid,'\n');
fprintf(fid,'##TIME= 08:08:08');
fprintf(fid,'\n');

fprintf(fid,'##--------- GRAPE PARAMETERS --------- ');
fprintf(fid,'\n');
fprintf(fid,'##Total_Duration_(us)= ');
fprintf(fid,'%g',tm);
fprintf(fid,'\n');
fprintf(fid,'##Maximum_Amplitude_(Hz)= ');
fprintf(fid,'%g',MaxPower);
fprintf(fid,'\n');
fprintf(fid,'##------------------------------------ ');
fprintf(fid,'\n');

fprintf(fid,'##MINX= ');
fprintf(fid,'%g',min(Pw));
fprintf(fid,'\n');
fprintf(fid,'##MAXX= ');
fprintf(fid,'%g',max(Pw));
fprintf(fid,'\n');
fprintf(fid,'##MINY= ');
fprintf(fid,'%g',min(Ph));
fprintf(fid,'\n');
fprintf(fid,'##MAXY= ');
fprintf(fid,'%g',max(Ph));
fprintf(fid,'\n');

fprintf(fid,'##$SHAPE_EXMODE= None');
fprintf(fid,'\n');
fprintf(fid,'##$SHAPE_TOTROT= 0.000000e+00');
fprintf(fid,'\n');
fprintf(fid,'##$SHAPE_BWFAC= 0.000000e+00');
fprintf(fid,'\n');
fprintf(fid,'##$SHAPE_INTEGFAC= 2.052226e-03');
fprintf(fid,'\n');
fprintf(fid,'##$SHAPE_MODE= 4');
fprintf(fid,'\n');
fprintf(fid,'##NPOINTS= ');
NP=num2str(N);
fprintf(fid,NP);
fprintf(fid,'\n');
fprintf(fid,'##XYPOINTS= (XY..XY)');
fprintf(fid,'\n');

for ii=1:N
    fprintf(fid,'%s, %s',Pw(ii),Ph(ii));
    fprintf(fid,'\n');
    
end

fprintf(fid,'##END=');
fclose(fid);

MaxP=MaxPower;