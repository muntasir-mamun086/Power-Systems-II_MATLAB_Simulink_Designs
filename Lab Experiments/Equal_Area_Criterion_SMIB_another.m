clc;
clear all;
close all;
P_elec = 0.8;    % Electrical real power 
Q      = 0.074;  % Imaginary power 
H      = 5;      % Inertia constant ,  unit MJ/MVA 
V      = 1;      
P_m    = P_elec; 
% Internal Voltage Calculation
S = P_elec + 1j*Q;
I = conj(S) / conj(V);
X1 = 0.3 + 0.2 + 0.3/2;   % Transfer reactance BEFORE fault = 0.65
E  = V + 1j*X1*I;         % Transient internal voltage
% Transfer Reactances
X2 = 1.8;   % Transfer reactance DURING fault  
X3 = 0.8;   % Transfer reactance AFTER fault   
% Maximum Power for each condition
P1_max = abs(E)*abs(V) / X1;   % Before fault  ≈ 1.80
P2_max = abs(E)*abs(V) / X2;   % During fault  ≈ 0.65
P3_max = abs(E)*abs(V) / X3;   % After fault   ≈ 1.46
% Key Angles 
del_0   = asin(P_m / P1_max);           % Initial operating angle
del_max = pi - asin(P_m / P3_max);      % Maximum swing angle
% Critical Clearing Angle 
num   = P_m*(del_max - del_0) + P3_max*cos(del_max) - P2_max*cos(del_0);
denom = P3_max - P2_max;
del_c = acos(num / denom);
% Critical Clearing Time
t_c = sqrt((2*H*(del_c - del_0)) / (pi*60*P_m));
% Display the results
fprintf('Critical Clearing Angle :    %f\n', rad2deg(del_c));
fprintf('Maximum Power Angle Swing : %f\n',  rad2deg(del_max));
fprintf('Critical Clearing Time :    %f\n',  t_c);
fprintf('Critical Clearing Time is determinable\n');
% Degree values for plotting only
del_0_d   = rad2deg(del_0);
del_c_d   = rad2deg(del_c);
del_max_d = rad2deg(del_max);
% Power curves (in degrees for x-axis)
del_d  = 0 : 0.1 : 180;
P1     = P1_max * sind(del_d);
P2     = P2_max * sind(del_d);
P3     = P3_max * sind(del_d);
Pm_vec = P_m    * ones(size(del_d));
% Plot curves
figure;
plot(del_d, P1, 'c--', 'LineWidth', 2); 
hold on;
plot(del_d, P2, 'r',     'LineWidth', 2);
plot(del_d, P3, 'b',     'LineWidth', 1);
plot(del_d, Pm_vec, 'g', 'LineWidth', 2);
xx     = del_0_d : 0.01 : del_c_d;
x_fill = [del_0_d,  xx,                        del_c_d ];
y_fill = [P_m,      P2_max * sind(xx),          P_m    ];
fill(x_fill, y_fill, 'y', 'EdgeColor', 'none');
pp     = del_c_d : 0.01 : del_max_d;
p_fill = [del_c_d,  pp,                        del_max_d];
q_fill = [P_m,      P3_max * sind(pp),          P_m     ];
fill(p_fill, q_fill, 'g', 'EdgeColor', 'none');
xlabel('Power Angle (Delta)');
ylabel('Electrical Power (Pe)');
legend('Pe Before Fault','Pe During Fault','Pe After Fault','Mechanical Power','data1','data2','Location','northeast');
grid on; 
grid minor;
xlim([0 180]); 
ylim([0 2]);
title(sprintf('Equal Area Criterion (X3=%.1f & X2=%.1f)', X2, X3));