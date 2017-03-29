y = [11;1;10;4;6;17;7;9;15;2;13;12;22;19;24;18;5;8;23;16;14;20;21;3]; % randn(N, 1);
gLimit = 500;
tempChangeFact = 0.95;
temperatureInit = 220; % oven with 200°C
temperatureStop = 10^(-6);
L = 5;

% load cities A
fileCitiesA = fopen("cities_A_positions.dat","r");
citiesPositionA = fscanf(fileCitiesA, "%f",[24, 2]);
fclose(fileCitiesA);

% load cities B
fileCitiesB = fopen("cities_B_positions.dat","r");
citiesPositionB = fscanf(fileCitiesB, "%f",[25, 2]);
fclose(fileCitiesB);

% Display function over generations 
[g, fnew, ynew, statsSaTsp] = SimulatedAnnealingTSP(y, temperatureInit, temperatureStop, L, tempChangeFact, gLimit, citiesPositionA);    

figure 
plot(statsSaTsp.fitness, "linewidth", 1);
hold on;
plot(statsSaTsp.temperature,  "linewidth", 1);
hold on;
legend("Fitness F", "Temperature T");
xlabel("Generations g");
ylabel("Fitness/Temperature Value");
title("Simulated Annealing for TSP");
  
outputFile = "simulatedAnnealingTsp.pdf";
orient ("landscape")
print(outputFile);