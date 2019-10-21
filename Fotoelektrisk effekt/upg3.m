clear;clc;close all

% ------ Shared graph settings -------
gcaSettings = {...
    'XGrid','on',...
    'YGrid', 'on',...
    'Fontsize', 13,...
    'linewidth', 1,...
    'FontName', 'Arial'};

labelSettings = {...
    'Interpreter','latex'...
    'Fontsize', 17};
% -------------------------------------

eV = 1.6022e-19; % J 
c = 2.99792e8; % m/s

lambda = [460 500 550 600 694.3]*1e-9;  % m
I = [0.280 0.317 0.324 0.210 0.0556]*1e-6;   % A
U = [1.084 0.928 0.767 0.613 0.404]; % V

x = c./lambda *1e-12;   % THz
y = U;  % eV

% Linjaranpassning
ypol = polyfit(x, y, 1);

xline = 400:10:700;
yline = polyval(ypol,xline);

pl(1) = plot(x,y,'ko');
hold on
pl(2) = plot(xline,yline,'b-');
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$f$ / THz',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$E$ / eV',labelSettings(1:2:end), labelSettings(2:2:end))
legend([pl(1) pl(2)], 'Data', 'Lineariseringen',...
    'Location', 'SouthEast',...
    'Interpreter','latex',...
    'Fontsize', 15);
saveas(gcf,'data','epsc')

%%

x_intercept = fzero(@(x) ypol(1)*x + ypol(2), [0 1e3])*1e12;

lambda_0 = c / (x_intercept); % m
lambda_0_nm = lambda_0 * 1e9   % nm

% Line's equation (y = kx + a)
k = ypol(1) * eV * 1e-12;   % Planck's constant
a = abs(ypol(2) * eV);  % W



%% Just a test (don't add)

figure(2)
plot(x*1e12,y*eV,'ko')
hold on
plot(xline*1e12,yline*eV,'b-');
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$f$ / Hz',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$E$ / J',labelSettings(1:2:end), labelSettings(2:2:end))


















