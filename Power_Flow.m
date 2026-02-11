clc;
clear all;
close all;
% Given system parameters (edit if needed)
V1_mag = 1.0;        % Magnitude of source 1 voltage (p.u. or V)
V2_mag = 1.0;        % Magnitude of source 2 voltage (p.u. or V)
delta2 = 0;          % Phase angle of source 2 (degrees)
R = 0.02;            % Line resistance
X = 0.04;            % Line reactance
Z = R + 1j*X;        % Line impedance
%Phase angle variation of source 1
delta1 = 0:5:30;     % degrees
delta1_rad = deg2rad(delta1);
% Preallocation
P1 = zeros(size(delta1));
P2 = zeros(size(delta1));
PL = zeros(size(delta1));
% Power calculations
for k = 1:length(delta1)
    
    % Source voltages
    V1 = V1_mag * exp(1j * delta1_rad(k));
    V2 = V2_mag * exp(1j * deg2rad(delta2));
    
    % Line current
    I = (V1 - V2) / Z;
    
    % Complex power at each source
    S1 = V1 * conj(I);
    S2 = V2 * conj(-I);
    
    % Real powers
    P1(k) = real(S1);
    P2(k) = real(S2);
    
    % Line loss
    PL(k) = P1(k) + P2(k);
end
% Display results in table
Results = table(delta1.', P1.', P2.', PL.', ...
    'VariableNames', {'Delta_deg', 'P1', 'P2', 'PL'});

disp(Results);
% Plot results
figure;
plot(delta1, P1, 'o-', 'LineWidth', 2);
hold on;
plot(delta1, P2, 'g-', 'LineWidth', 2);
plot(delta1, PL, 'd-', 'LineWidth', 2);
grid on;
xlabel('Voltage Phase Angle \delta (degrees)');
ylabel('Real Power');
legend('P_1', 'P_2', 'P_L', 'Location', 'best');
title('Power vs Voltage Phase Angle Graph');
