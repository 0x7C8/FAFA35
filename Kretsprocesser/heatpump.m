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
    'Fontsize', 20};
% -------------------------------------

[t W T_H T_C]=read_vpdata('krets_data.txt');
kelvin = 273.15;
TH = T_H + kelvin;     % T_H i grader Celsius
TC = T_C + kelvin;     % T_C i grader Celsius

% TH plot
figure(1)
pl(3) = plot(t,TH,'ko','MarkerSize', 5);
hold on

THpol = polyfit(t,TH,4);
pl(1) = plot(t,polyval(THpol,t),'r-','LineWidth', 2);

% TC plot
plot(t,TC,'ko','MarkerSize', 5)

TCpol = polyfit(t,TC,4);
pl(2) = plot(t,polyval(TCpol,t),'b-','LineWidth', 2);

legend([pl(1) pl(2) pl(3)], 'T_H', 'T_C', 'Data',...
    'Location', 'NorthWest');
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$ / s',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$T$ / K',labelSettings(1:2:end), labelSettings(2:2:end))
saveas(gcf,'th_tc','epsc')

% Energy plots
THderiv = polyder(THpol);
PHpol = 10*4190*THderiv;
% P = dQ/dt = m*c*dT/dt, 10 l vatten => m= 10 kg
PH = polyval(PHpol,t);

Wpol = polyfit(t, W, 1);
Pin_deriv = polyder(Wpol);
Pin = polyval(Pin_deriv,t);

Vf_real = PH./Pin;
Vf_theory = 1./(1-TC./TH);
q = Vf_real ./ Vf_theory;


%% W_in
figure(21)
plot(t,W/1000,'b*', 'MarkerSize', 3)
hold on
plot(t, t.*Pin./1000 + Wpol(2)/1000, 'r-','LineWidth', 2)
axis([0 max(t) 0 500])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$ / s',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$W(t)$ / kJ',labelSettings(1:2:end), labelSettings(2:2:end))
yticks(0:100:500)
saveas(gcf,'Wt','epsc')


%% P_in
figure(2)
plot(t,Pin,'-', 'LineWidth', 2)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$ / s',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$P_{in}$',labelSettings(1:2:end), labelSettings(2:2:end))
%yticks(200:50:500)
saveas(gcf,'p_in','epsc')

%% P_out
figure(3)
plot(t,PH,'-', 'LineWidth', 2)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$ / s',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('Avgiven effekt / W',labelSettings(1:2:end), labelSettings(2:2:end))
yticks(500:100:1200)
saveas(gcf,'p_out','epsc')


%% Real Vf plot
figure(4)
plot(t,Vf_real,'b-', 'LineWidth', 2)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$ / s',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$V_{f}$',labelSettings(1:2:end), labelSettings(2:2:end))
yticks(1:.5:4)
saveas(gcf,'vf_real','epsc')

%% Theoretical Vf plot
figure(5)
plot(t,Vf_theory,'b-', 'LineWidth', 2)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$ / s',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$V_{f}$',labelSettings(1:2:end), labelSettings(2:2:end))
yticks([0 5 10 20:20:100])
saveas(gcf,'vf_ideal','epsc')

%% Real vs unreal
figure(6)
plot(t,q,'b-', 'LineWidth', 2)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$ / s',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$V_{f,verklig} \div V_{f,ideal}$',labelSettings(1:2:end), labelSettings(2:2:end))
ytickformat('%.2f')
saveas(gcf,'vf_kvot','epsc')






