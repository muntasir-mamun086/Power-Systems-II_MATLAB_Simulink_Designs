% This Y-bus Admittance Matrix calculation is performed using data from the 'y_bus_02' excel file.
clc;
clear all;
close all;
format compact;
format short;
A = xlsread('y_bus_02');
len = size(A);
for j = 1: len
Z(A(j,1),A(j,2)) = A(j,3) + A(j,4)*i;
Z(A(j,2),A(j,1)) = A(j,3) + A(j,4)*i;
end
m = length(Z);
for i=1 : m
    for j = 1:m
        if Z(i,j) == 0
            Z(i,j)= inf;
        end
    end
end
Y = 1./Z;
sum = 0;
D = zeros(m,m);
for i= 1 : m
    for j = 1:m
        sum = sum + Y(i,j);
        if i~= j
            D(i,j) = -1*Y(i,j);
        end
    end
    D(i,i) = sum;
    sum = 0;
end
fprintf('\n The Impedance Matrix :  \n');
disp(Z);
fprintf('\n The Admittance Matrix :  \n');
disp(Y);
fprintf('\n The Y_Bus Matrix :  \n');
disp(D);