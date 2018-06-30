
clear;
load midtermpractice;


%data to use
amazonopen = amazonstock(:,1);
amazonhigh = amazonstock(:,2);
amazonlow = amazonstock(:,3);
amazonclose = amazonstock(:,5);

%calculate daily return
amazonreturn = log(amazonclose(1:end-1)) - log(amazonclose(2:end));

%average return
averagereturn = mean(amazonreturn) * 100;

%identify days when close price is maximum price that day
dayindex = amazonclose==amazonhigh;

%plot stock price
plot(amazonclose);

%convert price data into time series data
amazonts = timeseries(amazonclose);
amazonts = setabstime(amazonts, cellstr(flip(date)));
% plot(amazonts); title('Amazon Stock Price'); ylabel('Price'); xlabel('Date');
% tick = find(dayindex==1);
% datetick = datetime(cellstr(date(tick)));
% xticks(datetick);
% xtickformat('MM/dd/yy');
% xtickangle(45);
% grid on;

%Create two exponential moving averages for MACD trading strategy
shortema = ema(amazonclose, 5);
longema = ema(amazonclose, 10);

%Search for when the small ema crosses the large ema from the bottom
indicator = zeros(size(amazonclose));
count = 0;
for i=2:length(amazonclose)
    buysignal = 0;
    count = 0;
    if(shortema(i) > longema(i) && shortema(i-1) < longema(i-1))
        indicator(i) = 1;
        buysignal = 1;
        count = i + 1;
        for j=count:length(amazonclose)
            if(shortema(j) < longema(j) && shortema(j-1) > longema(j-1) && buysignal == 1)
                indicator(j) = -1;
                break;
            end
        end
    end
end


indicator(end) = -1;
entersignal = find(indicator == 1);
exitsignal= find(indicator == -1);

%% trailing stop exit
%identify exit point
%calculate average true range
%true range: 
% The true range is the largest of the:
% 
%     * Most recent period's high less the most recent period's low
%     * Absolute value of the most recent period's high less the previous close
%     * Absolute value of the most recent period's low less the previous close
tr=nan(size(amazonclose));
tr(2:end)=max(amazonhigh(2:end),amazonclose(1:end-1))-min(amazonlow(2:end),amazonclose(1:end-1));
pricechange=amazonclose-amazonopen;

%14 days average true range
atr=ma(tr,14);

for i=1:length(entersignal)
    stop = amazonclose(entersignal(i))-atr(entersignal(i));
    j = entersignal(i) + 1;
    while(amazonclose(j)>=stop) && (j<length(amazonclose))
         if pricechange(j)>=0
             stop=amazonclose(j)-atr(j);
         end
         j=j+1;
     end
     exitsignal(i,1)=j;
end

%Convert moving averages into time series data

shortemats = timeseries(shortema);
shortemats = setabstime(shortemats, cellstr(flip(date)));

longemats = timeseries(longema);
longemats = setabstime(longemats, cellstr(flip(date)));

%Plotting
date=flip(date);
plot(amazonts); hold on;
plot(shortemats); hold on;
plot(longemats,'green'); hold off;
%tick=find(indicator~=0);
tick=nan(2*length(entersignal),1);
tick(1:2:end-1,1)=entersignal;
tick(2:2:end,1)=exitsignal;
datetick=datetime(cellstr(date(tick)));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;


