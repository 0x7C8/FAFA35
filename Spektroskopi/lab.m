clear; clc;


h = 6.62607e-34; % J*s
c = 2.99792e8; % m/s
eV = 1.6022e-19; % J
hbar = h/(2*pi);


R1 = 426367;  % m-1
R2 = 426737;  % m-1
P1 = 425606;  % m-1
P2 = 425213;  % m-1



%delta_lambda = 1/abs(R1-P1);
%B = h*c/(4*delta_lambda*eV)
B = h*c*abs(R1-P1)/(4*eV)

E_P1 = h*c/(1/P1*eV)
w_0 = (E_P1+2*B)*eV/(hbar*(1+1/2))

mu = (12*16)/(12+16) * 1.6605e-27;
r = sqrt(hbar^2/(2*mu*B*eV))



