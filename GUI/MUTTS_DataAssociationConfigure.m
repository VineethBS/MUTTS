function data_association_parameters = MUTTS_DataAssociationConfigure

data_association_type = 'GNN';
data_association_parameters = 0;

addpath PG/
addpath ../

% Initialize JIDE's usage within Matlab
com.mathworks.mwswing.MJUtilities.initJIDE;

% Prepare the properties list for N out of M
list = java.util.ArrayList();

jpdaprop1 = com.jidesoft.grid.DefaultProperty();
jpdaprop1.setName('jpda_detectionprobability');
jpdaprop1.setType(javaclass('double'));
jpdaprop1.setValue(0.99);
jpdaprop1.setCategory('JPDA');
jpdaprop1.setDisplayName('JPDA detection probability');
jpdaprop1.setEditable(true);
list.add(jpdaprop1);

jpdaprop2 = com.jidesoft.grid.DefaultProperty();
jpdaprop2.setName('jpda_far');
jpdaprop2.setType(javaclass('double'));
jpdaprop2.setValue(0.01);
jpdaprop2.setCategory('JPDA');
jpdaprop2.setDisplayName('JPDA False alarm rate');
jpdaprop2.setEditable(true);
list.add(jpdaprop2);

% Prepare a properties table containing the list
model = com.jidesoft.grid.PropertyTableModel(list);
model.expandAll();
grid = com.jidesoft.grid.PropertyTable(model);
pane = com.jidesoft.grid.PropertyPane(grid);

% Set up the main figure
f = figure;
set(f, 'ToolBar', 'none', 'MenuBar', 'none', 'Name', 'Configure data association parameters');
set(f, 'numbertitle', 'off', 'Position', [0, 0, 300, 490], 'Resize', 'off');
panel = uipanel(f);

% Add to the main figure
choice = uibuttongroup('Parent', panel, 'Title', 'Choose data association method');
gnn_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Global Nearest Neighbours', 'Position', [2, 430, 250, 30]);
jpda_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Joint Probabilistic Data Association', 'Position', [2, 400, 250, 30]);
heuristic_choice = uicontrol('Parent', choice, 'Style', 'radiobutton', 'String', 'Heuristic Data Association', 'Position', [2, 370, 250, 30]);

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