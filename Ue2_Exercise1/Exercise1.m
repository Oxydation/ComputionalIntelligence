dimensions = {4;8;16;32;64};
sigma = 1;
sigmaStop = 10^(-5);
mu = 3;
lambda = 12;
gLimit = 500;
independentRuns = 15;
fitnessTarget = 10^(-4);

ertHistorySphere = [];
% Test function with various dimensions
for round = 1:size(dimensions)  
  ertTotalSphere = 0; % used to sum up run time for the sphere
  runsToSuccess = 0; % count the runs, until we get a success
  % run the test a couple of times independent with the same dimension
  
  printf("%s, N=%d\n", 'Sphere', N);
  for run = 1:independentRuns
      N = dimensions{round};
      yParent = ones(N, 1)*10;
      [parentsRecomb, fp, g, stats] = MuMuILambdaES(yParent, sigma, sigmaStop, gLimit, mu, lambda,"Sphere", fitnessTarget );
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
  
  printf("%s, N=%d\n", 'Ellipsoid', N);
  for run = 1:independentRuns
      N = dimensions{round};
      yParent = ones(N, 1)*10;
      [parentsRecomb, fp, g, stats] = MuMuILambdaES(yParent, sigma, sigmaStop, gLimit, mu, lambda,"Ellipsoid1", fitnessTarget );
      ertTotalEllipsoid1 += stats.funEvals;  % sum up total function evaluations
      
      if(fp < fitnessTarget)
        runsToSuccess++;
      end 
   end   
   ertHistoryEllipsoid1 = [ertHistoryEllipsoid1; (ertTotalEllipsoid1 / runsToSuccess)]; % save history
end
 
plot1 = figure(1);
dimensions = [4;8;16;32;64];
loglog(dimensions, ertHistorySphere, 'r-',"linewidth", 1);
hold on
loglog(dimensions, ertHistoryEllipsoid1, 'b-', "linewidth", 2);

legend("ERT Sphere", "ERT Ellipsoid1");
title(strcat("{\sigma}SA-ES: ERT"));
ylabel("ERT(Dimension)");
xlabel("Dimension");
  
print(plot1, strcat("Exercise 1 - ERT", ".png"), "-dpng");
  
%outputFile = "meta_es_gamma_impact.pdf";
%orient ("landscape")
%print(outputFile);