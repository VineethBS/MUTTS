classdef NOutOfM
    % Track maintenance using N out of M technique
    %   A track is said to be new if the number of times it has been
    %   updated is less than confirm_threshold
    %   If the track is new and the number of associations it had in the
    %   last confirm_M times is less than confirm_N then the track is made
    %   inactive, else it is confirmed
    %   For a confirmed track, a track is declared to be active if it has 
    %   at least N associations in the past M time instants
    
    properties
        N;
        M;
        confirm_threshold;
        confirm_M;
        confirm_N;
    end
    
    methods
        function o = NOutOfM(track_maintenance_parameters)
            o.N = track_maintenance_parameters.N;
            o.M = track_maintenance_parameters.M;
            o.confirm_threshold = track_maintenance_parameters.confirm_threshold;
            o.confirm_N = track_maintenance_parameters.confirm_N;
            o.confirm_M = track_maintenance_parameters.confirm_M;
        end
        
        function list_of_parameters_and_initial_values = get_dynamic_tunable_parameters(o)
            list_of_parameters_and_initial_values = [];
            list_of_parameters_and_initial_values{end + 1} = {'N', o.N};
            list_of_parameters_and_initial_values{end + 1} = {'M', o.M};
            list_of_parameters_and_initial_values{end + 1} = {'confirm_threshold', o.confirm_threshold};
            list_of_parameters_and_initial_values{end + 1} = {'confirm_M', o.confirm_M};
            list_of_parameters_and_initial_values{end + 1} = {'confirm_N', o.confirm_N};
        end
        
        function o = set_dynamic_tunable_parameters(o, parameter_name, new_value)
            switch parameter_name
                case 'N'
                    o.N = double(new_value);
                case 'M'
                    o.M = double(new_value);
                case 'confirm_threshold'
                    o.confirm_threshold = double(new_value);
                case 'confirm_M'
                    o.confirm_M = double(new_value);
                case 'confirm_N'
                    o.confirm_N = double(new_value);
                otherwise
                    return
            end
        end
        

        function [active_tracks, inactive_tracks] = get_active_inactive_tracks(o, list_of_tracks)
            active_tracks = {};
            inactive_tracks = {};
            num_of_tracks = length(list_of_tracks);
            for i = 1:num_of_tracks
                current_track = list_of_tracks{i};
                %take only those times at which the radar points at the
                %target
                sequence_times_seen=setdiff(current_track.sequence_times,current_track.sequence_times_notobserved);

                
                if length(sequence_times_seen) <= o.confirm_threshold
                    if length(sequence_times_seen) <= o.confirm_M
                        current_track.state = 2; %%%% raghava
                        active_tracks{end + 1} = current_track;
                        continue;
                    end
                    last_M_start_time = sequence_times_seen(end - o.confirm_M);
                    if sum(current_track.sequence_times_observations >= last_M_start_time) >= o.confirm_N
                        current_track.state = 2; %%%% raghava
                        active_tracks{end + 1} = current_track;
                    end
                    % note that we will completely disregard this track
                    % here and it is not even added to inactive tracks
                else
                    if length(sequence_times_seen) <= o.M
                        active_tracks{end + 1} = current_track;
                        continue;
                    end
                    last_M_start_time = sequence_times_seen(end - o.M);
                    if sum(current_track.sequence_times_observations >= last_M_start_time) >= o.N
                        current_track.state = 2; %%%% raghava
                        active_tracks{end + 1} = current_track;
                    else
                        current_track.state = 0; %%%% raghava
                        inactive_tracks{end + 1} = current_track;
                    end
                end
            end
        end
    end
end

