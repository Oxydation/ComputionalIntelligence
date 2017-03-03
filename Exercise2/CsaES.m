% author: Mathias Nigsch
% implementation for [1,2]-Meta-ES Algorithm

% input
% y - initial point N dimensional [Nx1]
% sigma - mutation strength
% mu - amount parents choosem from childs
% sigmaStop - abortion value of algorithm, trigger
% lambda - amount of offsprings to create
% s - path cumulation vector
% fun - function to analyse/minimize

% output
% g - generations needed
% stats - various statistic values (fitnessVal)
function[g, stats] = CsaES(y, s = 1, sigma = 1, sigmaStop = 10^(-5), mu, lambda, fun, funopt = [])
  g = 0;
  yNew = y;
  sigmaParent = sigma;
  sNew = s;
  N = length(y);
  c = 1/sqrt(N);
  D = sqrt(N);
  offsprings = cell(1, lambda); % create initial offsprings
  
  do
    % create offsprings and calc fitness
    for l=1:lambda
      % mutations =  % generate random values normalverteilt N dimensional, isotrophic gaussian mutation 
      yl = yNew + sigmaParent * randn(N, 1); % get new y point of offspring      
      fl = feval(fun, yl ,[]); % get fitness value of offspring
      
      % Store new fitness and point of offspring
      offsprings(l) = yl;
      offspringsFitness(l) = fl;   
    end
    
    %recombination of offsprings
    for k=1:mu 
      % evaluate best offspring
      bestFitness = min(offspringsFitness);
      indexBestOffspring = find(offspringsFitness == bestFitness);
      
      % set best offspring as parent
      parentsFitness(k) = offspringsFitness(indexBestOffspring);
      parents(k) = offsprings(indexBestOffspring);
      
      % set fitness of current best offspring to infinity
      offspringsFitness(indexBestOffspring) = Inf;
    end  
    
    nRecombination = 0;
    for l=1:mu
      nRecombination += cell2mat(parents(l));
    end
    nRecombination = nRecombination / mu;
    
    % end of recombnation
    
    % produce new parent and cumulate new search path
    yNew = yNew + sigmaParent * nRecombination;
    sNew = (1 - c)*sNew + sqrt(mu*c*(2-c)) * nRecombination;
    
    % calc new mutation strength
    eChi = sqrt(N) *(1-N^(-1)/4+N^(-2)/21);    
    sigmaParent = sigmaParent * exp((norm(sNew) - eChi)/D*eChi );   
  
    g++; 
    fNew = feval(fun, yNew ,[]);  
    stats.fitnessVal(g) = fNew;
  until(sigmaParent < sigmaStop);
end