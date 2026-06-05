clc;
clear all;
close all;
%STEP 1 
% Read bus data and form Y-bus matrix
% Example 3-bus system Y-bus we can change this
Ybus = [ 10-30i  -5+15i  -5+15i;
        -5+15i   10-30i  -5+15i;
        -5+15i  -5+15i   10-30i ];
% Bus type: 1 = Slack, 2 = PV, 3 = PQ
bus_type = [1; 3; 3];
% Specified real and reactive power (p.u.)
P_spec = [ 0;
          -1.0;
          -0.8 ];
Q_spec = [ 0;
          -0.5;
          -0.3 ];
tol = 1e-6;
max_iter = 20;
nbus = length(P_spec);
%STEP 2
% Assume initial voltage magnitudes and angles
V = ones(nbus,1);          % Initial voltage magnitude
delta = zeros(nbus,1);    % Initial voltage angle (rad)
iter = 0;

while iter < max_iter
    
    iter = iter + 1;
% STEP 3
    % Calculate real and reactive power at each bus
    P = zeros(nbus,1);
    Q = zeros(nbus,1);

    for i = 1:nbus
        for k = 1:nbus
            G = real(Ybus(i,k));
            B = imag(Ybus(i,k));

            P(i) = P(i) + V(i)*V(k)* ...
                (G*cos(delta(i)-delta(k)) + B*sin(delta(i)-delta(k)));

            Q(i) = Q(i) + V(i)*V(k)* ...
                (G*sin(delta(i)-delta(k)) - B*cos(delta(i)-delta(k)));
        end
    end
%STEP 4 =================
    % Calculate power mismatches
    dP = P_spec - P;
    dQ = Q_spec - Q;

    % Remove slack bus from ΔP
    dP(bus_type == 1) = [];

    % Keep only PQ buses in ΔQ
    dQ(bus_type ~= 3) = [];

    %% ================= STEP 5 =================
    % Check convergence
    if max(abs([dP; dQ])) < tol
        break;
    end
 %STEP 6 
    % Solve J1 * Δdelta = ΔP and update angles
    non_slack = find(bus_type ~= 1);
    J1 = zeros(length(non_slack));

    for i = 1:length(non_slack)
        m = non_slack(i);
        for k = 1:length(non_slack)
            n = non_slack(k);

            if m == n
                for r = 1:nbus
                    G = real(Ybus(m,r));
                    B = imag(Ybus(m,r));
                    J1(i,i) = J1(i,i) + V(m)*V(r)* ...
                        (-G*sin(delta(m)-delta(r)) + B*cos(delta(m)-delta(r)));
                end
            else
                G = real(Ybus(m,n));
                B = imag(Ybus(m,n));
                J1(i,k) = V(m)*V(n)* ...
                    (G*sin(delta(m)-delta(n)) - B*cos(delta(m)-delta(n)));
            end
        end
    end

    d_delta = J1 \ dP;
    delta(non_slack) = delta(non_slack) + d_delta;
 %STEP 7
    % Solve J4 * ΔV = ΔQ and update voltage magnitudes
    pq_bus = find(bus_type == 3);
    J4 = zeros(length(pq_bus));

    for i = 1:length(pq_bus)
        m = pq_bus(i);
        for k = 1:length(pq_bus)
            n = pq_bus(k);

            if m == n
                for r = 1:nbus
                    G = real(Ybus(m,r));
                    B = imag(Ybus(m,r));
                    J4(i,i) = J4(i,i) + V(r)* ...
                        (G*sin(delta(m)-delta(r)) - B*cos(delta(m)-delta(r)));
                end
            else
                G = real(Ybus(m,n));
                B = imag(Ybus(m,n));
                J4(i,k) = V(m)* ...
                    (G*sin(delta(m)-delta(n)) - B*cos(delta(m)-delta(n)));
            end
        end
    end

    dV = J4 \ dQ;
    V(pq_bus) = V(pq_bus) + dV;

end
% Show the results
disp('Number of iterations:');
disp(iter);

disp('Final Voltage Magnitudes (p.u.):');
disp(V);

disp('Final Voltage Angles (rad):');
disp(delta);
