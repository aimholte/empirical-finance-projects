
%Load data
clear;
load matlabpractice9112017;


%Adjusted close price for Apple
appleclose = flip(Appleprice1(:,6));


%True Strength Index
appletsiSimple = tsiSimple(appleclose);
date = flip(Date);
date = cellstr(flip(date));

%Plotting
appleclosets = timeseries(appleclose);
appleclosets = setabstime(appleclosets, date);
appletsiSimplets = timeseries(appletsiSimple);
date2 = date(2:end);
appletsiSimplets = setabstime(appletsiSimplets, date2);

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

subplot(2,1,1); plot(appleclosets); title('Apple Close Price'); ylabel('Stock Price'); xlabel('Date');
tick = [1 250 500 750 1000 1250 1500]';
datetick = datetime(cellstr(flip(date(tick))));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
grid on;
subplot(2,1,2); plot(appletsiSimplets); title('Apple True Strength Index'); ylabel('tsiSimple Value');
%tick = [1 250 500 750 1000 1250 1500 1510]';
datetick = datetime(cellstr(flip(date(tick))));
xticks(datetick);
xtickformat('MM/dd/yy');
xtickangle(45);
set(gca, 'xticklabel', '');
grid on; hold on;
    


% plot(appleclosets); hold on;
% plot(appletsiSimplets); hold off;
