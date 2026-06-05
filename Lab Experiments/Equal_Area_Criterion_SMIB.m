clc; 
clear all; 
close all;
P_elec = 0.8;  % Electrical real power 
Q = 0.074;     % Imaginary power 
H = 5 ;        % Inertia constant ,  unit MJ/MVA 
V =1; 
P_mecha = P_elec; 
P_m = P_elec; 
S = P_elec + j*Q; 
I = conj(S)/conj(V); 
X1 = 0.3+0.2+0.3/2;    % Reactance before fault 
E = V + j*X1*I;        % Transient internal voltage 
X2 = inf;              % For first case 
X3 = X1 ;              % For first case 
P1_max = abs(E)*abs(V)/X1;   
P2_max = abs(E)*abs(V)/X2; 
P3_max = abs(E)*abs(V)/X3; 
del_0 = asin(P_mecha/P1_max);        % Initial operating angle            
del_max = pi - asin(P_mecha/P3_max); % Maximum operating angle      
del_c = acos(  (P_mecha*(del_max - del_0)  + P3_max*cos(del_max) - P2_max*cos(del_0))/ (P3_max - P2_max));  % Critical clearing angle  
t_c = sqrt( (2*H*(del_c - del_0))/ ( pi*60*P_mecha));   % Critical clearing time  
del_c = del_c*(180/pi); 
del_0 = del_0 * (180/pi); 
fprintf('Critical Clearing Angle :   %f\n', del_c); 
fprintf('Critical Clearing Time :   %f\n', t_c); 
if X2 == inf 
t_c = sqrt( (2*H*(del_c - del_0))/ ( pi*60*P_mecha));   % Critical clearing time 
fprintf('Critical Clearing Time :   %f\n', t_c); 
else 
end 
fprintf('Critical Clearing Time is determinable\n'); 
fprintf('Maximum Power Angle Swing : %f\n', rad2deg(del_max));  
% Ploting equal area criterion  
del = rad2deg([0 : 0.001 : pi]); 
P1 = P1_max * sin(deg2rad(del)); 
P2 = P2_max * sin(deg2rad(del)); 
P3 = P3_max * sin(deg2rad(del)); 
P_mecha = P_mecha + 0 * del; 
plot(del,P1, 'c--' ,  'linewidth', 2 ); 
xlabel('Power Angle (Delta) '); 
ylabel(' Electrical Power (Pe)'); 
grid on; 
grid minor; 
hold on; 
plot(del,P2, 'r' ,  'linewidth', 2); 
hold on; 
plot(del,P3, 'b' ,  'linewidth', 1); 
hold on; 
plot(del,P_mecha, 'g' ,  'linewidth', 2); 
hold on; 
legend('Pe Before Fault', 'Pe During Fault', 'Pe After Fault', 'Mechanical Power')  
hold on; 
xx= (del_0 :0.01: del_c);   
x = [del_0 xx del_c];       
y = P2_max * sin(xx*pi/180); 
y =[P_m  y P_m]; 
fill(x,y,'y'); 
del_mx = rad2deg(del_max); 
pp = del_c :0.01 : del_mx;   
p = [ del_c pp del_mx]; 
q = P3_max * sin(pp*pi/180); 
q =[P_m q P_m]; 
fill(p,q,'g'); 