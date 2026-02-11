clc;
clear all;
close all;
% Input data
% Phase distances (ft → m)
D12 = 44.5 * 0.3048;
D23 = 44.5 * 0.3048;
D13 = 89   * 0.3048;
% Conductor data (cm → m)
diameter = 2.959 / 100;       % m
r_physical = diameter / 2;    % physical radius
GMR_single = 1.173 / 100;     % m
% Bundle data
n = 4;              % number of sub-conductors
s = 46 / 100;       % bundle spacing in meters
% Calculations
% GMD of 3-phase transposed line
GMD = (D12 * D23 * D13)^(1/3);
% Bundle GMR for inductance
GMR_bundle = (GMR_single * s^3)^(1/4);
% Bundle equivalent radius for capacitance
r_bundle = (r_physical * s^3)^(1/4);
% Inductance
mu0 = 4*pi*1e-7;
L_per_m = (mu0/(2*pi)) * log(GMD / GMR_bundle);
L_mH_per_km = L_per_m * 1000 * 1000;   % convert H/m → mH/km
% Capacitance
eps0 = 8.854e-12;
C_per_m = (2*pi*eps0) / log(GMD / r_bundle);
C_uF_per_km = C_per_m * 1000 * 1e6;    % convert F/m → µF/km
%See the results
fprintf('Inductance per phase = %.3f mH/km\n', L_mH_per_km)
fprintf('Capacitance per phase = %.4f µF/km\n', C_uF_per_km)
