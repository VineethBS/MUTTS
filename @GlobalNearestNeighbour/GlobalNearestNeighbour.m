classdef GlobalNearestNeighbour
    % Global nearest neighbour method for data association
    
    properties
    end
    
    methods
        function o = GlobalNearestNeighbour(~)
        end
        
        function list_of_parameters_and_initial_values = get_dynamic_tunable_parameters(o)
            list_of_parameters_and_initial_values = [];
        end

        function o = set_dynamic_tunable_parameters(o, parameter_name, new_value)
        end

        [matching_matrix, cost] = hungarian_matching(o, cost_matrix);
        data_association_matrix = find_data_association(o, observations, list_of_tracks, gate_membership_matrix);
    end
    
end

