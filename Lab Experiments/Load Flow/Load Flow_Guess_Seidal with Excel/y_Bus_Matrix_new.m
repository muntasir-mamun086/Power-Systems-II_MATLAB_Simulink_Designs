% Function of making Y-Bus Matrix
function y = y_Bus_Matrix_new(x)
% This Y-bus Admittance Matrix calculation
format compact; 
format short; 
% Reading data from Excel
A = xlsread('y_bus_new_exp.xlsx'); 
len = size(A, 1); 
% Building the Impedance Matrix (Z)
for j = x : len 
    Z(A(j,1),A(j,2)) = A(j,3) + A(j,4)*1i; 
    Z(A(j,2),A(j,1)) = A(j,3) + A(j,4)*1i; 
end 
m = length(Z); 
for t = 1 : m 
    for j = 1:m 
        if Z(t,j) == 0 
            Z(t,j) = inf; 
        end 
    end 
end 
% Admittance Calculation
K = 1./Z; 
sum_val = 0; 
D = zeros(m,m); 
% Forming the Y-Bus Matrix
for r = 1 : m 
    for j = 1:m 
        sum_val = sum_val + K(r,j); 
        if r ~= j 
            D(r,j) = -1*K(r,j); 
        end 
    end 
    D(r,r) = sum_val; 
    sum_val = 0; 
end 
fprintf('\n The Y_Bus Matrix : \n'); 
disp(D); 
y = D; % Return value
fprintf('\n\n'); 
end