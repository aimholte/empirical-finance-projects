%Filtering False Breakouts Strategy

%%

%Load Data
load EUR2010
%Setup Data
date = datetime(time, 'ConvertFrom', 'datenum');
date = string(date);
data = [date time price];
datevector = datevec(datenum(cellstr(date)));
useabledata = [datevector price];

%%

%Setup the price data where we get the price of each date at 4pm

%Loop over the data
    %If the row of the 4th column is 16 and the one before was 15
         %Set this price as the day's close
         
indicator = zeros(size(price));    
for i=2:length(useabledata)
    if(useabledata(i-1, 4) == 15 && (useabledata(i, 4) == 16))
        indicator(i) = 1;
    end
end
   
%%

priceindices = find(indicator == 1);
closeprice = price(priceindices);
cleandata = [closeprice datevector(priceindices,:)];

%%

%Strategy Rules:
    
    %Long:
    %1. Look for a currency pair that is making a 20-day high
   [max, maxid] = MovingMaximum(closeprice, 20);
   maxindicator = zeros(size(closeprice));
           
%     for i=1:length(closeprice)
%        for j=20:length(max)
%            if(closeprice(i) == max(j))
%                maxindicator(i) = 1;
%            end
%        end
%     end
    
    %%
   
    %2. Look for the pair to reverse over the next three days to make a
    %two-day low
    stoploss = zeros(size(closeprice));
    lowindicator = zeros(size(closeprice));
    for i=1:length(closeprice)
        if(maxindicator(i) == 1 && closeprice(i+1) < closeprice(i))
            if(closeprice(i+2) < closeprice(i+1))
                lowindicator(i+2) = 1;
                stoploss(i+2) = closeprice(i+2) - 0.0005;
            end
        end
    end
    
    %%
                
    %3. Buy the pair if it takes out the 20-day high within three days of
    %making the two-day low
    maxindices = find(maxindicator == 1);
    buyindicator = zeros(size(closeprice));
    for i=1:length(maxindices)
        for j=1:length(closeprice)
            if(lowindicator(j) == 1)
                if(closeprice(j+1) > closeprice(maxindices(i)))
                buyindicator(j+1) = 1;
                break;
                end
                if(closeprice(j+2) > closeprice(maxindices(i)))
                    buyindicator(j+2) = 1;
                    break;
                end
                if(closeprice(j+3) > closeprice(maxindices(i)))
                    buyindicator(j+3) = 1;
                    break;
                end
            end
        end
    end
           
                
    %4. Place the initial stop a few pips below the original two-day low
    %that was identified in step 2
    %5. Protect any profits with a trailing stop or take profit by double
    %the amount risk
    
    %Short:
    %1. Look for a curreceny pair that is making a 20-day low
    %2. Look for the pair to reverse over the next three days to make a
    %two-day high
    %3. Sell the pair if it trades below the 20-day low within three days
    %of making the two-day high
    %4. Risk up to a few ticks above the original two-day high that was
    %identified in step 2
    %5. Protect profits with a trailing stop or take profit by double the
    %amount risked

%Setup the Strategy

%%

