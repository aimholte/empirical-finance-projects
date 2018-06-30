
%Load data
clear;
load stockdata;

date = flip(date);
datevector = datevec(datenum(cellstr(date)));
close = appleclose;
%The line of code above converts the data variable(string) into a cell
%string, which then converts that into a corresponding number, and then
%finally into a vector that represents the date.

%Loop to calculate the monthly rectrn for each month
startyear = min(datevector(:,1));
endyear = max(datevector(:,1));

for y=startyear:endyear
    for m=1:12
        clear monthdata;
        monthdata = close(find(datevector(:,1) == y & datevector(:,2) == m));
        monthreturn(y-startyear+1,m) = log(monthdata(end)) - log(monthdata(1));
    end
end

meanreturn = mean(monthreturn);
bar(meanreturn);

%Trading performance
netprofit = sum(monthreturn(:,1));


        

