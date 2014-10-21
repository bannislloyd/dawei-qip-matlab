% Generating Shapefile;
function shape(Time,filename1,filename2)


% C
Bx=B(1:M);
By=B(M+1:2*M);
total_time= Time; 
ref_power= 6000; 
Amp=abs(Bx+i*By)*100/ref_power; Phase=angle(Bx+i*By)*180/pi;
fid=fopen(filename1,'w');
fprintf(fid, '##TITLE= %s\n','ShapedPulse');
fprintf(fid, '##JCAPM-DX= 5.00 Bruker JCAMP library\n');
fprintf(fid, '##DATA TYPE= Shape Pulses \n');
fprintf(fid, '##ORIGIN= Colm Fixed Pulses \n');
fprintf(fid, '##OWNER= %s\n', ' ');
fprintf(fid, '##DATE= \n');
fprintf(fid, '##TIME= \n');
fprintf(fid, '##MINX= %7.6e\n',min(Amp));
fprintf(fid, '##MAXX= %7.6e\n',min(max(Amp),100));
fprintf(fid, '##MINY= %7.6e\n',min(Phase));
fprintf(fid, '##MAXY= %7.6e\n',max(Phase));
fprintf(fid, '##$SHAPE_EXMODE= None\n');
fprintf(fid, '##$SHAPE_TOTROT= %7.6e\n',90);
fprintf(fid, '##$SHAPE_BWFAC= %7.6e\n',1);
fprintf(fid, '##$SHAPE_INTEGFAC= %7.6e\n',1);
fprintf(fid, '##$SHAPE_MODE= 1\n');
fprintf(fid, '##PULSE_WIDTH= %d\n',total_time);
fprintf(fid, '##NPOINTS= %d\n',length(Amp));
fprintf(fid, '##XYPOINTS= (XY..XY)\n');
for j=1:length(Amp)
    fprintf(fid,'%f', Amp(j));
    fprintf(fid,'%s','e+000, ');
    fprintf(fid,'%f', Phase(j));
    fprintf(fid,'%s\n','e+000 ');
end
fprintf(fid, '##END=');
fclose(fid);

% homepath    = '/home/dtrottie/chiral';
% arg1=[homepath,'/',filename1];
% arg2=  '/opt/topspin/exp/stan/nmr/lists/wave';
% eval(sprintf ('! scp %s mditty@enlil.uwaterloo.ca:%s',arg1,arg2));
% fprintf('DONE!\n')
% 
% homepath    = '/home/dtrottie/chiral';
% arg1=[homepath,'/',filename2];
% arg2=  '/opt/topspin/exp/stan/nmr/lists/wave';
% eval(sprintf ('! scp %s mditty@enlil.uwaterloo.ca:%s',arg1,arg2));
% fprintf('DONE!\n')