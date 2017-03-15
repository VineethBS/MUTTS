function list_of_parameters_and_initial_values = get_dynamic_tunable_parameters(o)
list_of_parameters_and_initial_values = [];
list_of_parameters_and_initial_values{end + 1} = {'observation_snr_limit', o.observation_snr_limit};
list_of_parameters_and_initial_values{end + 1} = {'observation_pointing_limit', o.observation_pointing_limit};
list_of_parameters_and_initial_values = [list_of_parameters_and_initial_values, o.gating.get_dynamic_tunable_parameters()];
list_of_parameters_and_initial_values = [list_of_parameters_and_initial_values, o.data_association.get_dynamic_tunable_parameters()];
list_of_parameters_and_initial_values = [list_of_parameters_and_initial_values, o.track_maintenance.get_dynamic_tunable_parameters()];