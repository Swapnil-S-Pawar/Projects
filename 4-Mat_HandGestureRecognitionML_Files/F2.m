% Read input Excel file
inputFile = 'RawDataMerged.xlsx';
data = readmatrix(inputFile);

% Extract sensor readings and labels
sensorReadings = data(:, 2:3);
labels = data(:, 4);
% Parameters
windowSize = 1500;
overlap = 0;
% Calculate number of intervals
numIntervals = floor(size(sensorReadings, 1) / windowSize);

% Initialize output variables
skewnessValues = zeros(numIntervals, 2);
kurtosisValues = zeros(numIntervals, 2);
iemgValues = zeros(numIntervals, 2);
mavValues = zeros(numIntervals, 2);
outputLabels = zeros(numIntervals, 1);

% Calculate skewness, kurtosis, integrated EMG, and mean absolute value for every 10 readings
for i = 1:numIntervals

    startIdx = 1 + (i - 1) * windowSize * (1 - overlap);
    endIdx = startIdx + windowSize - 1;
    
    % Calculate skewness
    skewnessValues(i, 1) = skewness(sensorReadings(startIdx:endIdx, 1));
    skewnessValues(i, 2) = skewness(sensorReadings(startIdx:endIdx, 2));
    
    % Calculate kurtosis
    kurtosisValues(i, 1) = kurtosis(sensorReadings(startIdx:endIdx, 1));
    kurtosisValues(i, 2) = kurtosis(sensorReadings(startIdx:endIdx, 2));
    
    % Calculate integrated EMG
    iemgValues(i, 1) = sum(abs(sensorReadings(startIdx:endIdx, 1)));
    iemgValues(i, 2) = sum(abs(sensorReadings(startIdx:endIdx, 2)));
    
    % Calculate mean absolute value
    mavValues(i, 1) = mean(abs(sensorReadings(startIdx:endIdx, 1)));
    mavValues(i, 2) = mean(abs(sensorReadings(startIdx:endIdx, 2)));
    
    % Calculate the most occurring label in the window
    outputLabels(i) = mode(labels(startIdx:endIdx));
end

% Create output data matrix
outputData = [skewnessValues, kurtosisValues, iemgValues, mavValues, outputLabels];

% Create output Excel file
outputFile = 'RawDataMerged1500chunkFeature.xlsx';
xlswrite(outputFile, {'SK1', 'SK2', 'K1', 'K2', 'IEMG1', 'IEMG2', 'MAV1', 'MAV2', 'Label'}, 'Sheet1', 'A1');
xlswrite(outputFile, outputData, 'Sheet1', 'A2');
