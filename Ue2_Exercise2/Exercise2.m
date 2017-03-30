dimensions = {4;8;16;32;64};
sigma = 1;
sigmaStop = 10^(-5);
mu = 3;
lambda = 12;
gLimit = 1000;
independentRuns = 15;
fitnessTarget = 10^(-4);

ertHistorySphere = [];
% Test function with various dimensions
for round = 1:size(dimensions)  
  ertTotalSphere = 0; % used to sum up run time for the sphere
  runsToSuccess = 0; % count the runs, until we get a success
  % run the test a couple of times independent with the same dimension
  
  N = dimensions{round};
  printf("%s, N=%d\n", 'Sphere', N);
  for run = 1:independentRuns
      yParent = ones(N, 1)*10;
      [fp, g, stats] =  CMARankES(yParent, sigma, sigmaStop, gLimit, mu, lambda, "Sphere", fitnessTarget);
      ertTotalSphere += stats.funEvals;  % sum up total function evaluations
      
      if(fp < fitnessTarget)
        runsToSuccess++;
      end 
   end   
   ertHistorySphere = [ertHistorySphere; (ertTotalSphere / runsToSuccess)]; % save history
end
 
ertHistoryEllipsoid1 = [];
% Test function with various dimensions
for round = 1:size(dimensions)  
  ertTotalEllipsoid1 = 0; % used to sum up run time for the sphere
  runsToSuccess = 0; % count the runs, until we get a success
  % run the test a couple of times independent with the same dimension
  
  N = dimensions{round};
  printf("%s, N=%d\n", 'Ellipsoid1', N);
  for run = 1:independentRuns
      yParent = ones(N, 1)*10;
      [fp, g, stats] =  CMARankES(yParent, sigma, sigmaStop, gLimit, mu, lambda, "Ellipsoid1", fitnessTarget);
      ertTotalEllipsoid1 += stats.funEvals;  % sum up total function evaluations
      
      if(fp < fitnessTarget)
        runsToSuccess++;
      end 
   end   
   ertHistoryEllipsoid1 = [ertHistoryEllipsoid1; (ertTotalEllipsoid1 / runsToSuccess)]; % save history
end

ertHistoryEllipsoid2 = [];
% Test function with various dimensions
for round = 1:size(dimensions)  
  ertTotalEllipsoid2 = 0; % used to sum up run time for the sphere
  runsToSuccess = 0; % count the runs, until we get a success
  % run the test a couple of times independent with the same dimension
  
  N = dimensions{round};
  printf("%s, N=%d\n", 'Ellipsoid2', N);
  for run = 1:independentRuns
      yParent = ones(N, 1)*10;
      [fp, g, stats] =  CMARankES(yParent, sigma, sigmaStop, gLimit, mu, lambda, "Ellipsoid2", fitnessTarget);
      ertTotalEllipsoid2 += stats.funEvals;  % sum up total function evaluations
      
      if(fp < fitnessTarget)
        runsToSuccess++;
      end 
   end   
   ertHistoryEllipsoid2 = [ertHistoryEllipsoid2; (ertTotalEllipsoid2 / runsToSuccess)]; % save history
end

ertHistoryRosenbrock = [];
% Test function with various dimensions
for round = 1:size(dimensions)  
  ertTotalRosenbrock = 0; % used to sum up run time for the sphere
  runsToSuccess = 0; % count the runs, until we get a success
  % run the test a couple of times independent with the same dimension
  
  N = dimensions{round};
  printf("%s, N=%d\n", 'Rosenbrock', N);
  for run = 1:independentRuns
      yParent = ones(N, 1)*10;
      [fp, g, stats] =  CMARankES(yParent, sigma, sigmaStop, gLimit, mu, lambda, "Rosenbrock", fitnessTarget);
      ertTotalRosenbrock += stats.funEvals;  % sum up total function evaluations
      
      if(fp < fitnessTarget)
        runsToSuccess++;
      end 
   end   
   ertHistoryRosenbrock = [ertHistoryRosenbrock; (ertTotalRosenbrock / runsToSuccess)]; % save history
end 
plot1 = figure(1);
dimensions = [4;8;16;32;64];
loglog(dimensions, ertHistorySphere, 'o-r',"color","r","linewidth", 1);
hold on
loglog(dimensions, ertHistoryEllipsoid1, 'o-r', "color","b","linewidth", 2);
hold on
loglog(dimensions, ertHistoryEllipsoid2, 'o-r', "color","c", "linewidth", 2);
hold on
loglog(dimensions, ertHistoryRosenbrock, 'o-r', "color","m","linewidth", 2);

legend("ERT Sphere", "ERT Ellipsoid1", "ERT Ellipsoid 2", "Rosenbrock");
title(strcat("{\sigma}SA-ES: ERT"));
ylabel("ERT(Dimension)");
xlabel("Dimension");
  
print(plot1, strcat("Exercise 2 - ERT", ".png"), "-dpng");
  
%outputFile = "meta_es_gamma_impact.pdf";
%orient ("landscape")
%print(outputFile);
loglog((1:100), 1e1*(1:100), ":c")
loglog((1:100), 1e1*(1:100)^2, ":c")


% Information:
% Rosenbrock ist ein bisschen Überquadratisch, die anderen sind linear und gehen richtung quadratisch
% algorithmus (Rosenbrock) landet oft im lokalen optimium: schwankungen der varianz
% wird zur laufzeitkomplexitätsermittlung verwendet -> bewertung von algorithmen, grundlegende tools
