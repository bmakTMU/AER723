clc; clear all; close all;

%% Load NASA RP-1121 coating database

load('Solar_Absorptance_and_Thermal_Emittance.mat');

% allowed temperature range
T_min_req = 273;
T_max_req = 303;

families = fieldnames(coating);

all_alpha  = [];
all_emiss  = [];
all_name   = strings(0,1);
all_family = strings(0,1);

for fi = 1:length(families)
    fam = families{fi};
    tab = coating.(fam);

    for j = 1:height(tab)
        if ~isnan(tab.alpha(j)) && ~isnan(tab.emm(j))
            all_alpha(end+1,1)  = tab.alpha(j);
            all_emiss(end+1,1)  = tab.emm(j);
            all_name(end+1,1)   = tab.coating_names(j);
            all_family(end+1,1) = fam;
        end
    end
end

N_coats = length(all_alpha);
fprintf('Total usable coatings in database: %d\n', N_coats);

%% Baseline coating for all panels
% keep baseline so only 1 panel changes at a time during optimization.

idx_white = find(all_name == "Titanium Oxide White Paint with Methyl Silicone",1);
idx_black = find(all_name == "Paladin Black Lacquer",1);
idx_cond  = find(all_name == "Brilliant Aluminium Paint",1);

alpha_baseline = zeros(6,1);
emiss_baseline = zeros(6,1);

alpha_baseline(1) = all_alpha(idx_white);
emiss_baseline(1) = all_emiss(idx_white);

alpha_baseline(2) = all_alpha(idx_black);
emiss_baseline(2) = all_emiss(idx_black);

alpha_baseline(3:6) = all_alpha(idx_cond);
emiss_baseline(3:6) = all_emiss(idx_cond);

%% Allocating space for outputs

best_idx = zeros(6,1);
best_alpha = zeros(6,1);
best_emiss = zeros(6,1);
best_energy = inf(6,1);

best_Tmin = zeros(6,1);
best_Tmax = zeros(6,1);

%% Panel-by-panel optimization

for panel = 1:6
    fprintf('\n=== Optimizing Panel %d ===\n', panel);

    energy_list = nan(N_coats,1);
    Tmin_list   = nan(N_coats,1);
    Tmax_list   = nan(N_coats,1);

    for k = 1:N_coats

        % Copy baseline, but replace coating on current panel
        alpha_try = alpha_baseline;
        emiss_try = emiss_baseline;

        alpha_try(panel) = all_alpha(k);
        emiss_try(panel) = all_emiss(k);

        % Run thermal model
        [T_panels, Q_total] = run_thermal(alpha_try, emiss_try);

        % panel temperature history
        Tp = T_panels(panel,:);

        Tmin = min(Tp);
        Tmax = max(Tp);

        % Store for diagnostics
        energy_list(k) = Q_total;
        Tmin_list(k)   = Tmin;
        Tmax_list(k)   = Tmax;

        % Must meet temperature requirement
        if Tmin < T_min_req || Tmax > T_max_req
            continue
        end

        % Objective: minimize heater energy use
        if Q_total < best_energy(panel)
            best_energy(panel) = Q_total;
            best_idx(panel)    = k;
            best_alpha(panel)  = all_alpha(k);
            best_emiss(panel)  = all_emiss(k);
            best_Tmin(panel)   = Tmin;
            best_Tmax(panel)   = Tmax;
        end
    end

    coat_idx = 1:N_coats;

    % Temperature envelope vs coating index for this panel
    figure(1);
    subplot(3,2,panel);
    plot(coat_idx, Tmin_list, 'b.--', 'LineWidth', 1.2); hold on;
    plot(coat_idx, Tmax_list, 'r.--', 'LineWidth', 1.2);
    yline(T_min_req,'--k'); yline(T_max_req,'--k');
    xlabel('Coating Index');
    ylabel('Temperature [K]');
    title(sprintf('Panel %d — Temperature Envelope Across All Coatings', panel));
    legend('T_{min}','T_{max}','Spec Min','Spec Max','Location','best');
    grid on;

    if best_idx(panel) == 0
        fprintf('No feasible coating found for Panel %d.\n', panel);
    else
        fprintf('Best coating for Panel %d: %s (family: %s)\n', ...
            panel, all_name(best_idx(panel)), all_family(best_idx(panel)));
        fprintf(' alpha = %.3f, emiss = %.3f\n', ...
            best_alpha(panel), best_emiss(panel));
        fprintf(' Tmin = %.2f, Tmax = %.2f, Heater energy = %.2f kJ\n', ...
            best_Tmin(panel), best_Tmax(panel), best_energy(panel)/1000);
    end
end

%% Summary
fprintf('\n================ Best Coatings Summary ================\n');
for p = 1:6
    if best_idx(p) ~= 0
        fprintf('Panel %d: %s (alpha=%.3f, emiss=%.3f, E=%.2f kJ)\n', ...
            p, all_name(best_idx(p)), best_alpha(p), best_emiss(p), best_energy(p)/1000);
    else
        fprintf('Panel %d: NO feasible coating found.\n', p);
    end
end

%% Visualization

% Use the best alpha/epsilon on every panel simultaneously
alpha_opt = best_alpha;
emiss_opt = best_emiss;

% Run the thermal model once with the fully optimal set
[T_opt, Q_total_opt] = run_thermal(alpha_opt, emiss_opt);

% Build time vector assuming 30s step
dt = 30;
Nsteps = size(T_opt, 2);
time = (0:Nsteps-1) * dt;

% Plot
figure
subplot(3,1,1);
plot(time, T_opt(1,:), 'LineWidth', 1.5); hold on;
plot(time, T_opt(2,:), 'LineWidth', 1.5);
yline(273, '--b'); yline(303, '--r'); % min and max temperature lines
xlabel('Time [s]');
ylabel('Temperature [K]');
title('Panels 1 & 2 Temperature History (Optimal Coatings)');
legend('Panel 1','Panel 2','T_{min}','T_{max}','Location','best');
grid on;

subplot(3,1,2);
plot(time, T_opt(3,:), 'LineWidth', 1.5); hold on;
plot(time, T_opt(4,:), 'LineWidth', 1.5);
yline(273, '--r'); yline(303, '--b');
xlabel('Time [s]');
ylabel('Temperature [K]');
title('Panels 3 & 4 Temperature History (Optimal Coatings)');
legend('Panel 3','Panel 4','T_{min}','T_{max}','Location','best');
grid on;

subplot(3,1,3);
plot(time, T_opt(5,:), 'LineWidth', 1.5); hold on;
plot(time, T_opt(6,:), 'LineWidth', 1.5);
yline(273, '--r'); yline(303, '--b');
xlabel('Time [s]');
ylabel('Temperature [K]');
title('Panels 5 & 6 Temperature History (Optimal Coatings)');
legend('Panel 5','Panel 6','T_{min}','T_{max}','Location','best');
grid on;

fprintf('\nTotal heater energy with ALL optimal coatings applied: %.2f kJ\n', Q_total_opt/1000);
%% Save optimal coating set

best_names = all_name(best_idx);
save('optimal_coatings.mat', 'best_alpha', 'best_emiss', 'best_idx', 'best_names','best_energy', 'best_Tmin', 'best_Tmax');