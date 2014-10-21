function B = reformat(A)

if sum(A{1}(1:2) == '+1')==2
   B = A{1}(3:end);
   B = {B};
elseif sum(A{1}(1:2) == '-1')==2
   B = A{1}(3:end);
   B = {['-' B]};
else 
   B = A;
end

end

