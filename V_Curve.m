clc;
clear all;
close all;
% Given data
S = 50e6;          % Rated apparent power (VA)
P = 40e6;          % Operating real power (W)
VL = 30e3;         % Line voltage (V)
Xs = 9;            % Synchronous reactance per phase (ohm)
R = 0;             % Armature resistance (negligible)
% Convert it to phase voltage
V = VL / sqrt(3);  % Phase voltage (V)
% OCC relation, E = (2000 * If) as field current = E / 2000 and the range of exciattion voltage
E = linspace(0.5*V, 2.0*V, 500);   % Internal emf range
Ia = zeros(size(E));  % Create an array of zeros to store armature current values for each E
If = E / 2000;        % Field current from OCC
% Determine the armature current
for k = 1:length(E)
    % Power equation-
    % P = (3*V*E/Xs)*sin(delta)
    sin_delta = (P*Xs) / (3*V*E(k));
    % limit sin(delta)
    if abs(sin_delta) <= 1
        delta = asin(sin_delta);
        E_phasor = E(k) * exp(1j*delta);  % The phasor form of E 
        V_phasor = V;                     % The phasor form of V
        % The current equation
        I = (E_phasor - V_phasor) / (1j*Xs);
        Ia(k) = abs(I);
        else
        Ia(k) = NaN;
    end
    
end
% Plot the V-curve
figure;
plot(If, Ia, 'k', 'LineWidth', 1.5);
grid on;
xlabel('Field Current (If) [A]');
ylabel('Armature Current (Ia) [A]');
title('V-Curve of Synchronous Generator');

