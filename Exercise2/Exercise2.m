N = 40;
y = ones(N, 1);
sigma = 1;
sigmaStop = 10^(-4);
mu = 3;
lambda = 10;
gLimit = 2000;
s = 1;
funValStop = 10^(-10);

[g, stats] = CsaES(y, s, sigma, sigmaStop, mu, lambda, "Sphere")

% Display fitness over generations
figure
semilogy(stats.fitnessVal, "Color", "r", "linewidth", 1)
hold on

[parentsRecomb, fp, g, stats] = MuMuILambdaESFunvalStop(y, sigma, funValStop, gLimit, mu, lambda, "Sphere");
semilogy(stats.funval, "Color", "m", "linewidth", 1)

legend("Meta-ES (\gamma = 1)", "Recombination - Self Adaption-ES");
xlabel("# Generations");
ylabel("Fitness Value");
title("Ex 2 - CSA-ES - Dynamics of Fitness vs. Generations, (3/3, 10), N = 40");