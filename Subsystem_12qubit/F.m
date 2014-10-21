%% Generate the Unitary Matrix for Free Evolution;

function F=F(Hamiltonian, time)
F=diag(exp(diag(-i*Hamiltonian*time)),0);