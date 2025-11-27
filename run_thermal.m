%% run_thermal(): ThermalModel.m

function [T_panels, Q_total] = run_thermal(alpha, emiss)

    % Load ephemeris
    load('satellite_ephemeris1.mat');   % loads "sat"

    % Initial temperatures
    T1(1)=285; T2(1)=285; T3(1)=285;
    T4(1)=285; T5(1)=285; T6(1)=285;

    % Constants
    J_sun = 1371; J_earth = 237;
    boltz = 5.67e-8;
    m = 0.972; c_p = 910;
    R_e = 6378;
    theta = 0;

    % Heaters
    Qe = [40;40;40;40;40;40];
    Qi = [20;20;0;0;0;0];

    % Coating properties on each panel
    A = alpha(:);
    E = emiss(:);

    Q_total = 0;
    N = size(sat.pos_I,1);

    for i = 2:N

        % Positions
        R_sc  = sat.pos_I(i-1,:);
        V_sc  = sat.vel_I(i-1,:);
        R_sun = sat.sun_pos_I(i-1,:);

        % Eclipse check (corrected indexing)
        condition_1 = dot(R_sc, R_sun);
        condVec = [ ...
            R_sun(1) - condition_1*R_sun(1), ...
            R_sun(2) - condition_1*R_sun(2), ...
            R_sun(3) - condition_1*R_sun(3) ];
        condition_2 = norm(condVec);

        in_eclipse = (condition_1 < 0) && (condition_2 > R_e);

        % Case 1: Eclipse
        if in_eclipse

            dT1 = (Qe(1) - 0.09*boltz*T1(i-1)^4)/(m*c_p);
            dT2 = (Qe(2) - 0.09*boltz*T2(i-1)^4)/(m*c_p);
            dT3 = (Qe(3) - 0.09*boltz*T3(i-1)^4)/(m*c_p);
            dT4 = (Qe(4) - 0.09*boltz*T4(i-1)^4)/(m*c_p);
            dT5 = (Qe(5) - 0.09*boltz*T5(i-1)^4)/(m*c_p);
            dT6 = (Qe(6) - 0.09*boltz*T6(i-1)^4)/(m*c_p);

            T1(i)=T1(i-1)+30*dT1; T2(i)=T2(i-1)+30*dT2;
            T3(i)=T3(i-1)+30*dT3; T4(i)=T4(i-1)+30*dT4;
            T5(i)=T5(i-1)+30*dT5; T6(i)=T6(i-1)+30*dT6;

            Q_total = Q_total + sum(Qe)*30;
            continue
        end

        % Case 2: Sunlit

        Rmag = norm(R_sc);
        R1 = R_sc/Rmag;

        h = cross(R_sc, V_sc);
        R3 = h/norm(h);

        R2 = cross(R3, R1);
        R2 = R2/norm(R2);

        C_ir = [R1(1) R2(1) R3(1);
                R1(2) R2(2) R3(2);
                R1(3) R2(3) R3(3)];

        sunB = (R_sun*C_ir);

        theta = theta + 0.523599; % 30 deg per step
        C_rot = [1 0 0;
                 0 cos(theta) -sin(theta);
                 0 sin(theta)  cos(theta)];

        sunB = sunB*C_rot;

        x=sunB(1); y=sunB(2); z=sunB(3);

        beta_x = atan(abs(x)/sqrt(y^2+z^2));
        beta_y = atan(abs(y)/sqrt(x^2+z^2));
        beta_z = atan(abs(z)/sqrt(y^2+x^2));

        % Panel illuminated areas
        A1 = 0.09*cos(beta_x)*(x>=0);
        A2 = 0.09*cos(beta_x)*(x<0);
        A3 = 0.09*cos(beta_y)*(y>=0);
        A4 = 0.09*cos(beta_y)*(y<0);
        A5 = 0.09*cos(beta_z)*(z>=0);
        A6 = 0.09*cos(beta_z)*(z<0);

        % Temperature derivatives
        dT1 = (Qi(1)+A1*A(1)*(J_sun+J_earth)-0.09*E(1)*boltz*T1(i-1)^4)/(m*c_p);
        dT2 = (Qi(2)+A2*A(2)*J_sun           -0.09*E(2)*boltz*T2(i-1)^4)/(m*c_p);
        dT3 = (Qi(3)+A3*A(3)*J_sun           -0.09*E(3)*boltz*T3(i-1)^4)/(m*c_p);
        dT4 = (Qi(4)+A4*A(4)*J_sun           -0.09*E(4)*boltz*T4(i-1)^4)/(m*c_p);
        dT5 = (Qi(5)+A5*A(5)*J_sun           -0.09*E(5)*boltz*T5(i-1)^4)/(m*c_p);
        dT6 = (Qi(6)+A6*A(6)*J_sun           -0.09*E(6)*boltz*T6(i-1)^4)/(m*c_p);

        % Integrate
        T1(i)=T1(i-1)+30*dT1; T2(i)=T2(i-1)+30*dT2;
        T3(i)=T3(i-1)+30*dT3; T4(i)=T4(i-1)+30*dT4;
        T5(i)=T5(i-1)+30*dT5; T6(i)=T6(i-1)+30*dT6;

        Q_total = Q_total + sum(Qi)*30;

    end

    % Output in matrix form
    T_panels = [T1; T2; T3; T4; T5; T6];

end