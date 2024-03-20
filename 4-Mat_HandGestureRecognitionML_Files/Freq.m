% Read EMG data and labels from Excel file
[num, ~, raw] = xlsread('RawDataMerged_WithoutT.xlsx');
emg1 = num(:, 1);
emg2 = num(:, 2);
labels = num(:, 3);

% Parameters
windowSize = 1500;
overlap = 0;

% Preallocate result arrays
numWindows = floor((length(emg1) - windowSize) / (windowSize * (1 - overlap))) + 1;
psd1 = zeros(numWindows, 1);
psd2 = zeros(numWindows, 1);
entropy1 = zeros(numWindows, 1);
entropy2 = zeros(numWindows, 1);
medianFreq1 = zeros(numWindows, 1);
medianFreq2 = zeros(numWindows, 1);
resultLabels = zeros(numWindows, 1);

% Calculate features for each window
for i = 1:numWindows
    startIdx = 1 + (i - 1) * windowSize * (1 - overlap);
    endIdx = startIdx + windowSize - 1;
    
    % Extract windowed data
    window1 = emg1(startIdx:endIdx);
    window2 = emg2(startIdx:endIdx);
    windowLabels = labels(startIdx:endIdx);
    
    % Calculate features
    psd1(i) = bandpower(window1);
    psd2(i) = bandpower(window2);
    entropy1(i) = wentropy(window1, 'shannon');
    entropy2(i) = wentropy(window2, 'shannon');
    medianFreq1(i) = medfreq(window1);
    medianFreq2(i) = medfreq(window2);
    resultLabels(i) = mode(windowLabels);
end

% Create new Excel file and write results
outputData = [psd1, psd2, entropy1, entropy2, medianFreq1, medianFreq2, resultLabels];
columnTitles = {'PSD_EMG1', 'PSD_EMG2', 'Entropy_EMG1', 'Entropy_EMG2', 'MedianFreq_EMG1', 'MedianFreq_EMG2', 'Label'};
outputFile = ['RawDataMerged_WithoutT_1500chunkFreqFeature.xlsx'];
xlswrite(outputFile, columnTitles, 'Sheet1', 'A1');
xlswrite(outputFile, outputData, 'Sheet1', 'A2');

disp('Feature extraction complete. Results saved to feature_results.xlsx.');
