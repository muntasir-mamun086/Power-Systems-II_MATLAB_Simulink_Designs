clc;
clear all;
close all;
% Read data from the Excel file 'data.xlsx'
A = xlsread('y_bus_01');
[row, col] = size(A);
% Initialize Z matrix
n_bus = max(max(A(:,1:2)));
z = inf(n_bus);
% Fill Z-Matrix with impedance values
for i = 1:row
    from = A(i,1);
    to   = A(i,2);
    z(from, to) = A(i,3) + 1i * A(i,4);
    z(to, from) = z(from, to);          % Make symmetric
end
% Convert 0 values to infinity
q = length(z);
for i = 1:q
    for j = 1:q
        if z(i, j) == 0
            z(i, j) = inf;
        end
    end
end
% Calculate Y-Matrix (inverse of Z)
y = 1 ./ z;
% Diagonal summation
s = sum(y);
% Modify Y-Matrix (diagonal and off-diagonal)
v = length(z);
for i = 1:v
    for j = 1:v
        if i == j
            y(i, j) = s(i);
        else
            y(i, j) = -y(i, j);
        end
    end
end
% Display Y-bus Matrix
disp('Y-Bus Matrix:');
disp(y);
% Ask user for reduction
f = input('How many times do you want to reduce? ');
reduction_buses = input('Enter the list of buses to reduce : ');
% Reduce Y-Matrix
J = y;
for k = reduction_buses
    J = reduce_bus(J, k);
end
% Remove reduced buses
reducedY = remove_reduced_buses(J, reduction_buses);
disp('Reduced Y Bus Matrix:');
disp(reducedY);
% Function: Bus Reduction
function reducedY = reduce_bus(Y, bus_to_reduce)
    N = length(Y);
    reducedY = Y;
    for i = 1:N
        for j = 1:N
    reducedY(i, j) = Y(i, j) - (Y(i, bus_to_reduce) * Y(bus_to_reduce, j)) / Y(bus_to_reduce, bus_to_reduce);
        end
    end
end
% Function: Remove Reduced Buses
function reducedY = remove_reduced_buses(Y, reduction_buses)
    N = length(Y);
    keep_rows = true(1, N);
    keep_rows(reduction_buses) = false;
    reducedY = Y(keep_rows, keep_rows);
end