#Hand Gesture Reconition System Using ML

This project contains below sections and the scripts and datasets used are explained sectionwised.

1: Data Acquisition:

a. EMG-Serial.ino :- This is a arduino program which will fetch the data from the 2 connected EMG sensors with the sampling rate of 200 samples/second and transmits that data to laptop over serial communication.
b. ReceiverClient_Main300.py :- This ia a python script which reads the data from the provided serial port (COM port) of laptop for 5 seconds and exports that data in an excel file with data columns Time, EMG1,EMG2.  

2: Data Processing: 

a. Addlabel.m and Merged.m scripts are used to label the data exported by above script and then merged into one single data set. Rfer RawDataMerged.xlsx file for reference.
b. F2.m, Feature_rms_v_sd.m, Freq.m are the matlab scripts used to calculate features by using existing merged dataset with window size of 1500. Please refer the Merged_Feature_dataset.xlsx file for the features.

3: Machine Learning Classification model:

MLClassification_Model_SD1Feature_93_1Acc.mat is the Machine learning model file in which we used most effective feature Standard Deviation of first EMG sensor where we got 93.1% accuracy bu using Tree classification algorithm.

*****************************************************************************************************************************************************************
