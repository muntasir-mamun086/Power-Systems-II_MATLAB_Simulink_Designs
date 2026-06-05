clc;
clear all;
close all;
format short;
P_elec = 0.8;      % Mechanical power
Q = 0.074;         % Reactive power
H = 5;             % Inertia constant (MJ/MVA)
V = 1;
P_mecha = P_elec;
S = P_elec + 1i*Q;
I = conj(S)/conj(V);
% Reactances
X1 = 0.3 + 0.2 + 0.3/2;    % Before fault
X2 = 1.8;                  % During fault
X3 = 0.8;                  % After fault
% Internal Voltage
E = V + 1i*X1*I;
% Maximum Power
P1_max = abs(E)*abs(V)/X1;
P2_max = abs(E)*abs(V)/X2;
P3_max = abs(E)*abs(V)/X3;
% Initial Rotor Angle
del_0 = asin(P_mecha/P1_max);
% Maximum Rotor Angle
del_max = pi - del_0;
% Constant
K = (pi*60)/H;
% Time Step
del_t = 0.01;
% Time Vector
t = 0:del_t:1;
len_t = length(t);
% Different Clearing Times
tcases = [0.3 0.4 0.5];
figure;
hold on;
for m = 1:length(tcases)
    tc = tcases(m);
% Initialization
    del = zeros(1,len_t);
    del_w = zeros(1,len_t);
    ddt_del = zeros(1,len_t);
    ddt_del_w = zeros(1,len_t);
    del(1) = del_0;
    del_w(1) = 0;
    ddt_del(1) = del_w(1);
    ddt_del_w(1) = K*(P_mecha - P2_max*sin(del(1)));
% Numerical Solution
    for i = 1:len_t-1
     delp = del(i) + ddt_del(i)*del_t;
     del_wp = del_w(i) + ddt_del_w(i)*del_t;
     ddt_del(i+1) = del_wp;
% During Fault
        if t(i) < tc
   ddt_del_w(i+1) = K*(P_mecha - P2_max*sin(delp));
% After Clearing
        else
 ddt_del_w(i+1) = K*(P_mecha - P3_max*sin(delp));
        end
     del(i+1) = del(i) + ((ddt_del(i+1)+ddt_del(i))/2)*del_t;
     del_w(i+1) = del_w(i) +((ddt_del_w(i+1)+ddt_del_w(i))/2)*del_t;
    end
% Convert Radian to Degree
    delta = rad2deg(del);
% Plot Curves
    if tc == 0.3
      plot(t,delta,'r','LineWidth',2);
    elseif tc == 0.4
        plot(t,delta,'g','LineWidth',2);
    elseif tc == 0.5
        plot(t,delta,'b--','LineWidth',2);
    end
end
xlabel('Time');
ylabel('Delta');
text(0.58,85,'tc = 0.3 sec','Color','r','FontSize',12);
text(0.72,115,'tc = 0.4 sec','Color','g','FontSize',12);
text(0.78,190,'tc = 0.5 sec','Color','b','FontSize',12);
grid on;
grid minor;
hold off;