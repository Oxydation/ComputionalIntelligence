% author: Mathias Nigsch
% implementation for CMA-ES with Rank-µ-Update

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
function[g, stats] = CMARankES(y, sigma = 1, sigmaStop = 10^(-5), gLimit, mu, lambda, fun, funopt = [])
  g = 0;  
  N = length(y);
  yNew = y;
  sigmaParent = sigma;
  Cov = eye(N,N);
  c = 1/sqrt(N);
  D = sqrt(N);
  v = ones(N,1); % evolution path vector 
  c = 1/sqrt(N);
  cv = 1/sqrt(N);
  cc = 2/(N+sqrt(2))^2;
  sNew = zeros(N,1);
  offsprings = cell(1, lambda); % create initial offsprings
  offspringsMutations = cell(1, lambda);  
  parentsMutation = cell(1,mu);
  parentsW = cell(1,mu);
  parentsWW = zeros(N,N);
  offspringsW = cell(1,lambda);
  offspringsWW = eye(N,N);
  
  do  
   M = chol(Cov)';
   
    % create offsprings and calc fitness
    for l=1:lambda
      % mutations =  % generate random values normalverteilt N dimensional, isotrophic gaussian mutation 
      n = randn(N,1);     
      w = M*n; % correlierte search direction
      yl = yNew + sigmaParent * w; % get new y point of offspring      
      fl = feval(fun, yl , funopt); % get fitness value of offspring
      
      % Store new fitness and point of offspring
      offsprings(l) = yl;
      offspringsW(l) = w;
      offspringsMutations(l) = n;
      offspringsFitness(l) = fl;   
    end
    
    %recombination of offsprings
    for k=1:mu 
      % evaluate best offspring
      bestFitness = min(offspringsFitness);
      indexBestOffspring = find(offspringsFitness == bestFitness);
      
      % set best offspring as parent
      parentsMutation(k) = offspringsMutations(indexBestOffspring);
      parentsW(k) = offspringsW(indexBestOffspring);
      % set fitness of current best offspring to infinity
      offspringsFitness(indexBestOffspring) = Inf;
    end  
    
    % needed?
    nRecombination = 0;
    for l=1:mu
      nRecombination += cell2mat(parentsMutation(l));
    end
    nRecombination = nRecombination / mu;
    
    wRecombination = 0;
    for l=1:mu
      wRecombination += cell2mat(parentsW(l));
    end
    wRecombination = wRecombination / mu;
        
    % end of recombnation
    
    % CMA speciality
    v = (1-cv) * v + sqrt(mu*cv*(2-cv))*wRecombination; 
    
    wwRecombination = zeros(N,N);
    for l=1:mu
      wwRecombination += cell2mat(parentsW(l))*cell2mat(parentsW(l))';
    end
    % Rank-µ-Update
    %ww = zeros(N,N);
    %ww = w * w'; 
    %ww = 1/mu *wwSum; %*sum(w(1:mu)*w(1:mu)');
    Cov = (1-cc) * Cov + cc*((1/mu)*v*v' + (1- 1/mu) * wwRecombination) ; % calc new covariance matrix
    
    % produce new parent and cumulate new search path
    yNew = yNew + sigmaParent * wRecombination; % should we use nRecomb or wRecomb?
    sNew = (1 - c)*sNew + sqrt(mu*c*(2-c)) * nRecombination;
    fNew = feval(fun, yNew ,funopt);  
    
    % calc new mutation strength
    eChi = sqrt(N) *(1-N^(-1)/4+N^(-2)/21);    
    sigmaParent = sigmaParent * exp((norm(sNew) - eChi)/(D*eChi) );   
  
    g++;     
    stats.fitnessVal(g) = fNew;
    stats.sigma(g) = sigmaParent;
    
     % normalise mutation strength
    sigmaNorm = sigmaParent / sqrt(fNew) * N; % Restzielabstand bei kugel: sqrt(fnew) 
    stats.sigmaNorm(g) = sigmaNorm;    
  until(sigmaParent < sigmaStop || g >= gLimit);
end