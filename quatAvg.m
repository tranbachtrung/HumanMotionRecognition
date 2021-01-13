function Qavg = quatAvg(Q)
% Calculates an average of rotations represented by quaternions.
% Details are given by the paper:
% Averaging Quaternions by Markley et al.

% number of quaternions
quatnum = length(Q);

% for the symmetric accumulator matrix
A = zeros(4,4);

for i = 1:quatnum
    [r,x,y,z] = parts(Q{i}); % find the real parts of the quaternion
    qvec = [r x y z]';
    if qvec(1) < 0
        qvec = -qvec; % handle the antipodal configuration
    end
    A = A + qvec*qvec'; % rank 1 update
end

A = 1/quatnum*A;

[V,~] = eigs(A,1); % find the eignevector corresponding to the largest eigenvalue

Qavg = quaternion(V'); % return to quaternion form

end