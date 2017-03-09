% Different powers test function
% author: Mathias Nigsch

%input:
% x - vector in column form

% output:
% f - function value 
function[f] = DifferentPowers(x)
  
  N = length(x);
  
  % check input
  if size(x,1) == 1
    x = x';
  end

  f = sum((x(1:N)'.^2).^(1+5*((1:N)-1)/(N-1)));
  
  % variant 2
  %sum1 = 0;
  %for i=1:N
  %  sum1 += (x(i)^2)^(1+5*(i-1)/(N-1));
  %end
end % of function 