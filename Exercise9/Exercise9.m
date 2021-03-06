N = 30;
y = ones(N, 1);
sigma = 1;
sigmaStop = 10^(-8);
funValStop = 10^(-8);
mu = 3;
lambda = 10;
gLimit = 3000;

%functions = {'Cigar';'Tablet';'Ellipsoid2';'ParabolicRidge';'SharpRidge';'DifferentPowers'};
functions = {'Cigar'};
for f = 1:sizeof(functions)
  fun = functions{f};
  
  % Population Variant 1
  mu = 3;
  lambda = 12;

  [gCma, statsCma] =          CMAES(y, sigma, sigmaStop, gLimit, mu, lambda, fun);
  [gCmaRank, statsCmaRank] =  CMARankES(y, sigma, sigmaStop, gLimit, mu, lambda, fun); 
  [gCsa, statsCsa] =          CsaES(y, sigma, sigmaStop, gLimit, mu, lambda, fun);  

  % Population Variant 2
   mu = 30;
  lambda = 120;

  [gCma2, statsCma2] =          CMAES(y, sigma, sigmaStop, gLimit, mu, lambda, fun);
  [gCmaRank2, statsCmaRank2] =  CMARankES(y, sigma, sigmaStop, gLimit, mu, lambda, fun);
  [gCsa2, statsCsa2] =          CsaES(y, sigma, sigmaStop, gLimit, mu, lambda, fun);   
  
  % Display function over generations
  figure
  subplot(1,2,1) % fitnessvalues
  semilogy(statsCma.fitnessVal, "Color", "b", "linewidth", 1);
  hold on;
  semilogy(statsCmaRank.fitnessVal, "Color", "r", "linewidth", 1);
  hold on;
  semilogy(statsCsa.fitnessVal, "Color", "g", "linewidth", 1);
  hold on;
  semilogy(statsCma2.fitnessVal, "Color", "c", "linewidth", 1);
  hold on;
  semilogy(statsCmaRank2.fitnessVal, "Color", "m", "linewidth", 1);
  hold on;
  semilogy(statsCsa2.fitnessVal, "Color", "y", "linewidth", 1);

  %legend("(3/3,12)-CMA-ES", "(3/3,12)-CMA-ES w. Rank-\mu","(3/3,12)-CSA-ES", "(30/30,120)-CMA-ES", "(30/30,120)-CMA-ES w. Rank-\mu", "(30/30,120)-CSA-ES");
  xlabel("Generations");
  ylabel("Fitness Value");
  title(strcat(fun, ": Fitness Dyn."));

  subplot(1,2,2) % sigma values
  semilogy(statsCma.sigma, "Color", "b", "linewidth", 1);
  hold on
  semilogy(statsCmaRank.sigma, "Color", "r", "linewidth", 1);
  hold on;
  semilogy(statsCsa.sigma, "Color", "g", "linewidth", 1);
  hold on; 
  semilogy(statsCma2.sigma, "Color", "c", "linewidth", 1);
  hold on
  semilogy(statsCmaRank2.sigma, "Color", "m", "linewidth", 1); 
  hold on;
  semilogy(statsCsa2.sigma, "Color", "y", "linewidth", 1);

  legend("(3/3,12)-CMA-ES", "(3/3,12)-CMA-ES w. Rank-\mu","(3/3,12)-CSA-ES", "(30/30,120)-CMA-ES", "(30/30,120)-CMA-ES w. Rank-\mu", "(30/30,120)-CSA-ES");
  xlabel("Generations");
  ylabel("Sigma");
  title(strcat(fun, ": Sigma Dyn."));
  
  outputFile = strcat(fun,"_cma_cma_rank.pdf");
  orient ("landscape")
  print(outputFile);
 end