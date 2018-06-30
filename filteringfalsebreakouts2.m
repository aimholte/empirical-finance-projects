%%Filtering False Breakouts
%%A.J. Imholte, Phil Wettersten
%%Empirical Finance

%Load Data
clear;
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
% indicator2 = zeros(size(closeprice));
% for i=length(closeprice):-1:20
%     window = i - 19;
%     start = i;
%     for j=start:-1:window
%         if(closeprice(j) == max(closeprice(i-19:i)))
%             indicator2(j) = 1;
%             break;
%         end
%     end
% end  

%%

%Long condition:

%longbuycondition = false;
longbuyindicator = zeros(size(closeprice));
longsellindicator = zeros(size(closeprice));
i = length(closeprice);
%     while(i ~= 0)
for i=length(closeprice):-1:20
        start = i;
        window = i - 19;
        for k=start:-1:window
            if(closeprice(k) == max(closeprice(i-19:i)))
                if(closeprice(k+1) < closeprice(k) && closeprice(k+2) < closeprice(k+1))
                    if(closeprice(k+3) > closeprice(k))
                        longbuyindicator(k+3) = 1;
                        sellcondition = false;
                        amountrisked = closeprice(k) - closeprice(k+2);
                        originalmax = closeprice(k);
                        j = i + 1;
                        while(sellcondition ~= true)
                            if(closeprice(j) >= (originalmax + 2*amountrisked))
                                longsellindicator(j) = 1;
                                sellcondition = true;
                            end
                            j = j + 1;
                        end
                        break;
                    end
                        if(closeprice(k+4) > closeprice(k))
                            longbuyindicator(k+4) = 1;
                            sellcondition = false;
                            amountrisked = closeprice(k) - closeprice(k+2);
                            originalmax = closeprice(k);
                            j = i + 1;
                            while(sellcondition ~= true)
                                if(closeprice(j) >= (originalmax + 2*amountrisked))
                                longsellindicator(j) = 1;
                                sellcondition = true;
                                end
                            j = j + 1;
                            end
                            break;
                        end
                    if(closeprice(k+5) > closeprice(k))
                        longbuyindicator(k+5) = 1;
                        sellcondition = false;
                        amountrisked = closeprice(k) - closeprice(k+2);
                        originalmax = closeprice(k);
                        j = i + 1;
                        while(sellcondition ~= true)
                            if(closeprice(j) >= (originalmax + 2*amountrisked))
                            longsellindicator(j) = 1;
                            sellcondition = true;
                            end
                            j = j + 1;
                        end
                        break;
                    end
                end
            end
        end
end
%%
shortbuyindicator = zeros(size(closeprice));
shortsellindicator = zeros(size(closeprice));
stoploss = zeros(size(closeprice));

for i=length(closeprice):-1:20
        start = i;
        window = i - 19;
        for k=start:-1:window
            if(closeprice(k) == min(closeprice(i-19:i)))
                if(closeprice(k+1) > closeprice(k) && closeprice(k+2) > closeprice(k+1))
                    twodaymax = closeprice(k+2) + 0.0010;
                    if(closeprice(k+3) < closeprice(k))
                        shortbuyindicator(k+3) = 1;
                        sellcondition = false;
                        amountrisked = closeprice(k+2) - closeprice(k);
                        originalmax = closeprice(k);
                        stop = originalmax + 0.0010;
                        j = i + 1;
                        while(sellcondition ~= true)
                            if(closeprice(j) <= (originalmax - 2*amountrisked))
                                shortsellindicator(j) = 1;
                                sellcondition = true;
                                break;
                            end
                            if(closeprice(j) >= stop)
                                shortsellindicator(j) = 1;
                                sellcondition = true;
                                break;
                            end
                            j = j + 1;
                        end
                        break;
                    end
                        if(closeprice(k+4) < closeprice(k))
                            shortbuyindicator(k+4) = 1;
                            sellcondition = false;
                            amountrisked = closeprice(k+2) - closeprice(k);
                            originalmax = closeprice(k);
                            stop = originalmax + 0.0010;
                            j = i + 1;
                            while(sellcondition ~= true)
                                if(closeprice(j) <= (originalmax - 2*amountrisked))
                                    shortsellindicator(j) = 1;
                                    sellcondition = true;
                                    break;
                                end
                                if(closeprice(j) >= stop)
                                    shortsellindicator(j) = 1;
                                    sellcondition = true;
                                    break;
                                end
                            j = j + 1;
                            end
                            break;
                        end
                    if(closeprice(k+5) < closeprice(k))
                        shortbuyindicator(k+5) = 1;
                        sellcondition = false;
                        amountrisked = closeprice(k+2) - closeprice(k);
                        originalmax = closeprice(k);
                        j = i + 1;
                        stop = originalmax + 0.0010;
                        while(sellcondition ~= true)
                            if(closeprice(j) <= (originalmax - 2*amountrisked))
                                shortsellindicator(j) = 1;
                                sellcondition = true;
                                break;
                            end
                            if(closeprice(j) >= stop)
                                shortsellindicator(j) = 1;
                                sellcondition = true;
                                break;
                            end
                            j = j + 1;
                        end
                        break;
                    end
                end
            end
        end
end

%%

sellindices = [26 90 97 173 236]';
buyindices = find(shortbuyindicator == 1);
netprofit1 = closeprice(buyindices) - closeprice(sellindices);
sellindices = find(longbuyindicator == 1);
buyindices = find(longsellindicator == 1);
netprofit2 = closeprice(buyindices) - closeprice(sellindices);
buyholdprofit = closeprice(end) - closeprice(1);

%%
sellindices = find(longbuyindicator == 1);
buyindices = find(longsellindicator == 1);

%Sharpe Ratio
dailyreturn = diff(log(closeprice(buyindices(1):sellindices(1))));
for i=2:length(buyindices)
    drst = diff(log(closeprice(buyindices(i):sellindices(i))));
    dailyreturn = [dailyreturn;drst];
end
sharperatio = mean(dailyreturn)/std(dailyreturn)*sqrt(252);

%%

                        
