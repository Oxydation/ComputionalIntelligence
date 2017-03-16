N = 30;
y = ones(N, 1);
sigma = 1;
sigmaStop = 10^(-10);
funValStop = 10^(-8);
mu = 3;
lambda = 10;
gLimit = 2500;

functions = {'Cigar';'Tablet';'Ellipsoid2';'ParabolicRidge';'SharpRidge';'DifferentPowers'};
%functions = {'Tablet'};

for f = 1:sizeof(functions)
  fun = functions{f};
  [gCma, statsCma] = CMAES(y, sigma, sigmaStop, gLimit, mu, lambda, fun);
  
  figure
  semilogy(statsCma.sigma, "Color", "r", "linewidth", 1);
  hold on;
  semilogy(statsCma.maxEigValues, "Color", "b", "linewidth", 1);
  hold on;
  semilogy(statsCma.minEigValues, "Color", "g", "linewidth", 1);
  hold on;
  semilogy(statsCma.minMaxEigValues, "Color", "m", "linewidth", 1);
  hold on;
  legend("Sigma", "Max Eigenwerte", "Min Eigenwerte", "Max/Min Eigenwerte");
  xlabel("Generations");
  ylabel("Sigma");
  title(strcat(fun, ": Sigma & Eigenwerte Dyn. CMA"));
  
  outputFile = strcat(fun,"_cma_eigenvals.pdf");
  orient ("landscape")
  print(outputFile);
 end