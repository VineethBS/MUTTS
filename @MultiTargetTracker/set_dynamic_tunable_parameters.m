function o = set_dynamic_tunable_parameters(o, parameter_name, new_value)

switch parameter_name
    case 'observation_snr_limit'
        o.observation_snr_limit = double(new_value);
    case 'observation_pointing_limit'
        o.observation_pointing_limit = double(new_value);
    otherwise
        o.gating = o.gating.set_dynamic_tunable_parameters(parameter_name, new_value);
        o.data_association = o.data_association.set_dynamic_tunable_parameters(parameter_name, new_value);
        o.track_maintenance = o.track_maintenance.set_dynamic_tunable_parameters(parameter_name, new_value);
end
        
       