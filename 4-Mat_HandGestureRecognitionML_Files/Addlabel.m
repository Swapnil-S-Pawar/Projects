clc;
clear all;
close all;

% Prompt the user to select multiple Excel files
[fileNames, filePaths] = uigetfile('*.xlsx', 'Select Excel files', 'MultiSelect', 'on');

% Check if the selected files are stored as a cell array, if not convert it to a cell array
if ~iscell(fileNames)
    fileNames = {fileNames};
end

% Prompt the user to enter the data for the Label column
userInput = input('Enter numeric data for the "Label" column: ');

% Loop through each selected file
for i = 1:length(fileNames)
    % Get the file name and path
    fileName = fileNames{i};
    filePath = filePaths;
    if iscell(filePaths)
        filePath = filePaths{i};
    end
    
    % Read the Excel file
    data = readtable(fullfile(filePath, fileName));
    
    % Get the last filled row of the EMG2 column
    lastRow = find(~isnan(data.EMG2), 1, 'last');
    
    % Fill the Label column with the user input until the last filled row of EMG2
    data.Label(1:lastRow) = num2cell(userInput);
    
    % Write the modified data back to the Excel file
    writetable(data, fullfile(filePath, fileName), 'Sheet', 1, 'Range', 'A1');
    
end
