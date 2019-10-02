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

atm = 1.01; % bar
P_5 = [2.25 8.75] + atm;    % bar
T_5 = [63.5 49.7 34.2 31.2 ...
    1.4 2.8 14.3 18.1];   % C

P_15 = [2.85 10.9] + atm;  % bar
T_15 = [73.0 57.3 42.2 37.8 ...
    -2.6 -1.4 6.0 12.8];  % C

% * Intall CoolPrep (requires Python and pip):
% * system([e,' -m pip install --user -U CoolProp'])

% Using CoolPrep for phase diagram
% P between 0.1 and 20 bar
for i = 1:200
    P(i) = i * 1e4;
    T(i) = py.CoolProp.CoolProp.PropsSI('T', 'P', P(i), 'Q', 1, 'R134a');
end

pl1 = plot(T - 273.15,P / 1e5,'-k');
hold on
% Points at t = 5 min 
pl2 = plot([T_5(1:4); T_5(5:8)] , [P_5(2); P_5(1)], 'ob');
% Points at t = 15 min 
pl3 = plot([T_15(1:4); T_15(5:8)] , [P_15(2); P_15(1)], 'or');

% Connect points
connect1 = [T_5 T_5(1);...
    P_5(2) P_5(2) P_5(2) P_5(2) P_5(1) P_5(1) P_5(1) P_5(1) P_5(2)];
connect2 = [T_15 T_15(1);...
    P_15(2) P_15(2) P_15(2) P_15(2) P_15(1) P_15(1) P_15(1) P_15(1) P_15(2)];
plot(connect1(1,:), connect1(2,:), 'k--');
plot(connect2(1,:), connect2(2,:), ':k');

% Plot description and settings
text([connect1(1,1) connect1(1,4) connect1(1,5) connect1(1,8)]-2,...
    [connect1(2,1) connect1(2,4) connect1(2,5) connect1(2,8)]-.5,...
    {'1', '4', '5', '8'}, 'Fontsize', 15)
text([connect2(1,1) connect2(1,4) connect2(1,5) connect2(1,8)]-1,...
    [connect2(2,1) connect2(2,4) connect2(2,5) connect2(2,8)]+.5,...
    {'1´', '4´', '5´', '8´'}, 'Fontsize', 15)

legend([pl1, pl2(1), pl3(1)], 'Kokpunkt', '5 min', '15 min',...
    'Location', 'SouthEast');
axis([-10 80 0 15])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$T$ / $^\circ$C',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$P$ / bar',labelSettings(1:2:end), labelSettings(2:2:end))
saveas(gcf,'phasediagram','epsc')


