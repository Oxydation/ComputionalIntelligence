function[y,f] = Rosenbrock(x)
  % check input
  if size(x,1) == 1
    x = x';
  end
  
  dimensions = size(x,1);
  
  y = sum(100*(x(1:dimensions-1).^2-x(2:dimensions)).^2 + (1-x(1:dimensions-1)).^2);
  
end