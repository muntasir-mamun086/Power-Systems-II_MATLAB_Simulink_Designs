clc;
clear all;
close all;
% Given the values
Vm = 100;              % Peak voltage
thetav = 0;            % Voltage phase angle (degree)
Z = 1.25;              % Impedance magnitude
gama = 60;             % Impedance angle (degree)
% Current phase angle
thetai = thetav - gama;
% Power angle in radian
theta = (thetav - thetai) * pi/180;
% Peak current
Im = Vm / Z;
% Time axis (radian)
wt = 0:0.05:2*pi;
% Instantaneous voltage and current
v = Vm * cos(wt);
i = Im * cos(wt + thetai*pi/180);
% Instantaneous power
p = v .* i;
% RMS values
V = Vm / sqrt(2);
I = Im / sqrt(2);
% Real, Reactive and Complex Power
P = V * I * cos(theta);
Q = V * I * sin(theta);
S = P + 1j*Q;
% Power components
pr = P * (1 + cos(2*(wt + thetav*pi/180)));
px = Q * sin(2*(wt + thetav*pi/180));
% Reference lines
PP = P * ones(1, length(wt));
xline = zeros(1, length(wt));
% Convert radian to degree
wt_deg = wt * 180/pi;
% Plotting the graphs
figure;
subplot(2,2,1)
plot(wt_deg, v, wt_deg, i, wt_deg, xline)
grid on
title(['v(t)=Vm cos(wt), i(t)=Im cos(wt + ', num2str(thetai), '°)'])
xlabel('wt (degree)')
ylabel('Amplitude')
subplot(2,2,2)
plot(wt_deg, p, wt_deg, xline)
grid on
title('Instantaneous Power p(t) = v(t)i(t)')
xlabel('wt (degree)')
ylabel('Power')
subplot(2,2,3)
plot(wt_deg, pr, wt_deg, PP, wt_deg, xline)
grid on
title('Real-Power flow in the circuit p_r(t)')
xlabel('wt (degree)')
ylabel('Power')
subplot(2,2,4)
plot(wt_deg, px, wt_deg, xline)
grid on
title('Reactive-Power in the circuit p_x(t)')
xlabel('wt (degree)')
ylabel('Power')