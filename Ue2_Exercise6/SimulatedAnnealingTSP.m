
function[g, fitnessParent, yOffspring, stats] = SimulatedAnnealingTSP(y, temperatureInit, temperatureStop, L, alpha, gLimit, citiesPosition)
  
  % Init variables
  yParent = y;
  N = length(yParent);
  fitnessParent = TSP(yParent, citiesPosition); %feval(fun, yParent);
  temperature = temperatureInit;
  generation = 0;
  figure
  do
    % Change permutation
    yOffspring = feval("lin2opt",yParent);
    fitnessOffspring = TSP(yOffspring, citiesPosition); 
    
    % Check, if we want to take the new y as new parent
    if(fitnessOffspring <= fitnessParent || exp((fitnessParent-fitnessOffspring)/temperature) > rand())
      yParent = yOffspring;
      fitnessParent = fitnessOffspring;
    end
    
    % Calculate new temperature
    % L is isolation amount of temp
    if(mod(generation,L) == (L-1))
      temperature = alpha * temperature;
    end
    
    generation++;
    
    stats.fitness(generation) = fitnessParent;
    stats.temperature(generation) = temperature;
    
    % Plots the current path
    plotPath(yParent, citiesPosition, fitnessParent, generation, temperature);
    
  until(temperature <= temperatureStop || generation > gLimit) 
 
    figure
    % print last plot
   plotPath(yParent, citiesPosition, fitnessParent, generation, temperature); 
end 

function [weight] = TSP(citiesPath, citiesCoordinates)
  weight = 0;
  citiesPathSize = size(citiesPath,1);
  
  for i = 1:citiesPathSize    
    if(i > 1)
      xDiffLength = abs(xCoordCity - citiesCoordinates(citiesPath(i),1));
      yDiffLength = abs(yCoordCity - citiesCoordinates(citiesPath(i),2));
      
      pathLength = sqrt(xDiffLength^2 + yDiffLength^2);      
      weight += pathLength;
    end
    
    xCoordCity = citiesCoordinates(citiesPath(i),1);
    yCoordCity = citiesCoordinates(citiesPath(i),2);    
  end
  
  xDiffLength = abs(citiesCoordinates(citiesPath(1),1) - citiesCoordinates(citiesPath(citiesPathSize),1));
  yDiffLength = abs(citiesCoordinates(citiesPath(1),2) - citiesCoordinates(citiesPath(citiesPathSize),2));
  pathLength = sqrt(xDiffLength^2 + yDiffLength^2);
      
  weight += pathLength;
end

%%% plot path %%%
function plotPath(yParent, citiesPosition, fitnessParent, generationCount, temperature)
  plot (citiesPosition(:,1), citiesPosition(:,2),'-or','LineWidth',2);
  drawnow();
    
  clf; % clear figure
%  for i = 1:size(yParent,1)
%    xValue = citiesPosition(yParent(i),1);
%    yValue = citiesPosition(yParent(i),2);
%    
%    plot(xValue,yValue);
%    hold on;
%    
%    if(i > 1)
%      line ([xValue xValueLast], [yValue yValueLast], "linestyle", "-", "color", "m");
%      hold on
%    end
%    
%    xValueLast = xValue;
%    yValueLast = yValue;
%  end
%  line ([citiesPosition(yParent(1),1) xValueLast], [citiesPosition(yParent(1),2) yValueLast], "linestyle", "-", "color", "r");
  axis off; % remove axis
  title (strcat("Fitness: ", num2str(fitnessParent),", Generation: ", num2str(generationCount), ", Temperature: ", num2str(temperature)));
  drawnow(); % refresh
end



%
%for length citiy postpadexcitypos(i,:)  city_pos(yparent(i),:);
%  
%  ext citypos(length(citypos(+1,:)