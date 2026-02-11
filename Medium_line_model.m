clc;
clear all;
close all;
%Given data
line_kV = 345;              % Line rated voltage (kV)
length_km = 130;            % Line length
R_per_km = 0.036;           % Ohm/km
L_per_km = 0.8e-3;          % H/km
C_per_km = 0.0112e-6;       % F/km
f = 50;                     % Hz (change to 60 if needed)
S_load_MVA = 270;           % Receiving end load
pf = 0.8;                   % Lagging power factor
Vr_line_kV = 325;           % Receiving end line voltage
% Derived values
w = 2*pi*f;
Z = (R_per_km + 1j*w*L_per_km) * length_km;   % Total series impedance
Y = 1j*w*C_per_km * length_km;                % Total shunt admittance
% Nominal pi model ABCD constants
A = 1 + (Y*Z)/2;
B = Z;
C = Y * (1 + (Y*Z)/4);
D = A;
% Receving end values
Vr_phase = Vr_line_kV*1e3 / sqrt(3);   % Phase voltage in volts
S_total = S_load_MVA * 1e6;            % VA
phi = acos(pf);
Ir = conj( S_total / (3*Vr_phase) ) * exp(-1j*phi);
% Calculate sending end values
Vs_phase = A*Vr_phase + B*Ir;
Is = C*Vr_phase + D*Ir;
Vs_line_kV = abs(Vs_phase)*sqrt(3)/1000;
Ss = 3 * Vs_phase * conj(Is);     % Sending end complex power
Ps_MW = real(Ss)/1e6;
Qs_MVAR = imag(Ss)/1e6;
% Calculate volatge regulation
VR_percent = (Vs_line_kV - Vr_line_kV)/Vr_line_kV * 100;
% See the results
fprintf('Sending-end line voltage = %.2f kV\n', Vs_line_kV)
fprintf('Sending-end real power    = %.2f MW\n', Ps_MW)
fprintf('Sending-end reactive power= %.2f MVAR\n', Qs_MVAR)
fprintf('Voltage regulation        = %.2f %%\n', VR_percent)
