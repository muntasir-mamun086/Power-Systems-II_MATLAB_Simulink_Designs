clc;
clear all;
close all;
% Time settings
t = 0:0.0001:0.01667;   % 0 to 16.67 ms with 0.1 ms step
% Given signals
v = 200*cos(377*t);                       % Voltage v(t)
p = 800 + 1000*cos(754*t - deg2rad(36.87)); % Power p(t)
% Instantaneous current
i = p ./ v;   % Element-by-element division
% Plot instantaneous voltage
figure;
plot(t*1000, v, 'LineWidth', 2);
grid on;
xlabel('Time (ms)');
ylabel('Voltage v(t)');
title('Instantaneous Voltage v(t)');
% Plot instantaneous power
figure;
plot(t*1000, p, 'LineWidth', 2);
grid on;
xlabel('Time (ms)');
ylabel('Power p(t)');
title('Instantaneous Power p(t)');
% Plot instantaneous current
figure;
plot(t*1000, i, 'LineWidth', 2);
grid on;
xlabel('Time (ms)');
ylabel('Current i(t)');
title('Instantaneous Current i(t)');
