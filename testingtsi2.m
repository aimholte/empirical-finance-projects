%Load data
clear;
load matlabpractice9112017;


%Adjusted close price for Apple
appleclose = flip(Appleprice1(:,6));


%True Strength Index
appletsi1 = tsiAdvanced(appleclose, 40, 20);
appletsi1ema = ema(appletsi1, 10);
appletsi2 = tsiAdvanced(appleclose, 13, 7);
appletsi2ema = ema(appletsi2, 7);

date = flip(Date);
date = cellstr(flip(date));

%Plotting
appleclosets = timeseries(appleclose);
appleclosets = setabstime(appleclosets, date);
date2 = date(2:end);
appletsi1ts = timeseries(appletsi1);
appletsi1ts = setabstime(appletsi1ts, date2);
appletsi1emats = timeseries(appletsi1ema);
appletsi1emats = setabstime(appletsi1emats, date2);
appletsi2ts = timeseries(appletsi2);
appletsi2ts = setabstime(appletsi2ts, date2);
appletsi2emats = timeseries(appletsi2ema);
appletsi2emats = setabstime(appletsi2emats, date2);

% indicator = zeros(size(appletsiSimple));
% for i = 2:1509
%     if appletsiSimplets(i) < appletsiSimplets(i-1) && appletsiSimplets(i) > appletsiSimple(i+1)
%         indicator(i) = 1;
%     elseif appletsiSimple(i) > appletsiSimple(i-1) && appletsiSimple(i) < appletsiSimple(i+1)
%         indicator(i) = 1;
%     else
%         appletsiSimple(i) = 0;
%     end
% end

% subplot(2,1,1); plot(appleclosets); title('Apple Close Price'); ylabel('Stock Price');
% tick = [1 250 500 750 1000 1250 1500]';
% datetick = datetime(cellstr(flip(date(tick))));
% xticks(datetick);
% xtickformat('MM/dd/yy');
% xtickangle(45);
% grid on;
% subplot(2,1,2);
% plot(appletsi1ts,'b');
% hold on;
% plot(appletsi1emats, 'r');
% hold off;
% title('True Strength Index');
% grid on;
% set(gca, 'xticklabel', '');

subplot(2,1,1); plot(appleclosets); title('Apple Close Price'); ylabel('Stock Price');
tick = [1 250 500 750 1000 1250 1500]';
datetick = datetime(cellstr(flip(date(tick))));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;
subplot(2,1,2);
plot(appletsi2ts,'b');
hold on;
plot(appletsi2emats, 'r');
hold off;
title('True Strength Index');
grid on;
set(gca, 'xticklabel', '');



% title('Apple True Strength Index'); ylabel('TSI Value');
% %tick = [1 250 500 750 1000 1250 1500 1510]';
% datetick = datetime(cellstr(flip(date(tick))));
% xticks(datetick);
% xtickformat('MM/dd/yy');
% xtickangle(45);
% set(gca, 'xticklabel', '');
% grid on; hold on;
    


% plot(appleclosets); hold on;
% plot(appletsiSimplets); hold off;