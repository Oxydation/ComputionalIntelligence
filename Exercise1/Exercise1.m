N = 40;
y = ones(N, 1);
sigma = 1;
funValStop = 10^(-10);
mu = 3;
lambda = 10;
alpha = 1.2;
gamma = 1;
gLimit = 2000;

[g, stats] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Sphere")

% Display fitness over generations
figure
semilogy(stats.funval, "Color", "g", "linewidth", 1)
hold on

gamma = 2;
[g, stats] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Sphere")
semilogy(stats.funval, "Color", "r", "linewidth", 1)

gamma = 5;
[g, stats] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Sphere")
semilogy(stats.funval, "Color", "b", "linewidth", 1)

gamma = 10;
[g, stats] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Sphere")
semilogy(stats.funval, "Color", "c", "linewidth", 1)

[parentsRecomb, fp, g, stats] = MuMuILambdaESFunvalStop(y, sigma, funValStop, gLimit, mu, lambda, "Sphere");
semilogy(stats.funval, "Color", "m", "linewidth", 1)

legend("Meta-ES (\gamma = 1)", "Meta-ES ({\gamma} = 2)", "Meta-ES (\gamma = 5)", "Meta-ES (\gamma = 10)", "Recombination - Self Adaption-ES");
xlabel("# Generations");
ylabel("Fitness Value");
title("Ex 1 - [1,2]-Meta-ES - Dynamics of Fitness vs. Generations, [1,2(3/3, 10)], N = 40");

% Display function evaluations
gamma = 1;
[g, stats] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Sphere")

figure
semilogy(stats.fitnessHistoryFunEval, "Color", "b", "linewidth", 1)
hold on

gamma = 2;
[g, stats] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Sphere")
semilogy(stats.fitnessHistoryFunEval, "Color", "g", "linewidth", 1)

gamma = 5;
[g, stats] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Sphere")
semilogy(stats.fitnessHistoryFunEval, "Color", "r", "linewidth", 1)

gamma = 10;
[g, stats] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "Sphere")
semilogy(stats.fitnessHistoryFunEval, "Color", "c", "linewidth", 1)

[parentsRecomb, fp, g, stats] = MuMuILambdaESFunvalStop(y, sigma, funValStop, gLimit, mu, lambda, "Sphere");
semilogy(stats.funValPerFunEval, "Color", "m", "linewidth", 1)


legend("Meta-ES (Gamma = 1)", "Meta-ES (Gamma = 2)", "Meta-ES (Gamma = 5)", "Meta-ES (Gamma = 10)", "Recombination-SelfAdaption-ES");
xlabel("# Function Calls");
ylabel("Fitness value");
title("Ex 1 - [1,2]-Meta-ES - Dynamics of Fitness vs. Function Calls, [1,2(3/3, 10)], N = 40");