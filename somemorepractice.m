%%

%Load Data
clear;
start_year = '01012001';
end_year = '01012016';
asset1 = 'coke';
asset2 = 'pep';

stock1 = hist_stock_data(start_year, end_year, asset1);
stock2 = hist_stock_data(start_year, end_year, asset2);

%%

date = stock1.Date;
open = stock1.Open;
high = stock1.High;
low = stock1.Low;
close = stock1.AdjClose;
volume = stock1.Volume;

price1 = [open high low close volume];

date = stock2.Date;
open = stock2.Open;
high = stock2.High;
low = stock2.Low;
close = stock2.AdjClose;
volume = stock2.Volume;

price2 = [open high low close volume];




%% make sure two prices have some observation number
%find all the days when either price has data.

result = OLS(price1(:,4), price2(:,4));
spread = price1(:,4) - result * price2(:,4);
plot(spread);
%res = adftest(price1(:,4), price2(:,4), 0, 1); %This would run an
%Augmented Dickey Fuller test, but we don't have the Econometrics Toolbox.
%Sad!
plot(res);