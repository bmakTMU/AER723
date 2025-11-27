clc; clear; close all;

alpha_vec = [];
emiss_vec = [];
best_names = [];

if exist('optimal_coatings.mat','file')
    % Try to load everything, including names
    data = load('optimal_coatings.mat');

    if isfield(data, 'best_alpha') && isfield(data, 'best_emiss')
        alpha_vec = data.best_alpha(:);
        emiss_vec = data.best_emiss(:);
        fprintf('Loaded optimal alpha/epsilon from optimal_coatings.mat\n');
    else
        warning('optimal_coatings.mat found but missing best_alpha/best_emiss. Using baseline coatings.');
    end

    if isfield(data, 'best_names')
        best_names = data.best_names;
        fprintf('Loaded coating names from optimal_coatings.mat\n');
    else
        fprintf('No best_names field in optimal_coatings.mat. Names will not be shown.\n');
    end
else
    fprintf('optimal_coatings.mat not found. Using baseline coatings.\n');
end

% Fallback: baseline lab coating set (same as original ThermalModel.m)
if isempty(alpha_vec) || isempty(emiss_vec)
    alpha_vec = [0.06; 0.95; 0.30; 0.30; 0.30; 0.30];
    emiss_vec = [0.88; 0.75; 0.31; 0.31; 0.31; 0.31];
end

%% Thermal Model
[T_panels, Q_total] = run_thermal(alpha_vec, emiss_vec);

% Time vector assuming 30 s fixed time step
dt    = 30;                         % [s]
Nstep = size(T_panels, 2);
time  = (0:Nstep-1) * dt;           % [s]

fprintf('Total heater energy over simulation: %.2f kJ\n', Q_total/1000);

%% Plot

T1 = T_panels(1,:); T2 = T_panels(2,:);
T3 = T_panels(3,:); T4 = T_panels(4,:);
T5 = T_panels(5,:); T6 = T_panels(6,:);

T_min_req = 273;
T_max_req = 303;

% X-direction panels (1: +X radial outward, 2: -X Earth-facing)
figure;
plot(time, T1, 'LineWidth', 1.5); hold on;
plot(time, T2, 'LineWidth', 1.5);
yline(T_min_req, '--k');
yline(T_max_req, '--k');
xlabel('Time [s]');
ylabel('Temperature [K]');
title('Panels 1 & 2 (X-direction)');
legend('Panel 1 (+X, space-facing)', ...
       'Panel 2 (-X, Earth-facing)', ...
       'T_{min}','T_{max}', ...
       'Location','best');
grid on;

% Y-direction panels (3 & 4)
figure;
plot(time, T3, 'LineWidth', 1.5); hold on;
plot(time, T4, 'LineWidth', 1.5);
yline(T_min_req, '--k');
yline(T_max_req, '--k');
xlabel('Time [s]');
ylabel('Temperature [K]');
title('Panels 3 & 4 (Y-direction)');
legend('Panel 3 (+Y)', 'Panel 4 (-Y)', 'T_{min}','T_{max}', ...
       'Location','best');
grid on;

% Z-direction panels (5 & 6)
figure;
plot(time, T5, 'LineWidth', 1.5); hold on;
plot(time, T6, 'LineWidth', 1.5);
yline(T_min_req, '--k');
yline(T_max_req, '--k');
xlabel('Time [s]');
ylabel('Temperature [K]');
title('Panels 5 & 6 (Z-direction)');
legend('Panel 5 (+Z, orbit normal)', ...
       'Panel 6 (-Z, -orbit normal)', ...
       'T_{min}','T_{max}', ...
       'Location','best');
grid on;

%% Summary
fprintf('\nCoating set used in this run:\n');
for p = 1:6
    if ~isempty(best_names)
        % best_names may be string array or cell array
        if isstring(best_names) || ischar(best_names)
            name_p = best_names(p);
        else
            name_p = best_names{p};
        end
        fprintf(' Panel %d: %s (alpha = %.3f, emiss = %.3f)\n', ...
            p, name_p, alpha_vec(p), emiss_vec(p));
    else
        fprintf(' Panel %d: alpha = %.3f, emiss = %.3f\n', ...
            p, alpha_vec(p), emiss_vec(p));
    end
end
