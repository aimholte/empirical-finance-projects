%Mark Twain Effect Code


%%

%Load data
clear;
load('mark twain effect data.mat');

date = date(1:16859);
close = close(1:16859);
datevector = datevec(datenum(cellstr(date)));
%%

%Loop to calculate the monthly return for each month
startyear = min(datevector(:,1));
endyear = max(datevector(:,1));

monthreturn = zeros(68, 12);
for y=startyear:endyear
    for m=1:12
        clear monthdata;
        monthdata = close(find(datevector(:,1) == y & datevector(:,2) == m));
        monthreturn(y-startyear+1,m) = log(monthdata(end)) - log(monthdata(1));
    end
end

meanreturn = mean(monthreturn);
bar(meanreturn); title('Average Return for Each Month');

%Looks to be false.
%%


%Implement a trading strategy with this in mind. 
%Simple trading strategy: Buy and hold the S&P 500, sell in October. Buy at
%the beginning of November for each year.

month = datevector(:,2);

indicator = zeros(size(close));
count = 0;
for i=2:length(month)
    if(month(i) == 10 && month(i-1) == 9)
        indicator(i) = -1;
        count = i + 1;
        for j=count:length(month)
            if(month(j) == 11 && month(j-1) == 10)
                indicator(j) = 1;
            end
        end
    end
end

indicator(1) = 1;
indicator(end) = -1;
entersignal = find(indicator == 1);
exitsignal = find(indicator == -1);

%%

%Time Series Conversion
closets = timeseries(close);
closets = setabstime(closets, cellstr(date));

plot(closets); title('S&P500 Close Price');
tick=nan(2*length(entersignal),1);
tick(1:2:end-1,1)=entersignal;
tick(2:2:end,1)=exitsignal;
datetick=datetime(cellstr(date(tick)));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;

%%

%Performance Evaluation of the Strategy
%Calculate net profit, equity line, sharpe ratio, other metrics
    
%Net profit
tradeprofit = close(exitsignal) - close(entersignal);
plot(tradeprofit); title('Trade Profit');
netprofit = sum(tradeprofit);

%%

%Equity line
%equityline = equity_line(close, entersignal, exitsignal);
dailyreturn = ones(length(close),1);
dailyreturn(2:189) = 1 + diff(log(close(1:189)));
for i=2:length(entersignal)
    dailyreturn(entersignal(i):exitsignal(i)) = 1 + diff(log(close(entersignal(i)-1:exitsignal(i))));
end
cumulativereturn = cumprod(dailyreturn) * 100;
plot(cumulativereturn * 100); title('Cumulative Return')

%%

%Percentage of profitable trades
positivecount = 0;
negativecount = 0;
for i=1:length(tradeprofit)
    if(tradeprofit(i) > 0)
        positivecount = positivecount + 1;
    else
        negativecount = negativecount + 1;
    end
end

percentprofitable = positivecount/length(tradeprofit) * 100;

%Sharpe Ratio
dailyreturn = diff(log(close(entersignal(1):exitsignal(1))));
for i=2:length(entersignal)
    drst = diff(log(close(entersignal(i):exitsignal(i))));
    dailyreturn = [dailyreturn;drst];
end
sharperatio = mean(dailyreturn)/std(dailyreturn)*sqrt(252);
    
%%

%Strategy Two: Since our first graph shows that returns in October aren't
%signficantly lower than other months, let's try a different trading
%strategy. This time, instead of selling in October and buying at the start
%of November, let's buy at the start of October and sell at the start of
%November.



indicator = zeros(size(close));
count = 0;
for i=2:length(month)
    if(month(i) == 10 && month(i-1) == 9)
        indicator(i) = 1;
        count = i + 1;
        for j=count:length(month)
            if(month(j) == 11 && month(j-1) == 10)
                indicator(j) = -1;
            end
        end
    end
end

indicator(1) = 0;
indicator(end) = 0;
entersignal = find(indicator == 1);
exitsignal = find(indicator == -1);

%%

%Time Series Conversion
closets = timeseries(close);
closets = setabstime(closets, cellstr(date));

tick=nan(2*length(entersignal),1);
tick(1:2:end-1,1)=entersignal;
tick(2:2:end,1)=exitsignal;
for i=2:length(tick)
    if(tick(i) > tick(i+1))
        firstswitch = tick(i+1);
        secondswitch = tick(i);
        tick(i+1) = secondswitch;
        tick(i) = firstswitch;
    end
end   
%%

plot(closets); title('S&P500 Close Price');
datetick=datetime(cellstr(date(tick)));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;


%%

%Performance Evaluation of the Strategy Above


%Net profit
tradeprofit = close(exitsignal) - close(entersignal);
plot(tradeprofit); title('Trading Profit')
netprofit = sum(tradeprofit);

%%

%Equity line
%equityline = equity_line(close, entersignal, exitsignal);
dailyreturn = ones(length(close),1);
dailyreturn(1:188) = 1 + diff(log(close(1:189)));
for i=2:length(entersignal)
    dailyreturn(entersignal(i):exitsignal(i)) = 1 + diff(log(close(entersignal(i)-1:exitsignal(i))));
end
cumulativereturn = cumprod(dailyreturn) * 100;
plot(cumulativereturn * 100); title('Cumulative Return')

%%

%Percentage of profitable trades
positivecount = 0;
negativecount = 0;
for i=1:length(tradeprofit)
    if(tradeprofit(i) > 0)
        positivecount = positivecount + 1;
    else
        negativecount = negativecount + 1;
    end
end

percentprofitable = positivecount/length(tradeprofit) * 100;

%Sharpe Ratio
dailyreturn = diff(log(close(entersignal(1):exitsignal(1))));
for i=2:length(entersignal)
    drst = diff(log(close(entersignal(i):exitsignal(i))));
    dailyreturn = [dailyreturn;drst];
end
sharperatio = mean(dailyreturn)/std(dailyreturn)*sqrt(252);
    

%%

%Benchmarking - compare with buy and hold strategy
dailyreturn = ones(length(close),1);
for i=2:length(close)
    dailyreturn((i):(i+1)) = 1 + diff(log(close((i)-1:(i))));
end
cumulativereturn = cumprod(dailyreturn) * 100;
plot(cumulativereturn * 100); title('Cumulative Return')
buyholdprofit = close(end) - close(1);
totalreturn = diff(log(close(1:end)));
sharperatio = mean(totalreturn)/std(totalreturn)*sqrt(252);

