clc;
clear all;
close all;

% Prompt the user to select multiple Excel files
[fileNames, filePaths] = uigetfile('*.xlsx', 'Select Excel files', 'MultiSelect', 'on');

% Check if the selected files are stored as a cell array, if not convert it to a cell array
if ~iscell(fileNames)
    fileNames = {fileNames};
end

% Create a new Excel file to store the merged data
mergedFileName = 'MergedFile.xlsx';
mergedFilePath = uigetdir('', 'Select a folder to save the merged file');
mergedFile = fullfile(mergedFilePath, mergedFileName);

% Initialize a cell array to store the merged data
mergedData = cell(0);

% Loop through each selected file
for i = 1:length(fileNames)
    % Get the file name and path
    fileName = fileNames{i};
    filePath = filePaths;
    if iscell(filePaths)
        filePath = filePaths{i};
    end
    
    % Read the Excel file
    [~, ~, rawData] = xlsread(fullfile(filePath, fileName));
    
    % Delete the first row
   % rawData(1, :) = [];
    
    % Append the data to the mergedData cell array
    mergedData = [mergedData; rawData];
end

% Write the merged data to the new Excel file
xlswrite(mergedFile, mergedData);

disp('Merged file created successfully!');
disp(['File saved at: ' mergedFile]);
