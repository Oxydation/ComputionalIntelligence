N = 40;
y = ones(N, 1);
sigma = 1;
sigmaStop = 10^(-5);
mu = 3;
lambda = 10;
gLimit = 2000;

[gCsa, statsCsa] = CsaES(y, sigma, sigmaStop, gLimit, mu, lambda, "Sphere")

% Display function over generations
figure
semilogy(statsCsa.fitnessVal, "Color", "r", "linewidth", 1)
hold on

[parentsRecomb, fp, g, statsSigmaSa] = MuMuILambdaES(y, sigma, sigmaStop, gLimit, mu, lambda, "Sphere");
semilogy(statsSigmaSa.funval, "Color", "m", "linewidth", 1)

legend("(3/3, 10)-CSA-ES", "(3/3,10)-{\sigma}SA-ES");
xlabel("# Generations");
ylabel("Fitness Value");
title("Ex 2 - CSA-ES - Dynamics of Fitness vs. Generations, (3/3, 10), N = 40");

% Display sigma values over generations
figure
semilogy(statsCsa.sigma, "Color", "r", "linewidth", 1)
hold on
semilogy(statsSigmaSa.sigma, "Color", "m", "linewidth", 1);

legend("(3/3, 10)-CSA-ES", "(3/3,10)-{\sigma}SA-ES");
xlabel("# Generations");
ylabel("Sigma");
title("Ex 2 - CSA-ES - Dynamics of Sigma vs. Generations, (3/3, 10), N = 40");

% Display sigma values over generations
figure
semilogy(statsCsa.sigmaNorm, "Color", "r", "linewidth", 1)
hold on
semilogy(statsSigmaSa.sigmaNorm, "Color", "m", "linewidth", 1);

legend("(3/3, 10)-CSA-ES", "(3/3,10)-{\sigma}SA-ES");
xlabel("# Generations");
ylabel("Normalized Sigma");
title("Ex 2 - CSA-ES - Dynamics of normalized Sigma vs. Generations, (3/3, 10), N = 40");