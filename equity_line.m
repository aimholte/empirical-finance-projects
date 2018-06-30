%This function returns the equity line for given stock data and entry and
%exit signals.

function [result] = equity_line(data,entersignal,exitsignal)

dailyreturn = ones(length(data),1);
for i=1:length(entersignal)
    dailyreturn(entersignal(i):exitsignal(i)) = 1 + diff(log(data(entersignal(i)-1:exitsignal(i))));
end
result = cumprod(dailyreturn) * 100;
