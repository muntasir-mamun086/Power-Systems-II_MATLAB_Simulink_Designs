% This Y-bus Matrix calculation is performed using data from the 'y_bus_data' excel file.
clc;
clear all;
close all;
format compact;
format short;
% Read Excel file
A = xlsread('y_bus_data');
len = size(A,1);   % Number of rows
% Determine Matrix Size
n = max(max(A(:,1:2)));
% Initialize Z-Matrix
Z = zeros(n,n);
% Build Z-Matrix
for k = 1:len
    i = A(k,1);
    j = A(k,2);
    Z(i,j) = A(k,3) + 1i*A(k,4);
    Z(j,i) = Z(i,j);   
end
% Replace zero with infinity
for i = 1:n
    for j = 1:n
        if Z(i,j) == 0
            Z(i,j) = inf;
        end
    end
end
% Element-wise inverse → Y matrix
Y = 1 ./ Z;
% Build Y-Bus Matrix
D = zeros(n,n);
for i = 1:n
    sum_val = 0;
    for j = 1:n
        sum_val = sum_val + Y(i,j);
        if i ~= j
            D(i,j) = -Y(i,j);
        end
    end
    D(i,i) = sum_val;
end
% Display the results
fprintf('\n z Matrix: \n');
disp(Z);
fprintf('\n y Matrix (Elementwise Inverse of z Matrix):  \n');
disp(Y);
fprintf('\n Y Bus Matrix: \n');
disp(D);







