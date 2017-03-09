% ellipsoid function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% f - function value [1x1]

function[f] = Ellipsoid(x)
  
  N = length(x);
  
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  % function value  
  %f  = sum((1:N)*x(1:N).^2);  
  %f = sum(1:N)' .*(y.^2);
  
  % other version:  
   y = 1:N;
   f = y*x.^2;
end % of function 