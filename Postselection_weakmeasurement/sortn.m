function [ f2 ] = sortn( f , n )


for jj = 1:n
    temp = -1000000;
    tempnum = 1;
for ii=1:n
    if temp < f(ii)
        tempnum = ii;
        temp = f(ii);
    end
end
f2(jj) = temp;
f(tempnum) = -100000;
end;

