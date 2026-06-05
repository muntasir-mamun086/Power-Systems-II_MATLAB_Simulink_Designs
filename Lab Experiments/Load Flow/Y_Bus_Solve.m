clc;
clear all;
close all;
%      From   To    R     X
z = [
        1      2    0    0.4
        1      3    0    0.2
        2      3    0    0.2
        1      0    0    1.0
        2      0    0    0.8
        3      4    0    0.08
];
nbus = max(max(z(:,1:2)));   % Number of buses
% Initialize Ybus matrix
Y = zeros(nbus,nbus);
% Formation of Ybus
for k = 1:size(z,1)
    from = z(k,1);
    to   = z(k,2);
    R = z(k,3);
    X = z(k,4);

    Z = R + 1i*X;
    y = 1/Z;

    if from ~= 0
        Y(from,from) = Y(from,from) + y;
    end

    if to ~= 0
        Y(to,to) = Y(to,to) + y;
    end

    if from ~= 0 && to ~= 0
        Y(from,to) = Y(from,to) - y;
        Y(to,from) = Y(to,from) - y;
    end
end
disp('Ybus = ');
disp(Y);
% Zbus
Zbus = inv(Y);
disp('Zbus  = ');
disp(Zbus);
% Given voltages
E1 = 1.1*exp(1i*0);
E2 = 1.0*exp(1i*0);
E3 = 0;
E4 = 0;
E = [E1; E2; E3; E4];
% Bus voltages
V = Zbus * E;
disp('Vbus = ');
disp(V);