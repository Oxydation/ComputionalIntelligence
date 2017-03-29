% Happy Cat test function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% f - function value [1x1]
function[f] = HappyCat(x)
  
  N = length(x);
  
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  f = abs( x.^2 - N).^(1/4)  + 1/N  *();
end % of function 