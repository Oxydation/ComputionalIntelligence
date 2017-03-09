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

[gCma, statsCma] = CMAES(y, sigma, sigmaStop, gLimit, mu, lambda, "Sphere");
[gCsa, statsCsa] = CsaES(y, sigma, sigmaStop, gLimit, mu, lambda, "Sphere");  


% Display function over generations
figure
subplot(1,2,1) % fitnessvalues
semilogy(statsCsa.fitnessVal, "Color", "b", "linewidth", 1)
hold on;
semilogy(statsCma.fitnessVal, "Color", "r", "linewidth", 1)
legend("CSA-ES", "CMA-ES");
xlabel("Generations");
ylabel("Fitness Value");
title("Dynamics of Fitness vs. Generations, N = 40");

subplot(1,2,2) % sigma values
semilogy(statsCsa.sigma, "Color", "b", "linewidth", 1);
hold on
semilogy(statsCma.sigma, "Color", "r", "linewidth", 1);

legend("Sigma CSA-ES", "Sigma CMA-ES");
xlabel("Generations");
ylabel("Sigma");
title("Dynamik of Sigma, N = 40");

% Display sigma values over generations
figure
semilogy(statsCsa.sigmaNorm, "Color", "b", "linewidth", 1)
hold on
semilogy(statsCma.sigmaNorm, "Color", "r", "linewidth", 1);

legend("SigmaNorm CSA-ES", "SigmaNorm CMA-ES");
xlabel("Generations");
ylabel("Normalized Sigma");
title("Dynamik of Sigma-Norm vs Generations, N = 40");