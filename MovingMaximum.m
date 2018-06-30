%This function calculates moving maximum giving a window date. Returns a
%matrix of maximum values along with their indices

function [maxprices, index] = MovingMax(data, window)

maxprices = zeros(size(data));
index = zeros(size(data));
for i = 1:length(data) - window + 1
    [maxprices(i + window - 1), index(i + window - 1)] = max(data(i:i + window - 1));
    index(i + window - 1) = index(i + window - 1) + i - 1; 
end
end