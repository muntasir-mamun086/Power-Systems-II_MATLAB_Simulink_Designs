clc;
clear all;
close all;
% Given data 
z = 0.036 + 1j*0.3;          % Series impedance in ohm/km
y = 1j*4.22e-6;              % Shunt admittance in S/km
Length = 130;                % Transmission line length in km
Vs3ph = 345;                 % Line to line voltage in kV (L-L)
Ism = 0.4;                   % kA
pf_s = 0.95;                 % lagging power factor
% Calculate sending-end phase voltage (kV)
Vs = Vs3ph/sqrt(3);
% Calculate sending-end current (kA)
As = -acos(pf_s);
Is = Ism*(cos(As) + 1j*sin(As));
% Long line model 
gamma = sqrt(z*y);           % propagation constant per km
Zc = sqrt(z/y);              % characteristic impedance
%define ABCD parameters
A = cosh(gamma*Length);
B = Zc*sinh(gamma*Length);
C = (1/Zc)*sinh(gamma*Length);
D = A;
ABCD = [A B; C D];
% Now calculate [Vr; Ir]
VrIr = inv(ABCD)*[Vs; Is];
Vr = VrIr(1);               % kV phase voltage
Ir = VrIr(2);               % kA
% Calculate the results
Vr3ph = sqrt(3)*abs(Vr);    % kV line to line volatge
Irm = 1000*abs(Ir);         % A
pfr = cos(angle(Vr) - angle(Ir));
Sr = 3*Vr*conj(Ir);         % MVA for apparent power
Pr = real(Sr);              % MW  for real power
Qr = imag(Sr);              % Mvar for reactive power
% Calculate voltage regulation
Vr_no_load = Vs/A;
VR = (abs(Vr_no_load)-abs(Vr))/abs(Vr)*100;
% Display the results
fprintf('Ir = %.3f A\n', Irm);
fprintf('pf = %.5f\n', pfr);
fprintf('Vr = %.2f L-L kV\n', Vr3ph);
fprintf('Pr = %.3f MW\n', Pr);
fprintf('Qr = %.3f Mvar\n', Qr);
fprintf('Percent voltage Reg. = %.5f %%\n', VR);
