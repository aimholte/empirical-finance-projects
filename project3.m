%AJ Imholte
%Empirical Finance, Fall 2017
%Project 3

%Backtesting of basic investment strategy

%The investement strategy proposed will be based on the True Strength
%Index. The investment strategy will be based off the centerline crossover.
%The enter signal will be when the TSI crosses the centerline from the
%bottom. The exit signal will be when the TSI crosses the centerline from
%the top. A second exit strategy with a trailing stop will also be
%considered.

%% 

%Load the data
clear;
load stockdata;
%%
applehigh=flip(appleprice(:,2));
applelow=flip(appleprice(:,3));
appleopen=flip(appleprice(:,1));

%Create the TSI indicator
appletsi = NaN(size(appleclose));
appletsi(2:end) = tsiAdvanced(appleclose, 30, 15);
signalline = ema(appletsi, 10);

%Execute the trading strategy: Buy when TSI crosses 0 from the bottom, sell
%when it crosses from the top

indicator = zeros(size(appletsi));
count = 0;
for i=2:length(appletsi)
    if(appletsi(i-1) < 0 && appletsi(i) > 0)
        indicator(i) = 1;
        count = i + 1;
        for j=count:length(appletsi)
            if(appletsi(j-1) > 0 && appletsi(j) < 0)
                indicator(j) = -1;
                break;
            end
        end
    end
end

indicator(end) = -1;
entersignal = find(indicator == 1);
exitsignal = find(indicator == -1);

%Performance evaluation

%Net Profit
tradeprofit = appleclose(exitsignal) - appleclose(entersignal);
netprofit = sum(tradeprofit);
netprofit

%Equity Line
dailyreturn = ones(length(appleclose),1);
for i=1:length(entersignal)
    dailyreturn(entersignal(i):exitsignal(i)) = 1 + diff(log(appleclose(entersignal(i)-1:exitsignal(i))));
end
cumulativereturn = cumprod(dailyreturn) * 100;
cumulativereturn(end)
plot(cumulativereturn * 100); title('Cumulative Return')

%Benchmarking - compare with buy and hold strategy
buyholdreturn = 100 * (1 + log(appleclose(end))-log(appleclose(1)));
cumulativereturn(end) > buyholdreturn %boolean statement is true
%Our cumulative return beats the the buying and holding return

%%
%Timeseries Conversion
tsits = timeseries(appletsi);
tsits = setabstime(tsits, cellstr(flip(date)));

signalts = timeseries(signalline);
signalts = setabstime(signalts, cellstr(flip(date)));

appleclosets = timeseries(appleclose);
appleclosets = setabstime(appleclosets, cellstr(flip(date)));

%Plotting
date=flip(date);
subplot(2,1,1); plot(appleclosets); title('Apple Close Price'); ylabel('Stock Price');
tick=nan(2*length(entersignal),1);
tick(1:2:end-1,1)=entersignal;
tick(2:2:end,1)=exitsignal;
datetick=datetime(cellstr(date(tick)));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;
subplot(2,1,2); plot(tsits); hold on;
plot(signalts); title('TSI Index'); ylabel('TSI Value'); xlabel('Date'); hold off
tick=nan(2*length(entersignal),1);
tick(1:2:end-1,1)=entersignal;
tick(2:2:end,1)=exitsignal;
datetick=datetime(cellstr(date(tick)));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;
%%
%Exit strategy based off of trading stop
tr=nan(size(appleclose));
tr(2:end)=max(applehigh(2:end),appleclose(1:end-1))-min(applelow(2:end),appleclose(1:end-1));
pricechange=appleclose-appleopen;

%14 days average true range
atr=ma(tr,14);

stop = zeros(size(appleclose));
%identify exit point with trailing stop
for i=1:length(entersignal)
     stop=appleclose(entersignal(i))-atr(entersignal(i));
     j=entersignal(i)+1;
     if(appleclose(j)>=stop) && (j<length(appleclose))
        if pricechange(j)>=0
            stop=appleclose(j)-atr(j);
        end
        j=j+1;
    end
    exitsignal(i,1)=j;
end

%Performance evaluation

%Net Profit
tradeprofit = appleclose(exitsignal) - appleclose(entersignal);
netprofit = sum(tradeprofit);
netprofit
plot(tradeprofit); title('Trade Profit');

%Equity Line
dailyreturn = ones(length(appleclose),1);
for i=1:length(entersignal)
    dailyreturn(entersignal(i):exitsignal(i)) = 1 + diff(log(appleclose(entersignal(i)-1:exitsignal(i))));
end
cumulativereturn = cumprod(dailyreturn) * 100;
cumulativereturn(end)
plot(cumulativereturn * 100); title('Cumulative Return');

%Benchmarking - compare with buy and hold strategy
buyholdreturn = 100 * (1 + log(appleclose(end))-log(appleclose(1)));
cumulativereturn(end) > buyholdreturn %boolean statement is true
%Our cumulative return does not beat the the buying and holding return

%%
%Convert Trailing Stop to Time Series
trailingstop = appleclose - atr;
trailingts = timeseries(trailingstop);
trailingts = setabstime(trailingts, cellstr(date));

%Plotting
subplot(2,1,1); plot(appleclosets); hold on;
plot(trailingts); title('Apple Close Price'); ylabel('Stock Price'); hold off;
tick=nan(2*length(entersignal),1);
tick(1:2:end-1,1)=entersignal;
tick(2:2:end,1)=exitsignal;
datetick=datetime(cellstr(date(tick)));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;
subplot(2,1,2); plot(tsits); hold on;
plot(signalts); title('TSI Index'); ylabel('TSI Value'); xlabel('Date'); hold off
tick=nan(2*length(entersignal),1);
tick(1:2:end-1,1)=entersignal;
tick(2:2:end,1)=exitsignal;
datetick=datetime(cellstr(date(tick)));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;
%%

%Based off this analysis, our trading strategy performed better when using 
%the TSI index to determine enter and exit points in contrast to TSI 
%determing the enter point and the exit point being determined by the
%trailing stop. Overall, the TSI buying and selling strategy beat the
%buy-and-hold strategy whereas the TSI with trailing stop did not. A
%possible improvement to the second strategy would be to make our trailing
%stop have a larger distance between the close price, so that the exit
%condition is not as easily triggered. Another possibility would be to add
%more exit conditions other than the trading stop.

        
