% Sharp Ridge 5 test function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% y - function value
function y = SharpRidgeFive(x)
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  y = -x(1) + 5 * sqrt(sum(x(2:end) .^ 2));
end