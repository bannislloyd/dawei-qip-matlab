function new_u = increase_dim(u)

new_u=eye(16);

for j =1:9
    new_u(7+j,8:16) = u(j,:);
end