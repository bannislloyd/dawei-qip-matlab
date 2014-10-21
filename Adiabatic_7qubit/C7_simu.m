%Four big couplings of C7
J27 = 37.48;  J47 = 29.02; J57 = -21.75; J67 = 34.57;

P  = 0;

%Consider Iy7_Iz2_Iz5_Iz6_I4

%%% J27 SPLIT change signs

frequency(1) = P+J27/2;
shape(1) = 1;


frequency(2) = P-J27/2;
shape(2) = -1;

%%% J67 SPLIT change signs
t1 = frequency(1); t2 = frequency(2);

frequency(1) = t1+J67/2;
shape(1) = 1;

frequency(2) = t1-J67/2;
shape(2) = -1;

frequency(3) = t2+J67/2;
shape(1) = -1;

frequency(4) = t2-J67/2;
shape(2) = 1;

%%% J57 SPLIT change signs
t1 = frequency(1); t2 = frequency(2); t3 = frequency(3); t4 = frequency(4);

frequency(1) = t1+J57/2;
shape(1) = 1;

frequency(2) = t1-J57/2;
shape(2) = -1;

frequency(3) = t2+J57/2;
shape(3) = -1;

frequency(4) = t2-J57/2;
shape(4) = 1;

frequency(5) = t3+J57/2;
shape(5) = -1;

frequency(6) = t3-J57/2;
shape(6) = 1;

frequency(7) = t4+J57/2;
shape(7) = 1;

frequency(8) = t4-J57/2;
shape(8) = -1;

%%% J47 SPLIT do not change signs
% t1 = frequency(1); t2 = frequency(2); t3 = frequency(3); t4 = frequency(4); t5 = frequency(5); t6 = frequency(6); t7 = frequency(7); t8 = frequency(8); 
% 
% frequency(1) = t1+J47/2;
% shape(1) = 1;
% 
% frequency(2) = t1-J47/2;
% shape(2) = 1;
% 
% frequency(3) = t2+J47/2;
% shape(3) = -1;
% 
% frequency(4) = t2-J47/2;
% shape(4) = -1;
% 
% frequency(5) = t3+J47/2;
% shape(5) = -1;
% 
% frequency(6) = t3-J47/2;
% shape(6) = -1;
% 
% frequency(7) = t4+J47/2;
% shape(7) = 1;
% 
% frequency(8) = t4-J47/2;
% shape(8) = 1;
% 
% frequency(9) = t5+J47/2;
% shape(9) = -1;
% 
% frequency(10) = t5-J47/2;
% shape(10) = -1;
% 
% frequency(11) = t6+J47/2;
% shape(11) = 1;
% 
% frequency(12) = t6-J47/2;
% shape(12) = 1;
% 
% frequency(13) = t7+J47/2;
% shape(13) = 1;
% 
% frequency(14) = t7-J47/2;
% shape(14) = 1;
% 
% frequency(15) = t8+J47/2;
% shape(15) = -1;
% 
% frequency(16) = t8-J47/2;
% shape(16) = -1;

%Consider Iy7_Iz2_Iz5_Iz6_Iz4
%%% J47 SPLIT change signs

t1 = frequency(1); t2 = frequency(2); t3 = frequency(3); t4 = frequency(4); t5 = frequency(5); t6 = frequency(6); t7 = frequency(7); t8 = frequency(8); 

frequency(1) = t1+J47/2;
shape(1) = 1;

frequency(2) = t1-J47/2;
shape(2) = -1;

frequency(3) = t2+J47/2;
shape(3) = -1;

frequency(4) = t2-J47/2;
shape(4) = 1;

frequency(5) = t3+J47/2;
shape(5) = -1;

frequency(6) = t3-J47/2;
shape(6) = 1;

frequency(7) = t4+J47/2;
shape(7) = 1;

frequency(8) = t4-J47/2;
shape(8) = -1;

frequency(9) = t5+J47/2;
shape(9) = -1;

frequency(10) = t5-J47/2;
shape(10) = 1;

frequency(11) = t6+J47/2;
shape(11) = 1;

frequency(12) = t6-J47/2;
shape(12) = -1;

frequency(13) = t7+J47/2;
shape(13) = 1;

frequency(14) = t7-J47/2;
shape(14) = -1;

frequency(15) = t8+J47/2;
shape(15) = -1;

frequency(16) = t8-J47/2;
shape(16) = 1;

%rewritten, from right to left, big to small.
%f3Ϊ�Ӵ�С�ŵ��׷�λ�ã�p3Ϊ������Ӧ��ԾǨ����
f_bak= frequency; %��������飬����frequency�����в�������f_bak�н���
nn=length(f_bak);          %���鳤

for ii=1:nn;           
    tt = max(f_bak);           %�ҵ������
      f3(ii) = tt;          %����С������b�ĵ�i����
      [m n] = find(f_bak==tt);  %�ҵ���С��λ��
      p3(ii) = shape(n) ;
      f_bak(n) = [-100000000000];           %��f2�а���С����ɣ�1000000
end 
