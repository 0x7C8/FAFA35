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
    'Fontsize', 19};
% -------------------------------------

T_1 = 300; % K
T_2 = 600; % K
T_E = 1060; % K
T_E_real = 1320; % K (REAL!)
R = 8.314;   % J * K^-1 * mol^-1
n = 1;  % mol
m = 12 * 1; % g

Temp = T_1:1:T_2;

c_v = @(T) 3.*R.*(T_E./T).^2 .* exp(T_E./T)./(exp(T_E./T) - 1).^2;


U = 3*R * integral(...
    @(T) (T_E./T).^2 .* exp(T_E./T)./(exp(T_E./T) - 1).^2,...
    T_1,T_2)

plot(Temp,c_v(Temp), 'k' ,'linewidth', 2)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('Temperatur / K',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel(' $c_v$ / J mol$^{-1}$ K$^{-1}$ ',...
    labelSettings(1:2:end), labelSettings(2:2:end))
saveas(gcf,'cv_curve','epsc')








