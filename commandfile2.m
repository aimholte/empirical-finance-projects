%Load data
clear;
load matlabpractice9112017;

appleclose = flip(Appleprice1(:,6));

%Test of the tsi function

result = size(appleclose);

%First, calculate the price change from one period to the next.
pc = appleclose(2:end) - appleclose(1:end-1);
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
