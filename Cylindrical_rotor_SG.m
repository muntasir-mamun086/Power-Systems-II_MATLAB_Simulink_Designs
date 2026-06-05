clc;
clear all;
close all;
% Reference phasor (Terminal voltage E)
E = 1 * exp(1j*0);      % Reference at 0 degrees
% Machine parameters (example values)
Ia_mag = 0.8;           % Armature current magnitude
theta = -30;            % Power factor angle (lagging, degrees)
Ra = 0.05;              % Armature resistance
Xs = 0.8;               % Synchronous reactance
% Current phasor
Ia = Ia_mag * exp(1j*deg2rad(theta));
% Voltage drops
RaIa = Ra * Ia;
jXsIa = 1j * Xs * Ia;
% Internal generated emf
Ea = E + RaIa + jXsIa;
%Plot phasors
figure;
hold on;
grid on;
axis equal;
% Plot vectors using quiver
quiver(0,0, real(E), imag(E), 0, 'LineWidth',2);
quiver(0,0, real(Ia), imag(Ia), 0, 'LineWidth',2);
quiver(real(E), imag(E), real(RaIa), imag(RaIa), 0, 'LineWidth',2);
quiver(real(E+RaIa), imag(E+RaIa), real(jXsIa), imag(jXsIa), 0, 'LineWidth',2);
quiver(0,0, real(Ea), imag(Ea), 0, 'LineWidth',2);
% Labels
text(real(E)*1.05, imag(E)*1.05, 'E');
text(real(Ia)*1.05, imag(Ia)*1.05, 'I_a');
text(real(Ea)*1.05, imag(Ea)*1.05, 'E_a');
text(real(E+RaIa)*1.05, imag(E+RaIa)*1.05, 'R_a I_a');
text(real(E+RaIa+jXsIa)*1.05, imag(E+RaIa+jXsIa)*1.05, 'jX_s I_a');
xlabel('Real Axis');
ylabel('Imaginary Axis');
title('Phasor Diagram of Single Phase of Cylindrical Rotor in Synchronous Generator');
legend('E','I_a','R_a I_a','jX_s I_a','E_a','Location','best');
