%this is the code to do xx

%load data
clear;
load stockdata;

%calculate daily return
applereturn=log(appleprice(1:end-1,6))-log(appleprice(2:end,6));
ibmreturn=log(ibmprice(1:end-1,6))-log(ibmprice(2:end,6));
stockreturn=[applereturn ibmreturn];

%generate weight matrix
weight=zeros(length(applereturn),2);
weight(:,1)=rand(length(applereturn),1);
weight(:,2)=1-weight(:,1);

%calculate portfolio return
temp=stockreturn.*weight;
portreturn=temp(:,1)+temp(:,2);

% %check calculation is correct or not
% portreturn(2)==weight(2,1)*stockreturn(2,1)+weight(2,2)*stockreturn(2,2)


%calculate standard deviation
applerisk=std(applereturn);
ibmrisk=std(ibmreturn);

%calculate average return
applemean=mean(applereturn);
ibmmean=mean(ibmreturn);

%identify days when close price is maximum price that day
dayindex=appleprice(:,2)==appleprice(:,4);

%plot stock prices
appleclose=flip(appleprice(:,4));
applehigh=flip(appleprice(:,2));
applelow=flip(appleprice(:,3));
appleopen=flip(appleprice(:,1));
ibmclose=flip(ibmprice(:,6));
% subplot(2,1,1); plot(appleclose); title('Apple close price');
% xlim([200 1000]);
% subplot(2,1,2); plot(ibmclose); title('IBM close price');

%convert price data into time series data
applets=timeseries(appleclose);
applets=setabstime(applets,cellstr(flip(date)));

%plot time series
%plot(applets);
tick=[1 500 1000 1511]';
datetick=datetime(cellstr(flip(date(tick))));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;

%calculate moving average
% window=10;
% applesma=zeros(size(appleclose));
% for i=1:length(appleclose)-window+1
%     applesma(i+window-1)=mean(appleclose(i:i+window-1));
% end

% window=30;
% applelma=zeros(size(appleclose));
% for i=1:length(appleclose)-window+1
%     applelma(i+window-1)=mean(appleclose(i:i+window-1));
% end
applesma=ma(appleclose,10);
applelma=ma(appleclose,30);

% i=1; %give index starting value
% while i<length(appleclose)-window+1
%     applema(i+window-1)=mean(appleclose(i:i+window-1));
%     i=i+1;
% end

%searchs when price crosses ma from bottom
indicator=zeros(size(appleclose));
% for i=2:length(appleclose)
%     if (applesma(i)>applelma(i)) && (applesma(i-1)<applelma(i-1))
%         indicator(i)=1;
%     elseif (applesma(i)<applelma(i)) && (applesma(i-1)>applelma(i-1))
%             indicator(i)=-1;
%     end
% end
   
i=2;
while i<length(appleclose)
    if (applesma(i)>applelma(i)) && (applesma(i-1)<applelma(i-1))
        indicator(i)=1;
        while i<length(appleclose)
            if (applesma(i)<applelma(i)) && (applesma(i-1)>applelma(i-1)) 
                indicator(i)=-1;
                break;
            end
            i=i+1;
        end
    end
    i=i+1;
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
% tr=nan(size(appleclose));
% tr(2:end)=max(applehigh(2:end),appleclose(1:end-1))-min(applelow(2:end),appleclose(1:end-1));
% pricechange=appleclose-appleopen;
% 
% %14 days average true range
% atr=ma(tr,14);
% 
% entersignal=find(indicator==1);
% %identify exit point with trailing stop
% for i=1:length(entersignal)
%      stop=appleclose(entersignal(i))-atr(entersignal(i));
%      j=entersignal(i)+1;
%      while (appleclose(j)>=stop) && (j<length(appleclose))
%         if pricechange(j)>=0
%             stop=appleclose(j)-atr(j);
%         end
%         j=j+1;
%     end
%     exitsignal(i,1)=j;
% end


%convert moving average data into time series
applesmats=timeseries(applesma);
applesmats=setabstime(applesmats,cellstr(flip(date)));

applelmats=timeseries(applelma);
applelmats=setabstime(applelmats,cellstr(flip(date)));

%plot close price and moving average
date=flip(date);
% plot(applets); hold on;
% plot(applesmats); hold on;
% plot(applelmats,'green'); hold off;
%tick=find(indicator~=0);
tick=nan(2*length(entersignal),1);
tick(1:2:end-1,1)=entersignal;
tick(2:2:end,1)=exitsignal;
datetick=datetime(cellstr(date(tick)));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;


%performance evaluation
%net profit
tradeprofit=appleclose(exitsignal)-appleclose(entersignal);
netprofit = sum(tradeprofit);

%equity line
dailyreturn = ones(length(appleclose),1);
for i=1:length(entersignal)
    dailyreturn(entersignal(i):exitsignal(i)) = 1 + diff(log(appleclose(entersignal(i)-1:exitsignal(i))));
end

cumureturn = cumprod(dailyreturn);
%plot(100*cumureturn);

%benchmarking - compare with buy and hold strategy
buyholdreturn = 100 * (1 + log(appleclose(end))-log(appleclose(1)));


%%

%Load data
clear;
load stockdata;




