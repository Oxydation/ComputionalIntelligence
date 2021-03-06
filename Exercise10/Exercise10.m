N = 30;
y = ones(N, 1);
sigma = 1;
sigmaStop = 10^(-5);
funValStop = -Inf;
mu = 3;
lambda = 10;
gLimit = 10000;
alpha = 1.2;

% Display function over generations
  figure  
for round = 0:9  
  % Population Variant 1
  gamma = 2^round;

  [gOneTwoMeta, statsOneTwoMeta] = OneTwoMetaES(y, sigma, funValStop, alpha, mu, lambda, gamma, gLimit, "SharpRidgeFive");
    
  subplot(1,2,1) % fitnessvalues
  %semilogy(statsOneTwoMeta.funval,  "linewidth", 1);
   plot(statsOneTwoMeta.funval, "linewidth", 1);
  hold on;
 
  subplot(1,2,2) % sigma values
  %semilogy(statsOneTwoMeta.sigma,  "linewidth", 1);
  plot(statsOneTwoMeta.sigma, "linewidth", 1);
  hold on;
 end
 
 % Ergebnis sollte zeigen, dass ab einer bestimmte Isolation die Verbesserung funktioniert, ansonsten h�rt es auf
 % Isolation von sigma herausfinden ob gro�es oder kleines sigma 
 % mutationsball verhindert, dass die mutatinen zu nahe an die x achse kommen und das sigma gro� bleibt, damit der algo nicht stecken bleibt
 % durch isolierung wird der mutationsball (sigma bleibt gleich) nicht verkleinert
 
  subplot(1,2,1) % fitnessvalues
  legend("gamma = 2^0", "gamma = 2^1", "gamma = 2^2", "gamma = 2^3", "gamma = 2^4", "gamma = 2^5", "gamma = 2^6", "gamma = 2^7", "gamma = 2^8", "gamma = 2^9");
  xlabel("Generations");
  ylabel("Fitness Value");
  title("[1,2(3/3,10)-Meta-ES Fitness Dyn.");
  
  subplot(1,2,2) % sigma values
  legend("gamma = 2^0", "gamma = 2^1", "gamma = 2^2", "gamma = 2^3", "gamma = 2^4", "gamma = 2^5", "gamma = 2^6", "gamma = 2^7", "gamma = 2^8", "gamma = 2^9");
  xlabel("Generations");
  ylabel("Sigma");
  title("[1,2(3/3,10)-Meta-ES Sigma Dyn.");
  
%outputFile = "meta_es_gamma_impact.pdf";
%orient ("landscape")
%print(outputFile);