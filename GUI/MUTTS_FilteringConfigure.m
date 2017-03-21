function filter_parameters = MUTTS_FilteringConfigure

% Todo we should pass in a filter parameters to be used for initialization which should be passed out
dt = 1;

filter_type = 'kalmanfilter';

filter_parameters.A = [1 0 0 dt 0 0 0 0 0;
                       0 1 0 0 dt 0 0 0 0;
                       0 0 1 0 0 dt 0 0 0;
                       0 0 0 1 0 0 0 0 0;
                       0 0 0 0 1 0 0 0 0;
                       0 0 0 0 0 1 0 0 0;
                       0 0 0 0 0 0 1 0 0;
                       0 0 0 0 0 0 0 1 0;
                       0 0 0 0 0 0 0 0 1];
                   
filter_parameters.C = [1 0 0 0 0 0 0 0 0;0 1 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 0 0];

filter_parameters.Q = 1.1*eye(9);%[1 0 0
		               %0 1 0
                       %0 0 1];
                   
filter_parameters.R = 0.000001*eye(3);

filter_parameters.rest_of_initial_state = [0.1*randn(1);
                                           0.1*randn(1);
                                           0.1*randn(1);
                                           0.1*randn(1);
                                           0.1*randn(1);
                                           0.1*randn(1)];

addpath PG/
addpath ../

% Properties for alpha beta filter
properties = [ ...
    PropertyGridField('doublematrix', [], 'Category', 'Alpha Beta Filter', 'DisplayName', 'A'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Alpha Beta Filter', 'DisplayName', 'C'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Alpha Beta Filter', 'DisplayName', 'Gain Position'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Alpha Beta Filter', 'DisplayName', 'Gain Velocity'), ...
    PropertyGridField('double', 2, 'Category', 'Alpha Beta Filter', 'DisplayName', 'alpha'), ...
    PropertyGridField('double', 2, 'Category', 'Alpha Beta Filter', 'DisplayName', 'beta'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Alpha Beta Filter', 'DisplayName', 'Initial State')];
    
% Properties for Kalman filter
properties = [properties, ...
    PropertyGridField('doublematrix', [], 'Category', 'Kalman Filter', 'DisplayName', 'A'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Kalman Filter', 'DisplayName', 'C'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Kalman Filter', 'DisplayName', 'Q'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Kalman Filter', 'DisplayName', 'R'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Kalman Filter', 'DisplayName', 'Initial State')];
  
% Properties for Extended Kalman filter
properties = [properties, ...
    PropertyGridField('doublematrix', [], 'Category', 'Extended Kalman Filter', 'DisplayName', 'A'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Extended Kalman Filter', 'DisplayName', 'C'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Extended Kalman Filter', 'DisplayName', 'Q'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Extended Kalman Filter', 'DisplayName', 'R'), ...
    PropertyGridField('doublematrix', [], 'Category', 'Extended Kalman Filter', 'DisplayName', 'Initial State')];

properties = properties.GetHierarchy();

% Set up the main figure
f = figure;
set(f, 'ToolBar', 'none', 'MenuBar', 'none', 'Name', 'Configure gating parameters');
set(f, 'numbertitle', 'off', 'Position', [0, 0, 300, 490], 'Resize', 'off');
% panel = uipanel(f);

% Add to the main figure
choice = uibuttongroup('Parent', f, 'Title', 'Choose gating method type');
alphabeta_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Alpha Beta Filter', 'Position', [2, 430, 220, 30]);
kalman_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Kalman Filter', 'Position', [2, 400, 220, 30]);
ekf_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Extended Kalman Filter', 'Position', [2, 370, 220, 30]);

% Prepare a properties table containing the list
grid = PropertyGrid(f, 'Properties', properties, 'Position', [10, 50, 250, 450]);

button_ok = uicontrol('Parent', f, 'Style', 'pushbutton', 'String', 'Ok', 'Position', [90, 10, 70, 30], 'Callback', @button_ok_Callback);
button_cancel = uicontrol('Parent', f, 'Style', 'pushbutton', 'String', 'Cancel', 'Position', [160, 10, 70, 30], 'Callback', @button_cancel_Callback);

movegui(f, 'center');

uiwait();

    function button_ok_Callback(hObject, eventdata, handles)
        uiresume(f);
        delete(f);
    end

    function button_cancel_Callback(hObject, eventdata, handles)
        uiresume(f);
        delete(f);
    end
end