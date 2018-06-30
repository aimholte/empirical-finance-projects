function [result] = ma(data, window)
%This function calculates a simple moving average
%Input: data and window
%Output: Simple moving average

result = zeros(size(data));
for i=1:length(data) - window + 1
    result(i + window - 1) = mean(data(i:i + window - 1));
end