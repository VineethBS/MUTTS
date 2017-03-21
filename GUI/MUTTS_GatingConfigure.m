function gate_parameters = MUTTS_GatingConfigure

gating_method_type = 'Rectangular';
gating_method_parameters.gate_width = 10;

addpath PG/
addpath ../

% Initialize JIDE's usage within Matlab
com.mathworks.mwswing.MJUtilities.initJIDE;

% Prepare the properties list for N out of M
list = java.util.ArrayList();

rectprop = com.jidesoft.grid.DefaultProperty();
rectprop.setName('rect_gatewidth');
rectprop.setType(javaclass('double'));
rectprop.setValue(2);
rectprop.setCategory('Rectangular Gating');
rectprop.setDisplayName('Gate width');
rectprop.setEditable(true);
list.add(rectprop);

sphericalprop = com.jidesoft.grid.DefaultProperty();
sphericalprop.setName('spherical_gateradius');
sphericalprop.setType(javaclass('double'));
sphericalprop.setValue(10);
sphericalprop.setCategory('Spherical Gating');
sphericalprop.setDisplayName('Gate radius');
sphericalprop.setEditable(true);
list.add(sphericalprop);

% Prepare a properties table containing the list
model = com.jidesoft.grid.PropertyTableModel(list);
model.expandAll();
grid = com.jidesoft.grid.PropertyTable(model);
pane = com.jidesoft.grid.PropertyPane(grid);

% Set up the main figure
f = figure;
set(f, 'ToolBar', 'none', 'MenuBar', 'none', 'Name', 'Configure gating parameters');
set(f, 'numbertitle', 'off', 'Position', [0, 0, 300, 490], 'Resize', 'off');
panel = uipanel(f);

% Add to the main figure
choice = uibuttongroup('Parent', panel, 'Title', 'Choose gating method type');
rectangular_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Rectangular gating', 'Position', [2, 430, 120, 30]);
spherical_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Spherical gating', 'Position', [2, 400, 200, 30]);
ellipsoidal_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Ellipsoidal gating', 'Position', [2, 370, 200, 30]);

[~, h] = javacomponent(pane, [0, 50, 300, 300], panel);
button_ok = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Ok', 'Position', [90, 10, 70, 30], 'Callback', @button_ok_Callback);
button_cancel = uicontrol('Parent', panel, 'Style', 'pushbutton', 'String', 'Cancel', 'Position', [160, 10, 70, 30], 'Callback', @button_cancel_Callback);

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