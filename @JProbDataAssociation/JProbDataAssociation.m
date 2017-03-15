classdef JProbDataAssociation
    % Joint probabilistic data association
    
    properties
        detection_probability;
        false_alarm_rate;
    end
    
    methods
        function o = JProbDataAssociation(parameters)
            o.detection_probability = parameters.detection_probability;
            o.false_alarm_rate = parameters.false_alarm_rate;
        end
        
        function list_of_parameters_and_initial_values = get_dynamic_tunable_parameters(o)
            list_of_parameters_and_initial_values = [];
            list_of_parameters_and_initial_values{end + 1} = {'detection_probability', o.detection_probability};
            list_of_parameters_and_initial_values{end + 1} = {'false_alarm_rate', o.false_alarm_rate};
        end
        
        function o = set_dynamic_tunable_parameters(o, parameter_name, new_value)
            switch parameter_name
                case 'detection_probability'
                    o.detection_probability = double(new_value);
                case 'false_alarm_rate'
                    o.false_alarm_rate = double(new_value);
                otherwise
                    return
            end
        end


        jpda_probability_matrix = find_data_association(o, observations, list_of_tracks, gate_membership_matrix);
        all_possible_valid_hypothesis = o.get_all_possible_valid_hypothesis(gate_membership_matrix);
        hypothesis_probability = o.get_hypothesis_probability(observations, list_of_tracks, all_possible_valid_hypothesis); 
        jpda_probability_matrix = o.get_jpda_probability_matrix(observations, list_of_tracks, hypothesis_probability,  all_possible_valid_hypothesis); 
    end
    
end

