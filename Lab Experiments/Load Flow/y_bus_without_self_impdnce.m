% Without Self Impedance MATLAB Code
clc;
clear all;
close all;
format compact;
format short;
A = [inf 0.05+0.15i inf 0.09+0.19i;
    0.05+0.15i inf 0.03+0.23i inf;
    inf 0.03+0.23i inf 0.02+0.12i;
    0.09+0.19i inf 0.02+0.12i inf];
fprintf('\n The Impedance matrix : \n'); 
disp(A)
D = A;
[row colm] = size(D);
 for i = 1:row
     for j = 1: colm
             D(i,j) = 1/D(i,j);
     end
 end
 fprintf('\n The Admittance matrix : \n');
 disp(D)
 sum =0;
 for i = 1:row
     for j = 1:colm
         sum = sum + D(i,j);
         if i~=j
             D(i,j) = -D(i,j);
         end
     end
     D(i,i) = sum;
 end
 fprintf('\n The Y-bus matrix : \n');
 disp(D)