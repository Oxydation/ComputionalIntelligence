% author: Mathias Nigsch
% implementation for [1,2]-Meta-ES Algorithm

% input
% y - initial point N dimensional [Nx1]
% sigma - mutation strength
% mu - amount parents choosem from childs
% gamma - isolation time (no sigma changes) in generations
% fun - function to analyse/minimize

% output
% funEvals - amount of function evaluations
% funEvalHistory - history of evaluation
% ynew - new point
% fnew - funvalue of new point
% 
function[fp, parentsRecomb, funEvalCounter, funEvalHistory] = ES(mu = 1,lambda = 2, gamma = 1, sigma = 1, y, fun)
  funEvalCounter = 0;
  parentsRecomb = y;
  sigmaNew = sigma;
  funEvalHistory = [];
  offsprings = cell(1, lambda); % create initial offsprings
  
  for i=1:gamma
    for j=1:lambda
      ynew = parentsRecomb + sigma * randn(length(y), 1);
      fnew = feval(fun, ynew ,[]);      
      funEvalCounter++;
      funEvalHistory = [funEvalHistory; fnew];
      
      % Store new fitness and point of offspring
      offsprings(j) = ynew;
      offspringsFitness(j) = fnew;
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
    
    % finalization of recombination
     ysum = 0;
    for l=1:mu
      ysum += cell2mat(parents(l));
    end
    
    parentsRecomb = ysum/mu;
    %ysum = 1/mu * sum(cell2mat(parents)); 
    fp = feval(fun, parentsRecomb, []);
    
    % get new counter values of evaluations and append evaluation history
    funEvalCounter++;
    funEvalHistory = [funEvalHistory; fp];
  end
end