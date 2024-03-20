% Read the Excel file
filename = 'RawDataMerged_WithoutT.xlsx';
data = readtable(filename);

% Extract EMG1, EMG2, and label columns
emg1 = data.EMG1;
emg2 = data.EMG2;
labels = data.Label;

% Calculate the number of 10-reading intervals
numIntervals = floor(height(data) / 1500);

% Initialize arrays for RMS, variance, standard deviation, and most occurring label
rmsValues = zeros(numIntervals, 2);
varValues = zeros(numIntervals, 2);
stdValues = zeros(numIntervals, 2);
mostOccurringLabels = zeros(numIntervals, 1);

% Process each 10-reading interval
for i = 1:numIntervals
    % Get the current interval data
    startIndex = (i - 1) * 1500 + 1;
    endIndex = i * 1500;
    intervalEmg1 = emg1(startIndex:endIndex);
    intervalEmg2 = emg2(startIndex:endIndex);
    intervalLabels = labels(startIndex:endIndex);
    
    % Calculate RMS for EMG1 and EMG2
    rmsValues(i, 1) = rms(intervalEmg1);
    rmsValues(i, 2) = rms(intervalEmg2);
    
    % Calculate variance for EMG1 and EMG2
    varValues(i, 1) = var(intervalEmg1);
    varValues(i, 2) = var(intervalEmg2);
    
    % Calculate standard deviation for EMG1 and EMG2
    stdValues(i, 1) = std(intervalEmg1);
    stdValues(i, 2) = std(intervalEmg2);
    
    % Find the most occurring label
    % resultLabels(i) = mode(intervalLabels);
    % uniqueLabels = unique(intervalLabels);
    % countLabels = histc(intervalLabels, uniqueLabels);
    % [~, maxIndex] = max(countLabels);
    mostOccurringLabels(i) = mode(intervalLabels);
end

% Create a table with the calculated values
resultsTable = table(rmsValues(:, 1), rmsValues(:, 2), ...
    varValues(:, 1), varValues(:, 2), ...
    stdValues(:, 1), stdValues(:, 2), ...
    mostOccurringLabels, ...
    'VariableNames', {'RMS_EMG1', 'RMS_EMG2', ...
    'Variance_EMG1', 'Variance_EMG2', ...
    'StdDev_EMG1', 'StdDev_EMG2', 'Label'});

% Write the table to a new Excel file
resultsFilename = 'RawDataMerged_WithoutT_1500Chunks_R_V_SD.xlsx';
writetable(resultsTable, resultsFilename);
disp('Results have been generated');
