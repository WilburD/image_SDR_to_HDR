%∆¿º€÷∏±Í
addpath quality
raw = imread('D:\MATLAB\HDR\BIMEF\dataset\01.jpg');
enhanceResult = imread('D:\MATLAB\HDR\BIMEF\dataset\01_out.png');
loe100x100(raw,enhanceResult)
vif(enhanceResult,enhanceResult)