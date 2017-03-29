% HGBat test function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% f - function value [1x1]
function[f] = HGBat(x)
  
  N = length(x);
  
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  f = x(1).^2 + 10^6 * sum(x(2:N).^2);
end % of function 