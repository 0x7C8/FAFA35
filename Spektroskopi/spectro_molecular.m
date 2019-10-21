clear;clc

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

filename = 'CO.TBL';

opts = delimitedTextImportOptions(...
    'VariableNames', { 'wave_number', 'intensity' },...
    'VariableTypes', { 'double', 'double' },...
    'Delimiter', ' ');
tbl = readtable(filename, opts);

plot(tbl.wave_number, tbl.intensity, 'k-')

axis([4140 4350 0.075 0.16])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$\lambda ^{-1}$ / cm$^{-1}$',...
    labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('Relative intensity',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(4000:50:5000)
yticks(0:0.02:0.2)
saveas(gcf,'CO_plot','epsc')

%%
% Zoomed in plot with peaks
figure(2)
% Shows peaks in plot
findpeaks(tbl.intensity, tbl.wave_number,...
    'MinPeakDistance', 3,...
    'MinPeakHeight',0.1)

% Peak data
[pk_value, pk_loc] = findpeaks(tbl.intensity, tbl.wave_number,...
    'MinPeakDistance', 3,...
    'MinPeakHeight',0.1);

hold on
% Peak IDs
text(pk_loc(15:17)-.5,pk_value(15:17)+5e-3,...
    {'$P_3$', '$P_2$', '$P_1$'},...
    labelSettings(1:2:end), labelSettings(2:2:end))
text(pk_loc(18:20)-.5,pk_value(18:20)+5e-3,...
    {'$R_1$', '$R_2$', '$R_3$'},...
    labelSettings(1:2:end), labelSettings(2:2:end))

axis([4230 4290 0.075 0.16])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$\lambda ^{-1}$ / cm$^{-1}$',...
    labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('Relative intensity',labelSettings(1:2:end), labelSettings(2:2:end))
yticks(0:0.02:0.2)
saveas(gcf,'CO_peaks','epsc')




















