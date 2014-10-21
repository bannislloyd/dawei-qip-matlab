function new_u = decrease_dim(u)

for j =1:9
    new_u(j,:) = u(7+j,8:16);
end