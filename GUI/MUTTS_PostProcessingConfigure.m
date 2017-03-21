function postprocessing_parameters = MUTTS_PostProcessingConfigure

postprocessing_parameters.atleastN_parameters.N = 10;
postprocessing_parameters.velocity_threshold_parameters.velocity_threshold = 10;
postprocessing_parameters.velocity_threshold_parameters.direction = 'more';

addpath PG/
addpath ../

% Initialize JIDE's usage within Matlab
com.mathworks.mwswing.MJUtilities.initJIDE;

% Prepare the properties list
list = java.util.ArrayList();
prop1 = com.jidesoft.grid.DefaultProperty();
prop1.setName('num_associations');
prop1.setType(javaclass('int32'));
prop1.setValue(10);
prop1.setCategory('At least N detections');
prop1.setDisplayName('Total number of associations');
prop1.setEditable(true);
list.add(prop1);

prop2 = com.jidesoft.grid.DefaultProperty();
prop2.setName('velocity_threshold');
prop2.setType(javaclass('double'));
prop2.setValue(10);
prop2.setCategory('Velocity Threshold');
prop2.setDisplayName('Velocity Threshold');
prop2.setEditable(true);
list.add(prop2);

prop3 = com.jidesoft.grid.DefaultProperty();
prop3.setName('direction_for_check');
prop3.setType(javaclass('char', 10));
prop3.setValue('less');
prop3.setCategory('Velocity Threshold');
prop3.setDisplayName('Direction for check');
prop3.setEditable(true);
list.add(prop3);

% Prepare a properties table containing the list
model = com.jidesoft.grid.PropertyTableModel(list);
model.expandAll();
grid = com.jidesoft.grid.PropertyTable(model);
pane = com.jidesoft.grid.PropertyPane(grid);

% Set up the main figure
f = figure;
set(f, 'ToolBar', 'none', 'MenuBar', 'none', 'Name', 'Configure track post processing parameters');
set(f, 'numbertitle', 'off', 'Position', [0, 0, 300, 350], 'Resize', 'off');
panel = uipanel(f);
% Add to the main figure
[~, h] = javacomponent(pane, [0, 50, 300, 300], panel);

button_ok = uicontrol('Style', 'pushbutton', 'String', 'Ok', 'Position', [90, 10, 70, 30], 'Callback', @button_ok_Callback);
button_cancel = uicontrol('Style', 'pushbutton', 'String', 'Cancel', 'Position', [160, 10, 70, 30], 'Callback', @button_cancel_Callback);

movegui(f, 'center');

uiwait();

    function button_ok_Callback(hObject, eventdata, handles)
        postprocessing_parameters.atleastN_parameters.N = prop1.getValue();
        postprocessing_parameters.velocity_threshold_parameters.velocity_threshold = prop2.getValue();
        postprocessing_parameters.velocity_threshold_parameters.direction = prop3.getValue();
        uiresume(f);
        delete(f);
    end

    function button_cancel_Callback(hObject, eventdata, handles)
        uiresume(f);
        delete(f);
    end
end