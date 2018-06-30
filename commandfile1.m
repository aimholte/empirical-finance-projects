%This is the code to do something cool!

%Load data
clear;
load matlabpractice9112017;

%Calculate daily return
AppleReturn = log(Appleprice1(1:end-1,6)) - log(Appleprice1(2:end,6));
IBMReturn = log(IBMprice(1:end-1,6)) - log(IBMprice(2:end,6));

%Calculate standard deviation of daily return
AppleRisk = std(AppleReturn);
IBMRisk = std(IBMReturn);

%Calculate the average daily return
AppleReturnAVG = mean(AppleReturn);
IBMReturnAVG = mean(IBMReturn);

%Find the days when the close price is the maximum price of that day
DayIndex = Appleprice1(:,2) == Appleprice1(:,4);
Dates = Date(find(DayIndex == 1));

%Generate the weight matrix
Weight = zeros(length(AppleReturn), 2);
Weight(:,1) = rand(length(AppleReturn), 1);
Weight(:,2) = 1 - Weight(:,1);

%Generate the return matrix
StockReturn = [AppleReturn IBMReturn];

%Calculate portfolio return
temp = StockReturn.*Weight;
PortReturn = temp(:,1) + temp(:,2);

%Check results
%PortReturn(2) == Weight(2,1)*StockReturn(2,1) + Weight(2,2)*StockReturn(2,2)

%Plot the stock prices
plot(flip(Appleprice1(:,6))); hold on;
plot(flip(IBMprice(:,6))); hold off;

%Plot daily return for each stock
plot(flip(AppleReturn)); hold on;
plot(flip(IBMReturn)); hold off;

%Plotting multiple plots in same window
 %subplot(2,1,1); plot(flip(Appleprice1(:,6))); title('Apple Close Price');
 %xlim([200 1000]);
 %subplot(2,1,2); plot(flip(IBMprice(:,6))); title('IBM Close Price');
 appleclose = flip(Appleprice1(:,6));
 ibmclose = flip(IBMprice(:,6));
 
%Convert price data into time series data
 Applets = timeseries(flip(Appleprice1(:,6)));
 Applets = setabstime(Applets, cellstr(flip(Date)));
 
 %Plot the time series
 plot(Applets);
 tick = [1 500 1000 1511]';
 datetick = datetime(cellstr(flip(Date(tick))));
 xticks(datetick);
 xtickformat('MM/dd/yy');
 xtickangle(45);
 grid on;
 
 %Looping/iteration for moving average
%  window = 10;
%  applelma = zeros(size(appleclose)); %making sure they have the same size
%  for i = 1:length(appleclose) - window + 1
%     applelma(i+window-1) = mean(appleclose(i:i+window - 1));
%  end
%  
%   window = 3;
%  applesma = zeros(size(appleclose)); %making sure they have the same size
%  for i = 1:length(appleclose) - window + 1
%     applesma(i+window-1) = mean(appleclose(i:i+window - 1));
%  end
%  
%  i = 1; %give index a starting value
%  while i < length(appleclose)-window+1
%      applema(i+window-1) = mean(appleclose(i:i+window-1));
%      i = i + 1;
%  end

applelma = ma(appleclose, 30);
appleema = ema(appleclose, 10);
applesma = ma(appleclose, 10);

 %Find out when the close price crosses the moving average from the bottom
 indicator = zeros(size(appleclose));
 for i=2:length(appleclose)
     if applesma(i) > applelma(i) && applesma(i-1) < applelma(i-1)
         indicator(i) = 1;
     elseif applesma(i) < applelma(i) && applesma(i-1) > applelma(i-1)
         indicator(i) = -1;
         end
 end
 
 i = 2;
 while i < length(appleclose)
     if (applesma(i) > applelma(i)) && (applesma(i-1) < applelma(i-1))
         indicator(i) = 1;
         while i < length(appleclose)
             if (applesma(i) < applelma(i)) && (applesma(i-1) > applelma(i-1))
                 indicator(i) = -1;
                 break;
             end
             i = i + 1;
         end
     end
     i = i + 1;
 end
        
 
%  %Create a time series for the moving average
%  applemats = timeseries(applema);
%  applemats = setabstime(applemats, cellstr(flip(Date)));
 
%  %Plot close price and moving average
%  plot(Applets); hold on;
%  plot(applemats); hold off;
 
%  j = 1;
%  for i = 1:length(indicator)
%      if indicator(i) == 1
%          tick(j, 1) = i;
%          j = j + 1;
%      end
%  end
 
%  tick = find(indicator == 1);
%  datetick = datetime(cellstr(flip(Date(tick)))); %What are the dates?
%  xticks(datetick); %Show these dates on the x-axis
%  xtickformat('MM/dd/yy');
%  xtickangle(45);
%  grid on;
%  
%  %Create the two moving averages
%  date = flip(Date);
%  applesmats = timeseries(applesma);
%  applesmats = setabstime(applesmats, cellstr(flip(date)));
%  
%  
%  applelmats = timeseries(applelma);
%  applelmats = setabstime(applelemats, cellstr(flip(date)));
%  
%  %Plot the two
%  plot(Appleprice1); hold on;
%  plot(applesmats); hold on;
%  plot(applelmats); hold off;