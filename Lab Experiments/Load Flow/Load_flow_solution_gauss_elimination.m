clc; 
clear all; 
close all;
% Input parameters
V1 = 1.0 + 0j;             % Slack Bus Voltage
P2_load = 0.3;             % Real power load
Q2_load = 0.2;             % Reactive power load
% Injective Power(Negative) for laod bus 2
P2 = -P2_load; 
Q2 = -Q2_load;
S2_conj = P2 - 1j*Q2; 
Z12 = 0.1 + 0.5j;          % Line impedance
Y12 = 1 / Z12;             % Line admittance
V2 = 1.0 + 0j;             % Initial Guess
tolerance = 0.0001;       
diff = 1;
iter = 0;
% Show the table header
fprintf('%-14s %-15s %-12s %-10s\n', 'Iter', 'V2', 'Mag', 'Ang');

while diff > tolerance && iter < 10 
    iter = iter + 1;
    V2_old = V2;
% Gauss-Seidel Formula
    V2 = (1/Y12) * (S2_conj/conj(V2_old) + Y12*V1);
    v_real = real(V2);
    v_imag = imag(V2);
    v_mag = abs(V2);
    v_ang = angle(V2) * (180/pi); 
    if v_imag >= 0
        fprintf('%-8d %.4f + %.4fi    %-12.4f %-10.4f\n', iter, v_real, v_imag, v_mag, v_ang);
    else
        fprintf('%-8d %.4f - %.4fi    %-12.4f %-10.4f\n', iter, v_real, abs(v_imag), v_mag, v_ang);
    end
    
    diff = abs(V2 - V2_old);
end
fprintf('\nFinal Voltage at busbar 2 is: %.4f ∠ %.4f° pu\n', abs(V2), angle(V2)*(180/pi));