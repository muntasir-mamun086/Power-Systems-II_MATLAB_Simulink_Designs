clc;
clear all;
close all;
% The rated values
S_rated = 150e3;      % Apparent power (VA)
V1 = 2400;            % Primary voltage (V)
V2 = 240;             % Secondary voltage (V)
pf = 0.8;             % Power factor
% Transformer turns ratio
a = V1/V2;
% Given the parameters from tarnsformer circuit figure
R1 = 0.2;     % ohm
X1 = 0.45;    % ohm
R2 = 0.002;   % ohm
X2 = 0.0045;  % ohm
% Core loss branch
Rc = 1000;    % ohm
Xm = 1500;    % ohm
% Refer secondary to primary side
R2p = a^2 * R2;
X2p = a^2 * X2;
% The total equivalent resistance and reactance
Req = R1 + R2p;
Xeq = X1 + X2p;
% Full load current (secondary)
I2_rated = S_rated / V2;
I2p = I2_rated / a;    % referred primary current
% Copper loss at full load
Pcu_fl = I2p^2 * Req;
% Core loss
Pcore = V1^2 / Rc;
% Load range (0 to 1.25 pu)
load = 0:0.05:1.25;
% Calculate the efficiency 
eta = zeros(size(load));
for k = 1:length(load)
    x = load(k);
    
    Pout = x * S_rated * pf;
    Pcu = (x^2) * Pcu_fl;
    Pin = Pout + Pcu + Pcore;
    
    eta(k) = Pout / Pin;
end
% Plot the efficiency curve of transformer
figure;
plot(load, eta*100, 'LineWidth', 2);
grid on;
xlabel('Load (per unit)');
ylabel('Efficiency (%)');
title('Transformer Efficiency Curve using trans program');
% Display the  maximum efficiency
[etamax, idx] = max(eta);
fprintf('Maximum Efficiency = %.2f %% at Load = %.2f pu\n', ...
         etamax*100, load(idx));
