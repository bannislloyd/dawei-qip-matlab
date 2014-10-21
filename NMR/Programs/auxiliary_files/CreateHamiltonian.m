% Original Version:
% (C) Copyright 1999 by Timothy F. Havel, All Rights Reserved
% Updated by: 
% E. Fortunato and M. Pravia, (!) No Rights Reserved
%
% Setup strong coupling Hamiltonian from a matrix with the coupling constants
% above the diagonal and the given resonance frequencies (in any units).
%
 function H = CreateHamiltonian(spins)


global jcouplings

% Frequencies = a vector of chemical shift frequencies for each spin relative to
%					its species reference.
% Couplings = a symetric off diagonal matrix of the couplings strength.
%
% Initialize Pauli Matrices:
%

W = sparse([ 1  0; 0  1 ]); X = sparse([ 0  1; 1  0 ]);
Y = sparse([ 0 -1i; 1i  0 ]); Z = sparse([ 1  0; 0 -1 ]);

Frequencies = spins.freqs;
Couplings   = spins.jfreqs;

Jcouplings = zeros(spins.nb);

Jcouplings(1,2) = jcouplings(1);
Jcouplings(1,3) = jcouplings(2);
Jcouplings(2,3) = jcouplings(3);


% Setup the (diagonal of the) Zeeman Hamiltonian:
%
H = 0;
for a=1:spins.nb
  V = 1;
  for b=1:spins.nb
    if (a == b)
        V = kron( V, [1, -1]);
    else
        V = kron( V, [1, 1] );
    end; 
end;
%Watch out for the sign convention!!
H = H + 2*pi*0.5 * Frequencies(a) * V;
end;
H = diag( H );

%
% Add on the coupling terms
% the Weak coupling for all pairs of spins first
for a=1:spins.nb
    for b=(a+1):spins.nb
        ZZ=2*pi*0.5*Couplings(a,b) + pi*0.5*Jcouplings(a,b);
        for c=1:spins.nb
            if (c == a || c == b)
                ZZ=kron(ZZ,Z);
            else
                ZZ=kron(ZZ,W);
            end;
        end;
        H=H+ZZ;
    end;
end;


%the strong coupling for pairs of the same species
for a=1:spins.nb
    for b=(a+1):spins.nb
        if(spins.nucs(a) == spins.nucs(b))
            XX=2*pi*0.5*Couplings(a,b) - 2*pi*0.5*Jcouplings(a,b); 
            YY=2*pi*0.5*Couplings(a,b) - 2*pi*0.5*Jcouplings(a,b); 
            for c=1:spins.nb
                if (c == a || c == b)
                    XX=kron(XX,X);
                    YY=kron(YY,Y);
                else
                    XX=kron(XX,W);
                    YY=kron(YY,W);
                end;
            end;  
            H=H-0.5*XX-0.5*YY;
        end; 
    end; 
end; 








