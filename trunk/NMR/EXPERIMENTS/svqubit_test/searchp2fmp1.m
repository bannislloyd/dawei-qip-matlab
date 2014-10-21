function searchp2fmp1(p11)
% p11 must be a string
load p1.mat
for ii=1:length(p1)
    if strcmp(p11,p1{ii})
        load p2.mat
        display(p2{ii})
        break
    end
end