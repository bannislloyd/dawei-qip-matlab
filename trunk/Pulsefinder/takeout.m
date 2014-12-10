%Function that remove an list of elements from an ordered array (cell or
%list) conserving the order among the resilient elements

function [out]= takeout(in,nb)
L  = length(in);
LI = length(nb);
cpt= 1;
%Order the set of element to take out
while cpt~=0
  cpt=0;
  for a=1:LI-1
    if nb(a)>nb(a+1)
      cpt    = cpt+1;
      tmp1   = nb(a+1);
      nb(a+1)= nb(a);
      nb(a)  = tmp1;
    end;      
  end;
end;

%Take the elements out.
if iscell(in)
    cmd=sprintf('{in{1:%i-1}},',nb(1));
    for a=1:LI-1
      cmd = [cmd,sprintf('{in{%i+1:%i-1}},',nb(a),nb(a+1))];
    end;
    cmd = [cmd, sprintf('{in{%i+1:L}}',nb(LI))];
    out=eval(sprintf('[%s];',cmd));
  
  
else  
  cmd=sprintf('in(1:%i-1),',nb(1));
  for a=1:LI-1
    cmd = [cmd,sprintf('in(%i+1:%i-1),',nb(a),nb(a+1))];
  end;
  cmd = [cmd, sprintf('in(%i+1:L)',nb(LI))];
  out=eval(sprintf('[%s];',cmd));
end;
