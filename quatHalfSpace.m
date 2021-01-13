function [quat] = quatHalfSpace(quat)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[n,~] = size(quat);
[q0,~,~,~] = parts(quat);

for i = 1:n
    if q0(i) <= 0
        quat(i,:) = -quat(i,:);
    end
end

