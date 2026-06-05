clc; 
clear all;
close all;
Vm = 100;         
f = 1;            
phi = 60;         
R = 50;           
L = 300;          
i0 = 0;           
T = linspace(0, 0.5, 1000);   
% Symbolic variable & voltage function 
syms i(t) 
V = Vm * sin(2*pi*f*t + deg2rad(phi)); 
% ODE and initial condition 
ok = L*diff(i,t) + R*i == V; 
condition = i(0) == i0; 
% Solve the differential equation 
a = dsolve(ok, condition); 
figure; 
h = ezplot(a); 
xlabel('Time (s)'); 
ylabel('Current i(t) (A)'); 
title('Current Response of RL Circuit'); 
grid on; 
legend(h, 'i(t)');