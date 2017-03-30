y = [11;1;10;4;6;17;7;9;15;2;13;12;22;19;24;18;5;8;23;16;14;20;21;3]; % randn(N, 1);
gLimit = 1000;
tempChangeFact = 0.97;
temperatureInit = 200; % oven with 200°C
temperatureStop = 10^(-4);
L = 5;

% adaptive temparaturerhöhung:
% temperatur erhöhen und akzeptanzrate anschauen, und wenn diese hoch genug ist (0.8) ist, 
% dann haben wir die höchste benötigte temp erreicht
% hohe temp: hohes chaos: und wenn fast jeder zustand akzeptiert wird
% wir wollen tunneln: globales optimium suchen, in dem wir schlechtere zustände akzeptieren

% erhöhe temp, solange zähler < 6 && P < 0.8, um faktor 5 (T = T*5)
% falls zähler > 5 & P > 0.6 dann verkleinere um 1.5 (T = T/1.5)


% load cities A
fileCitiesA = fopen("cities_A_positions.dat","r");
citiesPositionA = fscanf(fileCitiesA, "%f",[24, 2]);
fclose(fileCitiesA);

% load cities B
fileCitiesB = fopen("cities_B_positions.dat","r");
citiesPositionB = fscanf(fileCitiesB, "%f",[25, 2]);
fclose(fileCitiesB);

% Display function over generations 
[g, fnew, ynew, statsSaTsp1] = SimulatedAnnealingTSP(y, temperatureInit, temperatureStop, L, tempChangeFact, gLimit, citiesPositionA);    

figure
plot(statsSaTsp1.fitness, "linewidth", 1);
hold on;
plot(statsSaTsp1.temperature,  "linewidth", 1);

legend("Fitness F", "Temperature T");
xlabel("Generations g");
ylabel("Fitness/Temperature Value");
title("Simulated Annealing for TSP - Cities A");

  % Display function over generations 
[g, fnew, ynew, statsSaTsp2] = SimulatedAnnealingTSP(y, temperatureInit, temperatureStop, L, tempChangeFact, gLimit, citiesPositionB);    

figure 
plot(statsSaTsp2.fitness, "linewidth", 1);
hold on;
plot(statsSaTsp2.temperature,  "linewidth", 1);

legend("Fitness F", "Temperature T");
xlabel("Generations g");
ylabel("Fitness/Temperature Value");
title("Simulated Annealing for TSP - Cities B");

outputFile = "simulatedAnnealingTsp.pdf";
orient ("landscape")
print(outputFile);