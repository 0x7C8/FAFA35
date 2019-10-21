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

T = [30 130] + 273.15;  % K
R = 8.314;   % m^3 * Pa * K^-1 * mol^-1
a = 36.3e-2;    % CO2
b = 3.99e-5;    % CO2
n = 1; % mol

V = 1e-6:1e-6:5e-3;   % m^3

P_a = @(V,T) n*R.*T./V; % Ideal Gas Law
P_w = @(V,T) R.*T./(V./n - b) - a.*n^2./V.^2;   % Van der Waals

V_l = V * 1e3;  % m3 to l
toAtm = 101325; % Pa per atm

plot(V_l, P_a(V,T(1))/toAtm, 'b-');
hold on
plot(V_l, P_a(V,T(2))/toAtm, 'r-');
plot(V_l, P_w(V,T(1))/toAtm, 'b--')
plot(V_l, P_w(V,T(2))/toAtm, 'r--')

leg = legend('IGL 30$^{\circ}$C', 'IGL 130$^{\circ}$C',...
    'VdW 30$^{\circ}$C', 'VdW 130$^{\circ}$C');
set(leg,'Interpreter','latex');
set(leg,'FontSize',15);
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$V$ / $l$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$P$ / atm',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:.2:2)
yticks(0:25:200)
axis([0 2 0 200])
saveas(gcf,'VdW_gas','epsc')
%% Zoom
xticks([0:.05:.15 .2:.1:.5])
yticks(0:25:200)
axis([0 .5 0 200])
saveas(gcf,'VdW_gas_zoom','epsc')















