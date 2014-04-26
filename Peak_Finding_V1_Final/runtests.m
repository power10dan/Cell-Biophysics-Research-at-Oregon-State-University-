%change this to your own folder
outputfolder = 'C:\Users\Sungroup\Documents\MATLAB\Dan\Program_working\Software Package\Additional_Functionalities_Folder\Test_results_no_Noise';

testimage = zeros(120,100);
nhlines = 9;%left to right lines
nvlines = 4;%top to bottom lines
nplines = 2;%straight lines
[testimage,corr]=test_randlines(testimage, nhlines, nvlines,nplines,outputfolder);
