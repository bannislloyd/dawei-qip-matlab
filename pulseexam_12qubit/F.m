%% Generate the Unitary Matrix for Free Evolution;

function F=F(Hamiltonian, time)
%F=diag(exp(diag(-i*Hamiltonian*10e-6*round(time/10e-6))),0);
F=diag(exp(diag(-i*Hamiltonian*time)),0);