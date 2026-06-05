% Code for Load Flow Portion
clc; 
clear all; 
close all;
format compact; 
format long; 
% Calling the Y_Bus_Matrix_new function with x=1
Y = y_Bus_Matrix_new(1); 
G = xlsread('load_flow_ex_6_8'); 
[row colm] = size(G); 
for t = 1:row 
V(t)= G(t,1)*cos(G(t,6))+G(t,1)*sin(G(t,6))*j; 
end 
sum1 = 0; 
sum2 = 0; 
sum3 = 0; 
for t = 1: 15 
for i = 2: row          
if G(i,2)== 0 && G(i,3) == 0 
        P(i) = G(i,2) - G(i,4); 
        Q(i) = G(i,3) - G(i,5); 
         for k = 1:row 
            if i ~= k 
            II(i) = sum2 + Y(i,k)*V(k); 
            sum2 = II(i); 
            end 
         end 
         sum2 = 0; 
        II(i); 
        Vn(i) = (1/Y(i,i))*(((P(i)- Q(i)*j)/conj(V(i)))-II(i)); 
        V(i) = Vn(i); 
        V_angle(i) = rad2deg(angle(V(i))); 
    else 
         P(i) = G(i,2)-G(i,4); 
         for k = 1:row 
            I(i) = sum1 + Y(i,k)*V(k); 
            sum1 = I(i); 
         end 
         sum1 = 0; 
         Q(i) = imag(V(i)*conj(I(i))); 
         for k = 1:row 
            if i ~= k 
            It(i) = sum3 + Y(i,k)*V(k); 
            sum3 = It(i); 
            end 
         end 
         sum3 = 0; 
         Vv(i) = (1/Y(i,i))*(((P(i)- Q(i)*j)/conj(V(i)))-It(i)); 
         rr = sqrt(((G(i,1))^2)-(imag(Vv(i)))^2); 
         V(i) = rr + imag(Vv(i))*j; 
         V_angle(i) = rad2deg(angle(V(i))); 
    end 
end 
  
F(t,1:7) = [t V V_angle]; 
  
end 
F =array2table(F); 
F