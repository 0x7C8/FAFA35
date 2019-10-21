clear;clc;

% 1
lambda = 365e-9;    % m
h = 6.62607e-34; % J*s
c = 2.99792e8; % m/s
eV = 1.6022e-19; % J 

E_J = h*c/lambda
E_eV = E_J / eV


%% 2
P = 5e-3;   % W

% Pt = E_J*N
N = P/E_J  

%% 3
W = 1.5; % eV

% K = h*f - W
K = h*c/(lambda * eV) - W

% 3b
% V = K/eV

% 3c 
% more than:
lambda_2 = h*c/(W*eV)


