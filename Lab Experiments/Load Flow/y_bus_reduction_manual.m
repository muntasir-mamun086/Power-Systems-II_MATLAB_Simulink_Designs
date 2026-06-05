clc;
clear all;
close all;
Y=[1 2 3 4;
   5 6 7 8;
   9 10 11 12;
   13 14 15 16];
K=input('Enter the bus number to reduce : ');
N=size(Y,1);
for i=1:N
    for j=1:N
        Y_new(i,j)=Y(i,j) - (Y(i,K)*Y(K,j)/Y(K,K));
    end
end
Y_new(K,:)=[];
Y_new(:,K)=[];
disp('Reduced Y-bus Matrix:');
disp(Y_new);