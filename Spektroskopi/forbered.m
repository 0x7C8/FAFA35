clear;clc

% 1

lambda = 500e-9;
d = 1/300e3;
ang_i = 15; % deg
m = [-2 -1 1 2];

ang_m = asind(m*lambda/d - sind(ang_i))


%% 2

T = 37 + 273.15;
b = 2.898e-3;
lambda_max = b/T

%% 3

h = 6.626e-34;   % J*s
c = 2.9979e8;    % m * s^-1
R_inf = 10973731.568; % m^-1
m = 9.10938e-31;   % kg
M = 1.672623e-27;   % kg
R_H = R_inf * (M/(M + m));
eV = 1.602e-19; % J

lambda_3 = @(Z, n1, n2) ( R_H * Z^2 * (1./n1.^2 - 1./n2.^2)).^(-1);  


n_1 = 2; % Balmer series
n_2 = [1 2] + n_1 ;
Z = [1 3]; % H, Li

H = [lambda_3(Z(1), n_1, n_2) * 1e9 ;... % nm
    (h*c)./lambda_3(Z(1), n_1, n_2) ./ eV]    % eV 
Li = [lambda_3(Z(2), n_1, n_2) * 1e9  ;... % nm
    (h*c)./lambda_3(Z(2), n_1, n_2) ./ eV]    % eV 

%% 4

mp = 1.672623e-27;   % kg (proton)
r = 0.0741e-9;  % m
l = [0 1 2];
hbar = h/(2*pi);

mu = mp * mp / (mp + mp);
I = mu * r^2;
B = (hbar)^2/(2*I);

E_rot = l.*(l+1)*B/eV   % eV

w = hbar* sqrt(l.*(l+1))/(2*pi*I)   % period

lambda_4 = (h*c)./([E_rot(2) E_rot(3) - E_rot(2)] .* 1.6e-19)   % m












