function [result] = tsiAdvanced(data,smoother1,smoother2)
%This function calculates the True Strength Index for a given dataset along
%with an exponential moving average of the True Strength Index.
%   This function utilizes much of the same framework as the the tsi(data)
%   function, but allows the user to input parameters for smoother periods
%   for the applied exponential moving averages to the price changes. It
%   also allows the user to calibrate an exponential moving average for the
%   TSI itself with the parameter numPeriodsTSIEMA

result = zeros(size(data));

%First, calculate the price change from one period to the next.
pc = data(2:end) - data(1:end-1);

%Then, calculate a n-period exponential moving average:
firstSmoother = ema(pc, smoother1);

%Then, calculate a n-period exponential moving average of the EMA prior
%for the smoothing effect:

secondSmoother = ema(firstSmoother, smoother2);

%Now, repeat the steps above for an absolute price change:
abspc = abs(pc);

%n-period exponential moving average for absolute price change
absFirstSmoother = ema(abspc, smoother1);

%Smoothing:
absSecondSmoother = ema(absFirstSmoother, smoother2);

%Now, we can calculate the TSI! Divide the double smoothed price change and
%the double smoothed absolute change. Multiple the quotient by 100.
result = (secondSmoother./absSecondSmoother) * 100;
end

