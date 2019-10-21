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

e = 1; % kubens emissivitet
A = 0.0006; % kubens area
o = 5.6703 * 10^(-8); % Stefans konstant
m = 0.00896; % kubens massa
c = 390; % specifik värmekapacitet för koppar
T0 = 273.15; % väggarnas temperatur i Kelvin
delta=1; % Stegstorlek (Eulers metod)
N=10000; % Antal steg (Eulers metod)
T(1)= 300 + 273.15; % begynnelsevillkor (kubens temperatur, i Kelvin, vid tiden 0 s)
t(1) = 0;
for n=1:(N-1)
    T(n+1)= T(n)+delta*(-1)*((T(n)^4) - (T0^4))*e*A*o/(m*c);
    t(n+1)=n*delta;
end

[T_r index] = min(abs(T-(273.15+15)));
t_15 = index/60;

plot(t/60,T-273.15, 'k')
hold on
plot([t_15 t_15],[min(T),max(T)]-273.15,'k--')

set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('Tid / min',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('Temperatur / $^{\circ}$C',labelSettings(1:2:end), labelSettings(2:2:end))
axis([0 3000/60 0 300])
yticks([0 15 50:50:300])
saveas(gcf,'cooling','epsc')





