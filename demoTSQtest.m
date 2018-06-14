%评价指标
addpath quality
raw = imread('D:\MATLAB\HDR\BIMEF\dataset\01.jpg'); %输入图像
enhanceResult = imread('D:\MATLAB\HDR\BIMEF\dataset\01_out.png'); %增强结果图
loe100x100(raw,enhanceResult)
vif(enhanceResult,enhanceResult)