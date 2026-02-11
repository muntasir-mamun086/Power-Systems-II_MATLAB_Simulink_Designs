clc;
clear all;
close all;
% Given values
Vm = 2500;                 % Peak phase voltage
Zmag = 250;                % Magnitude of impedance
theta = deg2rad(36.87);    % Impedance angle in radians
Im = Vm / Zmag;            % Peak phase current
% Time axis (in terms of wt)
wt = linspace(0, 2*pi, 1000);
% Phase instantaneous voltages
van = Vm * cos(wt);
vbn = Vm * cos(wt - 2*pi/3);
vcn = Vm * cos(wt - 4*pi/3);
% Phase instantaneous currents which are lagging by impedance angle
ian = Im * cos(wt - theta);
ibn = Im * cos(wt - 2*pi/3 - theta);
icn = Im * cos(wt - 4*pi/3 - theta);
% Instantaneous instantaneous powers
pa = van .* ian;
pb = vbn .* ibn;
pc = vcn .* icn;
ptotal = pa + pb + pc;
% Plot the instantaneous powers
figure;
plot(wt, pa, 'r', 'LineWidth', 2); 
hold on;
plot(wt, pb, 'g', 'LineWidth', 2);
plot(wt, pc, 'b', 'LineWidth', 2);
plot(wt, ptotal, 'o', 'LineWidth', 2.5);
grid on;
xlabel('\omega t');
ylabel('Instantaneous Power (W)');
title('Instantaneous Phase Powers and Total Three-Phase Power');
legend('p_a', 'p_b', 'p_c', 'Total Power');
%Display the average total power
P_avg = mean(ptotal);
disp(['Total three-phase average power = ', num2str(P_avg), ' k']);
