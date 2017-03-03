% sphere function
% author: Mathias Nigsch
function[f,g] = Sphere(x)
  
  %input:
  % x - vector in column form
  % output:
  % f - function value [1x1]
  % g - gradient vector [nx1]
 
  
  % check input
  if size(x,1) == 1
    %fprintf('row vector, transform it into column vector')
    x = x';
  end
  
  % function value
  f = (x'*x);
  
  % gradient vector
  g = 2*x;
  
end % of function 