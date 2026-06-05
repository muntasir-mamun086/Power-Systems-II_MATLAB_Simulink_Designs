clc;  
clear all;
close all;
% Reading the magnitude and phase angle 
va = input('Enter the magnitude |Va|: ');
ang_va = input('Enter the phase angle <Va: ');
vb = input('Enter the magnitude |Vb|: ');
ang_vb = input('Enter the phase angle <Vb: ');
vc = input('Enter the phase angle |Vc|: ');
ang_vc = input('Enter the phase angle <Vc: ');
a = (cos(deg2rad(120))+sin(deg2rad(120))*1i);    % Assigning reference phasor
% Converting the voltages in complex form
Va = va.*(cos(deg2rad(ang_va))+sin(deg2rad(ang_va))*1i);  
Vb = va.*(cos(deg2rad(ang_vb))+sin(deg2rad(ang_vb))*1i); 
Vc = vc.*(cos(deg2rad(ang_vc))+sin(deg2rad(ang_vc))*1i);
% Calculating the sequence voltage values
Va0 = (1/3)*(Va + Vb + Vc);
Va1 = (1/3)*(Va + a*Vb + (a^2)*Vc);
Va2 = (1/3)*(Va + a*Vc + (a^2)*Vb);
Vb0 = Va0;
Vb1 = (a^2)*Va1;
Vb2 = a*Va1;
Vc0 = Va0;
Vc1 = a*Va1;
Vc2 = (a^2)*Va2;
% Plotting the unbalanced voltage phasor
subplot(2,2,1)
compass(Va)
hold on
compass(Vb)
hold on
compass(Vc)
title('Unbalanced voltages')
% Plotting the positive sequence voltage phasor
subplot(2,2,2)
compass(Va1)
hold on
compass(Vb1)
hold on
compass(Vc1)
title('Positive sequence voltages')
% Plotting the negative sequence voltage phasor
subplot(2,2,3)
compass(Va2)
hold on
compass(Vb2)
hold on
compass(Vc2)
title('Negative sequence voltages')
% Plotting the zero sequence voltage phasor
subplot(2,2,4)
compass(Va0)
hold on
compass(Vb0)
hold on
compass(Vc0)
title('Zero sequence voltages')







