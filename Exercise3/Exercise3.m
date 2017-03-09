N = 40;
y = ones(N, 1);
sigma = 1;
sigmaStop = 10^(-5);
funValStop = 10^(-8);
mu = 3;
lambda = 10;
gLimit = 4000;
gamma = 1;
alpha = 1.2;
rounds = 2;
yOneTwoMetaSum = zeros(1, gLimit);
yCsaEsSum = zeros(1, gLimit);

% Let 1,2-Meta-ES and CSA-ES run for a couple of rounds and calculate mean per generation
for i=1:rounds
  [gOneTwoMeta, statsOneTwoMeta] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Ellipsoid");
  [gCsa, statsCsa] = CsaES(y, sigma, sigmaStop, gLimit, mu, lambda, "Ellipsoid");  
  yOneTwoMetaSum += statsOneTwoMeta.yMeanPerGeneration;
  yCsaEsSum += statsCsa.yMeanPerGeneration;
end

% Calculate mean per generation for both algorithms
yOneTwoMetaMean = yOneTwoMetaSum / length(yOneTwoMetaSum);
yCsaEsMean = yCsaEsSum / length(yCsaEsSum);


% Display function over generations
figure
subplot(1,2,1) % fitnessvalues
semilogy(statsCsa.fitnessVal, "Color", "b", "linewidth", 1)
hold on;
semilogy(statsOneTwoMeta.funval, "Color", "r", "linewidth", 1)
legend("(3/3, 10)-CSA-ES", "1,2-Meta-ES");
xlabel("Generations");
ylabel("Fitness Value");
title("Dynamics of Fitness vs. Generations, N = 40");

subplot(1,2,2) % sigma values
semilogy(statsCsa.sigma, "Color", "b", "linewidth", 1);
hold on
semilogy(statsOneTwoMeta.sigma, "Color", "r", "linewidth", 1);
hold on 
semilogy(yOneTwoMetaMean, "Color", "g", "linewidth", 1);
hold on
semilogy(yCsaEsMean, "Color", "y", "linewidth", 1);

legend("Sigma 1,2-Meta-ES", "Sigma CSA-ES",  "y_{i}^2 Meta-ES", "y_{i}^2 CSA-ES" );
xlabel("Generations");
ylabel("Sigma, y_{i}^2");
title("Dynamik of y_{i}^2 vs Sigma N = 40");