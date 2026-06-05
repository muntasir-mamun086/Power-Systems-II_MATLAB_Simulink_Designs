clc;
clear all;
close all;
open('Transmission_Lines_Fault_Detection.slx');
sim('Transmission_Lines_Fault_Detection.slx');
currentA = ans.current1.signals.values;
currentB = ans.current2.signals.values;
currentC = ans.current3.signals.values;
timeA = ans.current1.time;

[cA, lA] = wavedec(currentA, 1, 'db4');
[cB, lB] = wavedec(currentB, 1, 'db4');
[cC, lC] = wavedec(currentC, 1, 'db4');

coefA = detcoef(cA, lA, 1);
coefB = detcoef(cB, lB, 1);
coefC = detcoef(cC, lC, 1);
sum = 0;
for i = 1:length(coefA)
    sum = sum + coefA(i) + coefB(i) + coefC(i);
end

sum_of_all_coefs = int8(abs(sum));
disp("Sum of all Coefs : " + sum_of_all_coefs)

if sum_of_all_coefs
    disp("Fault Detected")
else
    disp("No Fault Detected")
end