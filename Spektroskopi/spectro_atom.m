clear;clc;close all

% ------ Shared graph settings -------
gcaSettings = {...
    'XGrid','on',...
    'YGrid', 'on',...
    'Fontsize', 13,...
    'linewidth', 1,...
    'FontName', 'Arial',...
    'Box', 'off'};

labelSettings = {...
    'Interpreter','latex'...
    'Fontsize', 19};
% -------------------------------------

files = {'H_410.SPE','H_430.SPE','H_480.SPE',...
    'H_655.SPE','H_1.SPE', 'H_nofilter.SPE'};

%% Search for 655 nm
figure(1)
temp = loadSPE(files{4});

% Shows peaks in plot
findpeaks(log2(temp.int), temp.wavelength,...
    'MinPeakHeight',10)

% Peak data
[pk_value, pk_loc] = findpeaks(log2(temp.int), temp.wavelength,...
    'MinPeakHeight',10);
balmer = pk_loc;
h = pk_value;
target = 655;
pm = 30;
axis([target-pm target+pm 2 16])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$\lambda$ / nm',...
    labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('Relative intensity log$_2$(I)',labelSettings(1:2:end), labelSettings(2:2:end))

text(balmer+.5,h,...
    '$\alpha$',...
    labelSettings(1:2:end), labelSettings(2:2:end))

saveas(gcf,'H_655','epsc')

%% Search for 655 nm

figure(2)
temp = loadSPE(files{5});
% indexes
A = 50;
B = 600;
C = 100;
D = 105;

% Shows peaks in plot
findpeaks(log2(temp.int(C:D)), temp.wavelength(C:D),...
    'MinPeakHeight',7)
hold on
findpeaks(log2(temp.int(A:B)), temp.wavelength(A:B),...
    'MinPeakHeight',9)

% Peak data
[pk_value, pk_loc] = findpeaks(...
    log2(temp.int(A:B)),temp.wavelength(A:B),...
    'MinPeakHeight',9);
balmer = [pk_loc' balmer];
h = [pk_value h];

[pk_value, pk_loc] = findpeaks(...
    log2(temp.int(A:D)),temp.wavelength(A:D),...
    'MinPeakHeight',7);
balmer = [pk_loc' balmer];
h = [pk_value h];

target = 450;
pm = 70;
axis([target-pm target+pm 5 16])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$\lambda$ / nm',...
    labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('Relative intensity log$_2$(I)',labelSettings(1:2:end), labelSettings(2:2:end))

text(balmer(1:4)+.5,h(1:4)+.3,...
    {'$\epsilon$', '$\delta$', '$\gamma$', '$\beta$'},...
    labelSettings(1:2:end), labelSettings(2:2:end))

saveas(gcf,'H_380-520','epsc')

%% Test all
close all
for i = 1:length(files)
    temp = loadSPE(files{i});
    
    figure(i)
    plot(temp.wavelength, log2(temp.int), 'k-')
    set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
    xlabel('$\lambda$ / nm',...
        labelSettings(1:2:end), labelSettings(2:2:end))
    ylabel('Relative intensity log$_2$(I)',labelSettings(1:2:end), labelSettings(2:2:end))
end

%%  Deviation from reference values

ref  = [397.0 410.2 434.0 486.1 656.3];

err = round(balmer, 1, 'decimals')./ref - 1







