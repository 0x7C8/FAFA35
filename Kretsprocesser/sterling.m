clear;clc; close all

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

%   Calibration
p_min = 1.0e5;   % Pa
p_max = 1.7e5;   % Pa
r = 30e-3;  % m
h = 48e-3;  % m

p_units = (p_max - p_min)/45;  % Pa/unit
V_units = (pi*r^2*h)/53;       % m^3/unit


% Banana's endpoints
p_1 = p_min + 2*p_units;    % lowest pressure
p_2 = p_1 + 65*p_units;     % highest pressure

delta_V = 51*V_units;   % V_max - V_min

% Lower curve
V_lower = V_units * ...
    [0 2 6 8 13 ...
    20 25 33 43 51];
p_lower = p_1 + p_units * ...
    [65 55 46 41 32 ...
    22 16 9 2 0];

lower = polyfit(V_lower,p_lower,5);

x= 0:V_units:V_units*51;
f_lower = polyval(lower, x);

% Upper curve
V_upper = V_units * ...
    [0 7 10 13 16 19 ...
    23 27 31 36 45 51];
p_upper = p_1 + p_units * ...
    [65 54 50 45 40 36 ...
    30 25 19 14 5 0];

upper = polyfit(V_upper,p_upper,5);

f_upper = polyval(upper, x);

% Plot 
plot(x,f_lower, 'k--', 'LineWidth', 2) % lower part of banana
hold on
plot(x,f_upper, 'k--', 'LineWidth', 2) % upper part of banana
axis([-.1e-4 1.5e-4 .8e5 2.2e5])

set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$V/ m^3$ ',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$P/$ Pa',labelSettings(1:2:end), labelSettings(2:2:end))
set(gca,'xtick',[V_upper(1) V_upper(end)],...
    'ytick',[p_upper(end) p_upper(1)],...
    'xticklabel', {'V_1' 'V_2'})
ytickformat('%.2f')
box off
saveas(gcf,'banana','epsc')

% Power and Energy
t = 0.292; % time per period
P_in = 100; % W

W = trapz(x, f_upper - f_lower);    % J
P_real = W/t;   % W
e = P_real/P_in;    % efficiency













