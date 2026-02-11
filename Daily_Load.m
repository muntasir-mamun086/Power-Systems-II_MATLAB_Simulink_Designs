clc;
clear;
close all;
% Time intervals in hours (start of each interval)
time = [0 2 6 9 12 14 16 18 20 22 23 24];
% Corresponding load values in MW
load = [6 5 10 15 12 14 16 18 16 12 6 6];
% Plot daily load curve
stairs(time, load, 'LineWidth', 2);
grid on;
xlabel('Time (hours)');
ylabel('Load (MW)');
title('Daily System Load Curve');
xlim([0 24]);
ylim([0 20]);
xticks(0:2:24);
