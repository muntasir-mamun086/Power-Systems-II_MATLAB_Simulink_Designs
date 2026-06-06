clc;
clear all;
close all;
% Simulation parameters
H = 3.5;                   
% Inertia constant (MJ/MVA)
f = 50;                    
ws = 2*pi*f;               
Pm = 0.8;                  
E = 1.1; V = 1.0;          
% Reactances (pu)
X_prefault = 0.5;
X_fault = 5.0;             
X_postfault = 0.6;
% Time settings
t_end = 3;                 
dt = 0.001;                
t = 0:dt:t_end;
n = length(t);
% Fault clearing time
t_clear = 0.25;            
% Initial conditions
delta = zeros(1, n);       
omega = zeros(1, n);       
delta(1) = deg2rad(30);    
% System frequency (Hz)
% Synchronous speed (rad/s)
% Mechanical power input (pu)
% Generator & infinite bus voltages
% During fault, high reactance (low Pe)
% Total simulation time (s)
% Time step
% Try changing this value
% Rotor angle (rad)
% Rotor speed deviation
% Initial rotor angle
% Simulation loop (Euler method)
for i = 1:n-1
if t(i) < t_clear
        X = X_fault;       
% During fault
elseif t(i) >= t_clear
        X = X_postfault;   
end
% After fault is cleared
    Pe = (E*V/X) * sin(delta(i));                      
    accel = (Pm - Pe) * ws / (2*H);                     
    omega(i+1) = omega(i) + accel * dt;                
    delta(i+1) = delta(i) + omega(i+1) * dt;           
end
% Plotting
figure;
% Electrical power
% Swing equation
% Integrate speed
% Integrate angle
plot(t, rad2deg(delta), 'b', 'LineWidth', 2); hold on;
xline(t_clear, 'r--', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Rotor Angle \delta (degrees)');
title('Swing Curve with Fault Clearing');
legend('Rotor Angle', 'Fault Cleared');
grid on;
figure;
plot(t, omega, 'm', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Rotor Speed Deviation \omega (rad/s)');
title('Rotor Speed Deviation Over Time');
grid on;
% Parameters
H = 3.5; f = 50; ws = 2*pi*f;
Pm = 0.8; E = 1.1; V = 1.0;
X_fault = 5.0; X_postfault = 0.6;
delta0 = deg2rad(30);  % Initial angle
% Time settings
t_end = 3; dt = 0.001; t = 0:dt:t_end; n = length(t);
% Fault clearing times to test
clearing_times = [0.15, 0.25, 0.35, 0.45, 0.55];
% Set up figure
figure; hold on;
for tc = clearing_times
    delta = zeros(1, n); omega = zeros(1, n);
    delta(1) = delta0;
    for i = 1:n-1
        if t(i) < tc
            X = X_fault;
        else
            X = X_postfault;
            end
        Pe = (E*V/X) * sin(delta(i));
        accel = (Pm - Pe) * ws / (2*H);
        omega(i+1) = omega(i) + accel * dt;
        delta(i+1) = delta(i) + omega(i+1) * dt;
    end
    % Plot angle (in degrees)
    plot(t, rad2deg(delta), 'LineWidth', 2, 'DisplayName', sprintf('t_{clear} = %.2f s', tc));
end
xlabel('Time (s)');
ylabel('Rotor Angle \delta (degrees)');
title('Swing Curves for Different Fault Clearing Times');
legend('Location', 'northwest');
grid on;