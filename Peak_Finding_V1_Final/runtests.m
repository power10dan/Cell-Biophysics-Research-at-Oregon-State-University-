%change this to your own folder
outputfolder = 'C:\Users\Sungroup\Documents\MATLAB\Dan\Program_working\Software Package\Additional_Functionalities_Folder\Test_results_no_Noise';

testimage = zeros(120,100);
nhlines = 3;%left to right lines
nvlines = 1;%top to bottom lines
nplines = 1;%straight lines
low_intensity = 0.2;
[testimage,corr]=test_randlines(testimage, nhlines, nvlines,nplines,outputfolder);
