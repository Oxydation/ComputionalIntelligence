% Cigar Tablet test function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% y - function value
function [y] = CigarTablet(x)

  N = length(x);
  
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  y = x(1).^2 + sum(x(2:N-1).^2) + x(N).^2;
end