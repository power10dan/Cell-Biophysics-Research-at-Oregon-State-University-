Correlation Image Analysis
====================================================
## What is this?
This is an image detection program that allows users to detect lines on images. This program uses pattern recognition and
template matching to detect lines on images. 
## How is this program different from other image analysis tools such as OpenCV?
Conventional image detection software are not sensitive to images with high noise density unless the noise on the images have been removed or filtered by an image noise filter. One example of an image noise filter is a Gaussian noise filter. However, filters can be computationally costly. Some filters can remove details on images. Our method can detect lines on images with high noise density without the need to apply noise filters on images. Additionally, our  algorithm is much simpler compared to other template matching algorithms in OpenCV .  
## The Algorithm
We provide two types of corrlelation analysis: Whole Image and Sub-window Correlation Analysis The first flow chart is the Sub-window Analysis and the second type is the Whole Image Analysis. 
![sub_window.png](https://github.com/power10dan/Cell-Biophysics-Research-at-Oregon-State-University-/blob/master/readme_images/sub_window.png)

![correlation_analysis.png](https://github.com/power10dan/Cell-Biophysics-Research-at-Oregon-State-University-/blob/master/readme_images/correlation_analysis.png)








