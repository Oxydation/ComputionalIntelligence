function[newPath] = lin2opt(path)   
  % check if input is hori/verti
  if size(path,1) == 1
    path = path';
  end
  
  pathSize = size(path, 1);
  
  do
    % Get two random points
    firstPoint = round(rand(1) * pathSize);
    secondPoint = round(rand(1) * pathSize);
    
    % if the first point is higher than the last, then swap both
    if(firstPoint > secondPoint)
      [firstPoint, secondPoint] = swap(firstPoint,secondPoint);
    end
  until (firstPoint < secondPoint-1 && firstPoint > 0)

  % create a path and flip everything between the two points
  pathToChange = path(firstPoint:secondPoint);
  newPath = [path(1:firstPoint-1);flip(pathToChange);path(secondPoint+1:end)];  
end

%function [changedPath] = lin2opt(originalPath)
%  % check input
%  if size(originalPath,1) == 1
%    originalPath = originalPath';
%  end
%  pathSize = size(originalPath,1);
%  
%  do
%    firstEdgeIndex = round(rand(1)*pathSize);
%    secondEdgeIndex = round(rand(1)*pathSize);
%    
%    if(firstEdgeIndex > secondEdgeIndex)
%      tempIndex = firstEdgeIndex;
%      firstEdgeIndex = secondEdgeIndex;
%      secondEdgeIndex = tempIndex;
%    end
%  until firstEdgeIndex < secondEdgeIndex-1 && firstEdgeIndex > 0;
%
%  pathToChange = originalPath(firstEdgeIndex:secondEdgeIndex);
%  changedPath = [originalPath(1:firstEdgeIndex-1);flip(pathToChange);originalPath(secondEdgeIndex+1:end)];
%end
function[a,b] = swap(a, b)
    temp = a;
    a = b;
    b = temp;
end
  