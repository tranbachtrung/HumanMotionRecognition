function [DTWdist,varargout] = simpleDTW(A,B,method)

if nargin < 3
  method = "euclidean";
end

[~,cA] = size(A);
[~,cB] = size(B);

costM = zeros(cA,cB);

costM(1,1) = calcCost(A(:,1),B(:,1),method);

for i = 2:cA
    costM(i,1) = costM(i-1,1)+calcCost(A(:,i),B(:,1),method);
end

for j = 2:cB
    costM(1,j) = costM(1,j-1)+calcCost(A(:,1),B(:,j),method);
end

for i = 2:cA
    for j = 2:cB
        costM(i,j) = min(min(costM(i-1,j),costM(i-1,j-1)),costM(i,j-1))+calcCost(A(:,i),B(:,j),method);
    end
end

DTWdist = sqrt(costM(cA,cB));
% flipud(costM) % this puts the cost matrix in the typical orientation.

scfactor = 1;
optipath(1,:) = [cA,cB];

while (i+j)~=2
    
    if i==1
        j = j-1;
    elseif j ==1
        i = i-1;
    else
        [~,num] = min([costM(i-1,j),costM(i,j-1),costM(i-1,j-1)]);
        switch num
            case 1
                i = i-1;
            case 2
                j = j-1;
            case 3
                i = i-1;
                j = j-1;
        end
    end
    
    scfactor = scfactor+1;
    optipath = cat(1,optipath,[i,j]);
end
    varargout{1} = flipud(optipath);
    varargout{2} = scfactor;
end

function cost = calcCost(a,b,method)

switch method
    case "euclidean"
        cost = sqrt(sum((a-b).^2));
    case "squared"
        cost = sum((a-b).^2);
    case "quaternion"
        cost = quatDist(a,b);
end
    
end