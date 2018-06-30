%This function calculates an exponential moving average for a given dataset
%and time period.

function [result] = ema(data, window)

%First, we calculate a simple moving average for the data and window
%period.

initialSMA = mean(data(1:1 + window - 1));
multiplier = 2 / (window + 1);
result = zeros(size(data));
result(1 + window - 1) = initialSMA(1, 1);
for i = 2:length(data) - window + 1
    if isnan(data(i)) || isnan(data(i+1))
        isnan(data(i));
    else
        result(i + window - 1) = (data(i + window - 1) - result(i + window - 2)) * multiplier + result(i + window - 2);
    end
end
