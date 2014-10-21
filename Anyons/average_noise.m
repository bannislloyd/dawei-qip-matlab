function temp = average_noise(Y, Average_Points)
% average_noise(Y, Average_Points); Y is the signal;
% Average_Points is the number of points before the middle point

N_Points = length(Y);

for ii =  1:Average_Points
      temp(ii)  = sum(Y(ii:ii+Average_Points))/(Average_Points+1);
end

for ii =  N_Points-Average_Points+1:N_Points
      temp(ii)  = sum(Y(ii-Average_Points:ii))/(Average_Points+1);
end

% temp(1:Average_Points) = Y(1:Average_Points);
% temp((N_Points-Average_Points+1):N_Points) = Y((N_Points-Average_Points+1):N_Points);

for ii  = (Average_Points+1):(N_Points-Average_Points)
    temp(ii) = sum(Y(ii-Average_Points:ii+Average_Points))/(2*Average_Points+1);
end

temp  = temp*max(Y)/max(temp);
