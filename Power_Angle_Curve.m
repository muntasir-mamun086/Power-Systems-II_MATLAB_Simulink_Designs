clc;
clear all;
close all;
% Given data
V_L = 34.64e3;     % Line-to-line voltage (V)
V = V_L/sqrt(3);   % Phase voltage (V)
Xd = 13.5;         % Direct axis reactance (ohm)
Xq = 9.333;        % Quadrature axis reactance (ohm)
E = 1.25*V;        % Excitation voltage from part (b) (approx, adjust if needed)
% Delta range (in degrees)
d = 0:0.05:180;
delta = deg2rad(d);   % Convert it into radians
% Power equation for salient pole generator
P = (3*E*V/Xd).*sin(delta) + ........ 
    (3*V^2/2).*((1/Xq)-(1/Xd)).*sin(2*delta);
% Now determine the maximum power and corresponding angle
[Pmax, k] = max(P);
dmax = d(k);
% Plot the graph
figure;
plot(d, P/1e6, 'LineWidth', 2.5);
grid on;
xlabel('\delta (degrees)');
ylabel('Power (MW)');
title('Power Angle Curve of a salient pole generator ');
% Display the results
fprintf('Maximum Power Pmax = %.2f MW\n', Pmax/1e6);
fprintf('Corresponding angle dmax = %.2f degrees\n', dmax);
