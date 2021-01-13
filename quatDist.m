function distance = quatDist(Q1,Q2,dist_opt)
% Calculates a distance between rotations represented by quaternions.
% Distance options are taken from the paper:
% Metrics for 3D Rotations: Comparison and Analysis by Du Q. Huynh

if nargin < 3
  dist_opt = -1;
end

[r,c] = size(Q1);
distance = zeros(r,c);

[R1,X1,Y1,Z1] = parts(Q1);
[R2,X2,Y2,Z2] = parts(Q2);

switch dist_opt
    
    case 2 % distance 2 - range [

        if r > 1 % for quaternions in a column vector
            Qdiff = [R1,X1,Y1,Z1]-[R2,X2,Y2,Z2];
            Qsum = [R1,X1,Y1,Z1]+[R2,X2,Y2,Z2];
            for i = 1:r
                distance(i,1) = min(norm(Qdiff(i,:)),norm(Qsum(i,:)));
            end
        else % for quaternions in a row vector
            Qdiff = [R1;X1;Y1;Z1]-[R2;X2;Y2;Z2];
            Qsum = [R1;X1;Y1;Z1]+[R2;X2;Y2;Z2];
            for i = 1:c
                distance(1,i) = min(norm(Qdiff(:,i)),norm(Qsum(:,i)));
            end
        end
        
    case 3 % distance 3 - range [0 pi/2]
        
        if r > 1 % for quaternions in a column vector
            distance = acos(dot([R1,X1,Y1,Z1],[R2,X2,Y2,Z2],2)); 
        else % for quaternions in a row vector
            distance = acos(dot([R1;X1;Y1;Z1],[R2;X2;Y2;Z2])); 
        end
        
    case 4 % distance 4 - range [0 1]
        
        if r > 1 % for quaternions in a column vector
            temp = abs(dot([R1,X1,Y1,Z1],[R2,X2,Y2,Z2],2)); 
        else % for quaternions in a row vector
            temp = abs(dot([R1;X1;Y1;Z1],[R2;X2;Y2;Z2])); 
        end

        distance = 1-temp;
        
    case 5 % distance 5 - range [

        if r > 1 % for quaternions in a column vector
            temp = abs(dot([R1,X1,Y1,Z1],[R2,X2,Y2,Z2],2)); 
        else % for quaternions in a row vector
            temp = abs(dot([R1;X1;Y1;Z1],[R2;X2;Y2;Z2])); 
        end

        distance = 2*sqrt(2*(1-temp.^2));
        
    case 6 % distance 6 - range [0 pi)
        
        if r > 1 % for quaternions in a column vector
            distance = 2*acos(dot([R1,X1,Y1,Z1],[R2,X2,Y2,Z2],2)); 
        else % for quaternions in a row vector
            distance = 2*acos(dot([R1;X1;Y1;Z1],[R2;X2;Y2;Z2])); 
        end
    
    otherwise % MATLAB built in distance - equivalent to distance 6 - range [0 pi)

        distance = dist(Q1,Q2);
       
end

end