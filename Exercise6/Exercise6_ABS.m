N = 30;
y = ones(N, 1);
sigma = 1;
sigmaStop = 10^(-10);
funValStop = 10^(-8);
mu = 3;
lambda = 10;
gLimit = 2500;

%functions = {'Cigar';'Tablet';'Ellipsoid2';'ParabolicRidge';'SharpRidge';'DifferentPowers'};
functions = {'ParabolicRidge'};

for f = 1:sizeof(functions)
  fun = functions{f};
  [gCma, statsCma] = CMAES(y, sigma, sigmaStop, gLimit, mu, lambda, fun);
  [gCsa, statsCsa] = CsaES(y, sigma, sigmaStop, gLimit, mu, lambda, fun);  
  [parentsRecomb, fp, g, statsMuMuLambdaEs] = MuMuILambdaES(y, sigma, sigmaStop, gLimit, mu, lambda, fun, tau=(1/sqrt(2*length(y))), funopt = []);

  % Display function over generations
  figure
  subplot(1,2,1) % fitnessvalues
  semilogy(abs(statsCsa.fitnessVal), "Color", "b", "linewidth", 1);
  hold on;
  semilogy(abs(statsCma.fitnessVal), "Color", "r", "linewidth", 1);
  hold on;
  semilogy(abs(statsMuMuLambdaEs.fitnessVal), "Color", "c", "linewidth", 1);
  legend("CSA-ES", "CMA-ES", "Sigma-SA-ES");
  xlabel("Generations");
  ylabel("Fitness Value");
  title(strcat(fun, ": Fitness Dyn."));

  subplot(1,2,2) % sigma values
  semilogy(statsCsa.sigma, "Color", "b", "linewidth", 1);
  hold on
  semilogy(statsCma.sigma, "Color", "r", "linewidth", 1);
  hold on;
  semilogy(statsMuMuLambdaEs.sigma, "Color", "c", "linewidth", 1);
  legend("Sigma CSA-ES", "Sigma CMA-ES", "Sigma-SA-ES");
  xlabel("Generations");
  ylabel("Sigma");
  title(strcat(fun, ": Sigma Dyn."));
  
  outputFile = strcat(fun,"_csa_cma_ssa.pdf");
  orient ("landscape")
  print(outputFile);
 end