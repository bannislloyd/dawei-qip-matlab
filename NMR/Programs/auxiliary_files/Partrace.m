function out = Partrace(in,tspins);

%Partial trace function
%
%function out = Partrace(in,tspins);
%
% in: matrix to be traced over
% tspins: vector with spins to be traced out
%
% Written by Colm Ryan based on ideas from Jonathan Hodges 10 May,
% 2007
%Updated by Colm Ryan 22 May, 2007 to make it work properly.

%If we are not tracing anything just return the matrix
if(length(tspins) == 0)
  out = in;
  return
end

%Get the dimension and number of spins;
dim_in = size(in,1);
nb_in = log2(dim_in);

%Sort out traced out spins and kept spins;
tspins = sort(tspins);
kspins = setxor(tspins,[1:1:nb_in]);

nb_out = length(kspins);
nb_tr = nb_in-nb_out;

%The Partial trace is essentially picking out elements of the bigger
%matrix to create a new submatrix and then taking the trace of that.  In
%other words if a basis for the reduced space is |k> then  we factor the
%matrix into a sum of |k><k| X \rho_k for each basis vector k where \rho_k
%is the density matrix on the traced out space.  Then we just take the
%trace of \rho_k.  The trick is for each |k><k| to pick the right elements
%out to form \rho_k.

%Find indices in larger space corresponding to each |k>.  This is not obvious but.....

%inds is a 2D matrix where each row corresponds to a basis vector |k> and
%says which indices correspond to |k>

maxnb = max(nb_out,nb_tr);
binarynum = zeros(2^maxnb,maxnb);
for ct = 1:1:maxnb
  reps = 2^(ct-1);  
  binarynum(:,end-ct+1) =  repmat([zeros(reps,1);ones(reps,1)],2^maxnb/reps/2,1);
end

%First calculate how the columns change
colchangebin = 2.^(nb_in-tspins);
toprow = 1 + sum(repmat(colchangebin,2^nb_tr,1).*binarynum(1:2^nb_tr,end-nb_tr+1:end),2)';

%Now how the rows change
rowchangebin = 2.^(nb_in-kspins);
firstcol = 1+ sum(repmat(rowchangebin,2^nb_out,1).*binarynum(1:2^nb_out,end-nb_out+1:end),2);

inds = repmat(toprow,2^nb_out,1) + repmat(firstcol,1,2^nb_tr) -1;

%Now we just need to extract these from the big in matrix and take the
%trace of each one

for ct1 = 1:1:2^nb_out
    for ct2 = 1:1:2^nb_out
      out(ct1,ct2) = trace(in(inds(ct1,:),inds(ct2,:)));
    end
end


       
