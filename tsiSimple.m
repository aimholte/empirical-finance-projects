%This function will calculate the True Strength Index for given dataset and
%window. This function will also use the exponential moving average
%function heavily (ema), as this index uses exponential moving averages
%extensively.

function [result] = tsiSimple(data)

result = zeros(size(data));

%First, calculate the price change from one period to the next.
pc = data(2:end) - data(1:end-1);
%Then, calculate a 25-period exponential moving average:
firstSmoother = ema(pc, 25);
%Then, calculate a 13-period exponential moving average of the EMA prior
%for the smoothing effect:
secondSmoother = ema(firstSmoother, 13);
%Now, repeat the steps above for an absolute price change:
abspc = abs(pc);
%25-period exponential moving average for absolute price change
absFirstSmoother = ema(abspc, 25);
%Smoothing:
absSecondSmoother = ema(absFirstSmoother, 13);
%Now, we can calculate the TSI! Divide the double smoothed price change and
%the double smoothed absolute change. Multiple the quotient by 100.
result = (secondSmoother./absSecondSmoother) * 100;

