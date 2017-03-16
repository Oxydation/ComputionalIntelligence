% Tablet test function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% y - function value
function[f] = Tablet(x)
  
  N = length(x);
  
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  %function value
  f = 10^6 * x(1).^2 + sum(x(2:N).^2);
  
end % of function