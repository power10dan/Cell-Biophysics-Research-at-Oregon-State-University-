Correlation Image Analysis
====================================================
## What is this?
This is an image detection program that allows users to detect lines on images. This program uses pattern recognition and
template matching to detect lines on images. 
## How to run this project?
First, download the file from Github using gitclone https://github.com/power10dan/Cell-Biophysics-Research-at-Oregon-State-University-.git. Then, open MATLAB, right click on Correlation_V2.fig and click on "Open in Guide". Then, click the play button and you are ready to go! :) 
## How is this program different from other image analysis tools such as OpenCV?
Conventional image detection software are not sensitive to images with high noise density unless the noise on the images have been removed or filtered by an image noise filter. One example of an image noise filter is a Gaussian noise filter. However, filters can be computationally costly. Some filters can remove details on images. Our method can detect lines on images with high noise density without the need to apply noise filters on images. Additionally, our  algorithm is much simpler compared to other template matching algorithms in OpenCV .  
## The Algorithm
We provide two types of corrlelation analysis: Whole Image and Sub-window Correlation Analysis The first flow chart is the Sub-window Analysis and the second type is the Whole Image Analysis. 
<p align="center">
  <img src="https://github.com/power10dan/Cell-Biophysics-Research-at-Oregon-State-University-/blob/master/readme_images/sub_window.png" alt="sub_window.png"/>
</p>
<p align="center">
  <img src="https://github.com/power10dan/Cell-Biophysics-Research-at-Oregon-State-University-/blob/master/readme_images/correlation_analysis.png" alt="orrelation_analysis.pn"/>
</p>
## Sample Analysis Results
Below is an image with 10 lines on it. The image has a Gaussian noise variance of 0.2. The image below is the output of our algorithm. The red lines represent the lines on  the original raw imag and the green lines represent lines that are detected by our algorithm. We emphasize that we did not use any noise filters to remove noise from the image. 
<p align="center">
<a href="url"><img src="https://github.com/power10dan/Cell-Biophysics-Research-at-Oregon-State-University-/blob/master/readme_images/10_lines.png" height="400" width="450" ></a>
</p>
<p align="center">
  <img src="https://github.com/power10dan/Cell-Biophysics-Research-at-Oregon-State-University-/blob/master/readme_images/line_img_detected.png" alt="10_lines_result"/>
</p>

Below is the image analysis result for a real collagen image. A1 and B1 represents the original collagen image and A2 and B2 represents the lines our image analysis program detected. The green lines represent the lines detected by our program.
<p align="center">
<a href="url"><img src="https://github.com/power10dan/Cell-Biophysics-Research-at-Oregon-State-University-/blob/master/readme_images/sub_window_collagen.png" height="400" width="450" ></a>
</p>

## License
The content of this project and all its source code is licensed under the Creative Commons Attribution 3.0 license. Daniel Lin and the CellBiophysics Lab at Oregon State University owns all rights to this project. 









