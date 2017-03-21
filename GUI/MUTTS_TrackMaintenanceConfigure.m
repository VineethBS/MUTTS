function trackmaintenance_parameters = MUTTS_TrackMaintenanceConfigure

trackmaintenance_type = 'NOutOfM_FixedNumber';
trackmaintenance_parameters.N = 2;
trackmaintenance_parameters.M = 10;
trackmaintenance_parameters.confirm_threshold = 3;
trackmaintenance_parameters.confirm_N = 1;
trackmaintenance_parameters.confirm_M = 3;
trackmaintenance_parameters.max_number_of_tracks = 10;

addpath PG/
addpath ../

% Initialize JIDE's usage within Matlab
com.mathworks.mwswing.MJUtilities.initJIDE;

% Prepare the properties list for N out of M
list = java.util.ArrayList();

NoMprop1 = com.jidesoft.grid.DefaultProperty();
NoMprop1.setName('N');
NoMprop1.setType(javaclass('int32'));
NoMprop1.setValue(2);
NoMprop1.setCategory('N Out of M');
NoMprop1.setDisplayName('N');
NoMprop1.setEditable(true);
list.add(NoMprop1);

NoMprop2 = com.jidesoft.grid.DefaultProperty();
NoMprop2.setName('M');
NoMprop2.setType(javaclass('double'));
NoMprop2.setValue(10);
NoMprop2.setCategory('N Out of M');
NoMprop2.setDisplayName('M');
NoMprop2.setEditable(true);
list.add(NoMprop2);

NoMprop3 = com.jidesoft.grid.DefaultProperty();
NoMprop3.setName('confirm_threshold');
NoMprop3.setType(javaclass('int32'));
NoMprop3.setValue(5);
NoMprop3.setCategory('N Out of M');
NoMprop3.setDisplayName('Threshold for confirmation');
NoMprop3.setEditable(true);
list.add(NoMprop3);

NoMprop4 = com.jidesoft.grid.DefaultProperty();
NoMprop4.setName('confirm_N');
NoMprop4.setType(javaclass('int32'));
NoMprop4.setValue(1);
NoMprop4.setCategory('N Out of M');
NoMprop4.setDisplayName('N for confirmation');
NoMprop4.setEditable(true);
list.add(NoMprop4);

NoMprop5 = com.jidesoft.grid.DefaultProperty();
NoMprop5.setName('confirm_M');
NoMprop5.setType(javaclass('int32'));
NoMprop5.setValue(5);
NoMprop5.setCategory('N Out of M');
NoMprop5.setDisplayName('M for confirmation');
NoMprop5.setEditable(true);
list.add(NoMprop5);

NoMprop6 = com.jidesoft.grid.DefaultProperty();
NoMprop6.setName('max_number_active_tracks');
NoMprop6.setType(javaclass('int32'));
NoMprop6.setValue(10);
NoMprop6.setCategory('N Out of M - Limit Tracks');
NoMprop6.setDisplayName('Number of tracks');
NoMprop6.setEditable(true);
list.add(NoMprop6);


% Prepare a properties table containing the list
model = com.jidesoft.grid.PropertyTableModel(list);
model.expandAll();
grid = com.jidesoft.grid.PropertyTable(model);
pane = com.jidesoft.grid.PropertyPane(grid);

% Set up the main figure
f = figure;
set(f, 'ToolBar', 'none', 'MenuBar', 'none', 'Name', 'Configure track maintenance parameters');
set(f, 'numbertitle', 'off', 'Position', [0, 0, 300, 450], 'Resize', 'off');
panel = uipanel(f);

% Add to the main figure
choice = uibuttongroup('Parent', panel, 'Title', 'Choose track maintenance type');
NoM_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'N out of M', 'Position', [2, 400, 120, 30]);
NoM_limit_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'N out of M - Limit tracks', 'Position', [2, 370, 200, 30]);

[~, h] = javacomponent(pane, [0, 50, 300, 300], panel);
button_ok = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Ok', 'Position', [90, 10, 70, 30], 'Callback', @button_ok_Callback);
button_cancel = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Cancel', 'Position', [160, 10, 70, 30], 'Callback', @button_cancel_Callback);

movegui(f, 'center');

uiwait();

    function button_ok_Callback(hObject, eventdata, handles)
        trackmaintenance_parameters.N = NoMprop1.getValue();
        trackmaintenance_parameters.M = NoMprop2.getValue();
        trackmaintenance_parameters.confirm_threshold = NoMprop3.getValue();
        trackmaintenance_parameters.confirm_N = NoMprop4.getValue();
        trackmaintenance_parameters.confirm_M = NoMprop5.getValue();
        trackmaintenance_parameters.max_number_of_tracks = NoMprop6.getValue();
        uiresume(f);
        delete(f);
    end

    function button_cancel_Callback(hObject, eventdata, handles)
        uiresume(f);
        delete(f);
    end
end