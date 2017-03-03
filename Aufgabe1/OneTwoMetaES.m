% author: Mathias Nigsch
% implementation for [1,2]-Meta-ES Algorithm

% input
% y - initial point N dimensional [Nx1]
% sigma - mutation strength
% sigmaStop - stop value of sigma, if sigma is lower than sigmaStop, algorithm is stopped
% alpha - factor of new sigma (mutation strenght)
% mu - amount parents choosem from childs
% gamma - isolation time (no sigma changes) in generations
% fun - function to analyse/minimize

% output
% g - amount of generations
% stats - statistic values (funEvalCounter and fitnessHistory and funval)
% ynew - final point
% fnew - funvalue of new point
% 
function[g, stats] = OneTwoMetaES(y, sigma = 1, funValStop = 10^(-10), alpha = 1.2, mu = 3, lambda = 10, gamma = 1, gLimit = 10000, fun)
  g = 0;
  yNew = y;
  sigmaParent = sigma;
  
  funEvalCounter = 0;
  fitnessHistory = [];
  sigmaHistory = [];
  fitnessHistoryFunEval = [];
  
  do
    % Calculate new sigmas (mutation strengths)
    sigma1 = sigmaParent * alpha;
    sigma2 = sigmaParent / alpha;
    
    % Run ES isolated gamma times
     [fitness1, y1, funEvals1, fitnessHistoryFunEval1] = ES(mu, lambda, gamma, sigma1, yNew, fun);
     [fitness2, y2, funEvals2, fitnessHistoryFunEval2] = ES(mu, lambda, gamma, sigma2, yNew, fun);
     
     % get new counter values of evaluations and append evaluation history
     funEvalCounter += funEvals1 + funEvals2;
     fitnessHistoryFunEval = [fitnessHistoryFunEval; fitnessHistoryFunEval1; fitnessHistoryFunEval2];
     
     % select best new f value and sigma & y 
     if (fitness1 <= fitness2) 
      sigmaParent = sigma1;
      yNew = y1;
      fitnessParent = fitness1;
    else
      sigmaParent = sigma2; 
      yNew = y2; 
      fitnessParent = fitness2;
    end
    
     g++;
     stats.funval(g) = fitnessParent;
     sigmaHistory = [sigmaHistory ; sigmaParent]
     fitnessHistory = [fitnessHistory ; fitnessParent]
  until(fitnessParent < funValStop || g > gLimit);
  stats.fitnessHistory = fitnessHistory;
  stats.sigmaHistory = sigmaHistory;
  stats.fitnessHistoryFunEval =  fitnessHistoryFunEval;
end