% Load the data

%load("/MATLAB Drive/sensitivity_results.mat");

% Get dimensions

[n_params, n_outputs, n_scenarios] = size(results);

% Preallocate a matrix for flattened results

flat_data = [];

% Flatten results into 2D: rows = parameters, columns = output_scenario

for s = 1:n_scenarios

    flat_data = [flat_data, results(:, :, s)];

end

% Define output descriptions (order from compute_outputs)

output_labels = {

    'V_peak',          % max(V)

    'D_peak',          % max(D)

    'SplusR_min',      % min(S + R)

    'MPhi_I_peak',     % max(MPhi_I)

    'T_peak',          % max(T)

    'NK_peak',          % max(NK)

    'IkilledbyNK',      % max(IkilledbyNK)

    'LU_peak',         % max(LU)

    'IFN_peak',        % max(FU)

    'IFN_total'        % trapz(FU)

    'IFNgamma_peak',        % max(GU)

    'IFNgamma_total'        % trapz(GU)

    'TNFalpha_peak',        % max(TU)

    'TNFalpha_total'        % trapz(TU)

};

% Define scenario suffixes

scenario_suffixes = {'plus5pct', 'minus5pct'};

% Create descriptive column names

col_names = {};

for s = 1:n_scenarios

    for o = 1:n_outputs

        col_names{end+1} = sprintf('%s_%s', output_labels{o}, scenario_suffixes{s});

    end

end

% Convert to table and add parameter names

T = array2table(flat_data, 'VariableNames', col_names);

T.ParamName = param_names;

% Move 'ParamName' to the first column

T = movevars(T, 'ParamName', 'Before', 1);

% Save to CSV

writetable(T, 'sensitivity_results_flattened.csv');