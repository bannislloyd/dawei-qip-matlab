%
% Matlab function.
%
% Splits a string into a cell array of
% words which are separated by a given substr.
%
%%%
function A = split(string, substr);

  A = {};
  pos = [-length(substr)+1, findstr(substr, string), length(string)+1];
  for n = 1:length(pos)-1;
    A{n} = string(pos(n)+length(substr):pos(n+1)-1);
  end;

return;
