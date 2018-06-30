%Load data
clear;
load testingtsiworkspace

microsoftClose = MSFT(:,5);
date = MSFT1;

microsofttsi1 = tsiAdvanced(microsoftClose, 25, 13);
tsi1ema = ema(microsofttsi1, 13);
microsofttsi2 = tsiAdvanced(microsoftClose, 50, 25);
tsi2ema = ema(microsofttsi2, 20);