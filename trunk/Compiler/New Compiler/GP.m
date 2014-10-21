% Apply Gradient Pulse;
function [rho_diagonal]=GP(rho)
rho_diagonal=diag(diag(rho),0);