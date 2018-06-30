%%

%Finding the Optimal Portfolio Using Simulation Methodology

%Load data
clear;
load stockdata;

%Calculate return
applereturn = log(appleprice(1:end-1, 6)) - log(appleprice(2:end, 6));
ibmreturn = log(ibmprice(1:end-1, 6)) - log(ibmprice(2:end, 6));
stockreturn = [applereturn ibmreturn];

%Simulate weights
stocknumber = size(stockreturn,2);
trialnumber = 100000;

%Weight matrix
mat = rand(trialnumber, stocknumber);
rowsum = sum(mat, 2); %Does the summation of each row
rowsum = repmat(rowsum,1,stocknumber);
wmat = mat./rowsum;

%Calculate portfolio return and risk
portreturn = stockreturn * wmat';
exportreturn = mean(portreturn);
riskportreturn = std(portreturn);

%Graph the efficient frontier
scatter(riskportreturn, exportreturn);
xlim([0, 0.03]);
ylim([0, 0.0025]);

%Calculate the Sharpe Ratio
sharperatio = exportreturn./riskportreturn;
find(sharperatio == max(sharperatio)) %Which index of the portfolio has
%the highest Sharpe Ratio
wmat(find(sharperatio == max(sharperatio)), :)