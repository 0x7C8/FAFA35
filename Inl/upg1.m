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

%% 1a

m = 2.016 * 1.661e-27; % kg
T = [0 200 500] + 273.15; % K
k = 1.3806e-23;  % J/K
v_x = -5e3:5:5e3; % m/s

% Maxwells fordelningen
f_x = @(v, T) sqrt(m/(2*pi*k*T)) * exp(-m.*v.^2/(2*k*T));

figure(1)
plot(v_x/1e3, f_x(v_x,T(1))*1e3, 'k-')
hold on
plot(v_x/1e3, f_x(v_x,T(2))*1e3, 'k--')
plot(v_x/1e3, f_x(v_x,T(3))*1e3, 'k-', 'LineWidth', 2)

leg = legend('0$^{\circ}$C', '200$^{\circ}$C',...
    '500$^{\circ}$C');
set(leg,'Interpreter','latex');
set(leg,'FontSize',15);
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('Hastighet i x-led / $km \cdot s^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('T\"athetsfunktion $f(v_x) \cdot 10^3$',...
    labelSettings(1:2:end), labelSettings(2:2:end))
saveas(gcf,'H2','epsc')

%% 1c

m = 32 * 1.661e-27; % kg
v = 0:1:5e3;   % m/s
T = [0 500 1000] + 273.15; % K

f = @(v, T) 4*pi * (m/(2*pi*k*T))^(3/2) * v.^2 .* exp(-m.*v.^2/(2*k*T));

figure(2)
plot(v, f(v,T(1))*1e3, 'k-')
hold on
plot(v, f(v,T(2))*1e3, 'k--')
plot(v, f(v,T(3))*1e3, 'k-', 'LineWidth', 2)

leg = legend('0$^{\circ}$C', '200$^{\circ}$C',...
    '500$^{\circ}$C');
set(leg,'Interpreter','latex');
set(leg,'FontSize',15);
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('Hastighet / $m \cdot s^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('T\"athetsfunktion $f(v) \cdot 10^3$',...
    labelSettings(1:2:end), labelSettings(2:2:end))
axis([0 2000 0 2.5])
saveas(gcf,'O2','epsc')

%% 1d

figure(3)
plot(v, f(v,T(1))*1e3, 'k-')
hold on
v_avg = integral(@(x) f(x,T(1)).*x, min(v), max(v))
plot([v_avg v_avg],[0 f(v_avg,T(1))*1e3],'k--')

v_rms = sqrt(integral(@(x) f(x,T(1)).*x.^2, min(v), max(v)))
plot([v_rms v_rms],[0 f(v_rms,T(1))*1e3],'k--')

v_rmc = (integral(@(x) f(x,T(1)).*x.^3, min(v), max(v)))^(1/3)
plot([v_rmc v_rmc],[0 f(v_rmc,T(1))*1e3],'k--')

%v_max = sqrt((2*k*T(1))/m);
%plot([v_max v_max],[0 f(v_max, T(1))*1e3],'k--')
[fmax i_max] = max(f(v,T(1))*1e3);
plot([v(i_max) v(i_max)],[0 fmax],'k--')

set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('Hastighet / $m \cdot s^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('T\"athetsfunktion $f(v) \cdot 10^3$',...
    labelSettings(1:2:end), labelSettings(2:2:end))
axis([0 1000 0 2.5])
tx(1) = text(v_avg, 1.03*(f(v_avg,T(1))*1e3), '$<v>$');
tx(2) = text(v_rms, 1.03*(f(v_rms,T(1))*1e3), '$v_{rms}$');
tx(3) = text(v_rmc, 1.03*(f(v_rmc,T(1))*1e3), '$v_{rmc}$');
tx(4) = text(v(i_max), 1.05*(f(v(i_max),T(1))*1e3), '$v(max)$');
set(tx,...
    'Interpreter','latex',...
    'Fontsize', 15);
saveas(gcf,'O2_2','epsc')


