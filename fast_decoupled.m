clc;
clear all;
close all;
% STEP 1 
% Read system data and form Y-bus matrix
% Let 3-bus system
Ybus = [ 10-30i  -5+15i  -5+15i;
        -5+15i   10-30i  -5+15i;
        -5+15i  -5+15i   10-30i ];
% Bus type: 1 = Slack, 2 = PV, 3 = PQ
bus_type = [1; 3; 3];
% Specified real and reactive powers (p.u.)
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
% Classify buses and assume initial voltage magnitudes and angles
V = ones(nbus,1);           % Initial voltage magnitude
delta = zeros(nbus,1);     % Initial voltage angle (rad)
%STEP 3
% Build constant B' and B'' matrices from imaginary part of Ybus
B = imag(Ybus);
% Indices
non_slack = find(bus_type ~= 1);
pq_bus = find(bus_type == 3);
% B' matrix (remove slack bus)
Bp = -B(non_slack, non_slack);
% B'' matrix (only PQ buses)
Bpp = -B(pq_bus, pq_bus);
iter = 0;

while iter < max_iter
    iter = iter + 1;
 % STEP 4 
 % Calculate real and reactive power at each bus
    P = zeros(nbus,1);
    Q = zeros(nbus,1);

    for i = 1:nbus
        for k = 1:nbus
            G = real(Ybus(i,k));
            Bk = imag(Ybus(i,k));

            P(i) = P(i) + V(i)*V(k)* ...
                (G*cos(delta(i)-delta(k)) + Bk*sin(delta(i)-delta(k)));

            Q(i) = Q(i) + V(i)*V(k)* ...
                (G*sin(delta(i)-delta(k)) - Bk*cos(delta(i)-delta(k)));
        end
    end
%STEP 5
    % Compute power mismatches and check convergence

    dP = P_spec - P;
    dQ = Q_spec - Q;
% Remove slack bus from ΔP
    dP = dP(non_slack) ./ V(non_slack);

    % Use only PQ buses for ΔQ
    dQ = dQ(pq_bus) ./ V(pq_bus);

    if max(abs([dP; dQ])) < tol
        break;
    end
%STEP 6 
% Solve B' * Δdelta = ΔP/V and update angles

    d_delta = Bp \ dP;
    delta(non_slack) = delta(non_slack) + d_delta;
% STEP 7 
% Solve B'' * ΔV = ΔQ/V and update voltage magnitudes
    dV = Bpp \ dQ;
    V(pq_bus) = V(pq_bus) + dV;

end

%Find the results
disp('Number of iterations:');
disp(iter);

disp('Final Voltage Magnitudes (p.u.):');
disp(V);

disp('Final Voltage Angles (rad):');
disp(delta);
