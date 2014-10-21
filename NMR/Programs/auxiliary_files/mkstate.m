function [finalrho] = mkstate(textin,normflag)

%This function creates a density matrix given a text input of the state.  
%Use capital letters for the pauli operators i.e. X,Y,Z,I
%The zero and one states are represented by U and D respectively
%Pluses and minuses are allowed as well as constant multipliers
%Actually each term needs a constant multiplier
%
%
%Usage: rho = mkstate('textin',normflag)
%e.g rho = mkstate('+1XII - 0.5YUD +3ZZZ');
%
%The optional argument of normflag determines whether to return a
%normalized version of the state or not (0 means no normalization)

%Updated option to return unnormalized matrices Colm Ryan 24 February, 2006
%Written by Colm Ryan 24 November, 2004


if(nargin>1)
  normflag = normflag;
else
  normflag = 1;
end



%Okay, let's setup the Paulis
X = sparse([0 1;1 0]); Y = sparse([0 -i;i 0]); Z = sparse([1 0 ;0 -1]); I = speye(2);
U = sparse([1 0;0 0]); D = sparse([0 0;0 1]);

%Now we need to do some fancy parsing of the input string 
%First we need to find any + or -signs
plusloc = strfind(textin,'+');
minusloc = strfind(textin,'-');

oploc = [plusloc minusloc length(textin)+1];
oploc = sort(oploc);
if(length(oploc) == 1)
    disp('You forgot the constant multiplier (with sign)!')
    return
end


%Now split up the string about these operators
constants = ones(1,length(oploc)-1);
for k = 1:1:length(oploc)-1
    %Sort out if it was a minus sign
    isminus = [];
    isminus = find(minusloc == oploc(k));
    if(~isempty(isminus))
        constants(k) = -1;
    end
    rhotext{k} = textin(oploc(k)+1:oploc(k+1)-1);
end
    
%Now get rid of the spaces
for k = 1:1:length(rhotext)
    rhotext{k} = deblank(rhotext{k});
    rhotext{k} = deblank(fliplr(rhotext{k}));
    rhotext{k} = fliplr(rhotext{k});
end

%Now split up each term and pull off the constant multiplier
for k = 1:1:length(rhotext)
    asciis = sscanf(rhotext{k},'%f%s');
    constants(k) = constants(k)*asciis(1);
    paulis = char(asciis(2:length(asciis)));
    rho{k} = 1;
    for l = 1:1:length(paulis)
        eval(sprintf('rho{%d} = kron(rho{%d},%s);',k,k,paulis(l)));
    end
end

%Now add everthing up
nbspin = length(paulis);
finalrho = sparse(2^nbspin,2^nbspin);
for k = 1:1:length(rho)
    finalrho = finalrho + constants(k)*rho{k};
end

%Normalize the whole thing.
normfac = sqrt(trace(finalrho^2));
if(normflag)
finalrho = finalrho/normfac;
end

return
    
