clear;
% labeling C5,C4,C7,C2,C6. 
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);
% Four kinds of control-control-rotation
STP = 1/2*[1,1;1,1]; % state plus
STM = 1/2*[1,-1;-1,1]; % state minus
g = 0.4;
R = expm(i*g*sigma_x);
CCR = cell(1,4);
for jj = 1:4
% 0+
    if jj == 1
        CCR{1} = MultiKron(7,I,I,I,ST0,STP,I,R)+MultiKron(7,I,I,I,ST1,STP,I,I)+MultiKron(7,I,I,I,ST0,STM,I,I)+MultiKron(7,I,I,I,ST1,STM,I,I);
    else if jj == 2
            CCR{2} = MultiKron(7,I,I,I,ST0,STP,I,I)+MultiKron(7,I,I,I,ST1,STP,I,R)+MultiKron(7,I,I,I,ST0,STM,I,I)+MultiKron(7,I,I,I,ST1,STM,I,I);
            else if jj == 3
            CCR{3} = MultiKron(7,I,I,I,ST0,STP,I,I)+MultiKron(7,I,I,I,ST1,STP,I,I)+MultiKron(7,I,I,I,ST0,STM,I,R)+MultiKron(7,I,I,I,ST1,STM,I,I);
            else 
            CCR{4} = MultiKron(7,I,I,I,ST0,STP,I,I)+MultiKron(7,I,I,I,ST1,STP,I,I)+MultiKron(7,I,I,I,ST0,STM,I,I)+MultiKron(7,I,I,I,ST1,STM,I,R);
                end
        end
    end
end

%% relationship between all the CCR's
% CCR{1} applying X4_pi gate is CCR{2}
abs(trace(expm(-i*pi*KIx{4})*CCR{1}*expm(-i*pi*KIx{4})'*CCR{2}'))/2^7
% CCR{1} applying Y5_pi gate is CCR{3}
abs(trace(expm(-i*pi*KIy{5})*CCR{1}*expm(-i*pi*KIy{5})'*CCR{3}'))/2^7
% CCR{1} applying X4_pi and Y5_pi gate is CCR{4}
abs(trace(expm(-i*pi*KIx{4})*expm(-i*pi*KIy{5})*CCR{1}*(expm(-i*pi*KIx{4})*expm(-i*pi*KIy{5}))'*CCR{4}'))/2^7

save CCR.mat CCR

%     if jj == 1
%         CCR = MultiKron(5,I,ST0,STP,I,R)+MultiKron(5,I,ST1,STP,I,I)+MultiKron(5,I,ST0,STM,I,I)+MultiKron(5,I,ST1,STM,I,I);
%     else if jj == 2
%             CCR = MultiKron(5,I,ST0,STP,I,I)+MultiKron(5,I,ST1,STP,I,R)+MultiKron(5,I,ST0,STM,I,I)+MultiKron(5,I,ST1,STM,I,I);
%             else if jj == 3
%             CCR = MultiKron(5,I,ST0,STP,I,I)+MultiKron(5,I,ST1,STP,I,I)+MultiKron(5,I,ST0,STM,I,R)+MultiKron(5,I,ST1,STM,I,I);
%             else 
%             CCR = MultiKron(5,I,ST0,STP,I,I)+MultiKron(5,I,ST1,STP,I,I)+MultiKron(5,I,ST0,STM,I,I)+MultiKron(5,I,ST1,STM,I,R);
%                 end
%         end
%     end