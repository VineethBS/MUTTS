classdef MUTTS_Configuration
    properties
        default_filename;
        configuration_file;
        configuration_file_chosen;
        
        dt;
        dimension_observations;
        use_additional_information;
        observation_snr_limit;
        observation_pointing_limit;
        
        % parameters for the input file
        inputfile_parameters;
        
        % filter parameters
        filter_type;
        filter_parameters;
        
        % gating parameters
        gating_method_type;
        gating_method_parameters;
        
        % GNN parameters
        data_association_type;
        data_association_parameters;
        
        % Track maintenance parameters
        track_maintenance_type;
        track_maintenance_parameters;
        
        % Visualization parameters
        visualization_parameters;
        
        % Metrics parameters
        metrics_parameters;
        
        % Post processing parameters
        atleastN_parameters;
        velocitythreshold_parameters;
    end
    
    methods
        function o = MUTTS_Configuration(default_filename)
            o.default_filename = default_filename;
        end
        
        function o = internal_load_from_file(o, filename)
            if exist(filename, 'file') == 2
                run(filename); % this will populate the local workspace with the configuration variables that we need
            else
                error('%s does not exist!', filename);
                return;
            end
            o.dt = dt;
            o.dimension_observations = dimension_observations;
            o.use_additional_information = use_additional_information;
            o.observation_snr_limit = observation_snr_limit;
            o.observation_pointing_limit = observation_pointing_limit;
            o.inputfile_parameters = inputfile_parameters;
            o.filter_type = filter_type;
            o.filter_parameters = filter_parameters;
            o.gating_method_type = gating_method_type;
            o.gating_method_parameters = gating_method_parameters;
            o.data_association_type = data_association_type;
            o.data_association_parameters = data_association_parameters;
            o.track_maintenance_type = track_maintenance_type;
            o.track_maintenance_parameters = track_maintenance_parameters;
            o.visualization_parameters = visualization_parameters;
            o.metrics_parameters = metrics_parameters;
            o.atleastN_parameters = atleastN_parameters;
            o.velocitythreshold_parameters = velocitythreshold_parameters;
        end
        
        function o = load_default_configuration(o)
            o = o.internal_load_from_file(o.default_filename);
        end
        
        function o = load_from_file(o)
            [configuration_file, configuration_path] = uigetfile('*.m', 'Choose Configuration File');

            if ~(isequal(configuration_file, 0))
                o.configuration_file = fullfile(configuration_path, configuration_file);
                o.configuration_file_chosen = 1;
                o = o.internal_load_from_file(o.configuration_file);
            end
        end
        
        function o = configure(o, block)
            switch block
                case 'dataassociation'
                    o = configure_dataassociation(o);
                case 'filter'
                    o = configure_filter(o);
                case 'gating'
                    o = configure_gating(o);
                case 'trackmaintenance'
                    o = configure_trackmaintenance(o);
            end
        end
    end    
end

