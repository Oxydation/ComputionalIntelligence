% Ellipsoid 2 test function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% f - function value
function[f] = Ellipsoid2(x)
  
  N = length(x);
  
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  % calc function value
  f = sum((1:N).^2*x(1:N).^2);
end % of function 