clc;
clear all;
close all;
% Given data
S_rated = 240e3;      % Rated apparent power (VA)
pf = 0.8;             % Power factor
P_core = 1440;        % Core loss (W)
P_cu_full = 2625;     % Full load copper loss (W)
% Output power range (kW)
P_out_kW = linspace(40,240,200);   % Output power in kW
P_out = P_out_kW * 1000;           % Convert to W
% Load fraction
x = P_out ./ (S_rated * pf);
% Calculate the copper loss at each load
P_cu = (x.^2) * P_cu_full;
% Calculate the efficiency 
eta = P_out ./ (P_out + P_core + P_cu);
eta_percent = eta * 100;
% Plot the efficiency of transformer
figure;
plot(P_out_kW, eta_percent,'LineWidth',2);
grid on;
xlabel('Output Power (kW)');
ylabel('Percent');
title('Transformer Efficiency, pf = 0.8');
xlim([40 240]);  %Sets the X-axis range from 40 kW to 240 kW to get the required output power range

