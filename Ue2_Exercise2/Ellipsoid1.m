% ellipsoid function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% f - function value [1x1]

function[f] = Ellipsoid1(x)
  
  N = length(x);
  
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  % function value  
  f  = sum((1:N)*(x.^2));
  
end % of function