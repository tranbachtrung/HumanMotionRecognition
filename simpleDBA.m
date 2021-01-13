function [DBAvalue] = simpleDBA(sequences,method)

if nargin < 2
  method = "euclidean";
end

average = sequences{medoidIndex(sequences,method)};
for i = 1:15
    DBAvalue = oneIterationDBA(average,sequences,method);
end    
end

function [average] = oneIterationDBA(average,sequences,method)

% find the number of sequences and the size of each sequence
% here the rows are different varables; the columns are time increments
numsequences = length(sequences);
[~,cavg] = size(average);

% initialize a list of indices to be averaged
avglist = cell(1,cavg);
if method == "quaternion"
    for i = 1:cavg
        avglist{i} = quaternion();
    end
else
    for i = 1:cavg
        avglist{i} = [];
    end
end

for i = 1:numsequences
    currentseq = sequences{i};
    [~,optipath] = simpleDTW(average,currentseq,method);
    for j = 1:length(optipath(:,1))
        avgloc = optipath(j,1);
        seqloc = optipath(j,2);
        avglist{avgloc}(:,end+1) = currentseq(:,seqloc);
    end
end

for i = 1:cavg
    if method == "quaternion"
        average(i) = meanrot(avglist{i});
    else
        average(:,i) = mean(avglist{i},2);
    end    
end

end

function index = medoidIndex(sequences,method)
index = -1;
lowestInertia = Inf;
for i = 1:length(sequences)
    tempInertia = sumOfSquares(sequences{i},sequences,method);
    if tempInertia < lowestInertia
        index = i;
        lowestInertia = tempInertia;
    end
end
end

function sos = sumOfSquares(s,sequences,method)
sos = 0;
for i = 1:length(sequences)
    dist = simpleDTW(s,sequences{i},method);
    sos = sos+dist*dist;
end
end