%startup
% 测试所有颜色空间下，“暗光区域增量”+“过曝光区域降光”双重功能下的结果，保存在allColor文件夹下。
% allColor文件夹中，P（或Q属于输入图片的名字）。其他图的名字含义是:图片名_颜色空间_操作.后缀。
% 其中操作包括Dark(过曝光区域降光)  Light(暗光区域增量)    Light_Dark(“暗光区域增量”+“过曝光区域降光”)
addpath ours;
addpath colorspace;

cs = {'YCbCr','JPEG-YCbCr','YDbDr','YPbPr','YUV','YIQ','HSV','HSL','HSI','Lab','Luv','LCH',};% 'XYZ','CAT02 LMS','RGB'
idx= {  1,        1,          1,     1,     1,    1,     3,    3,    3,    1,    1,    1,  };%   0   ,    0   ,    0

file = 'allColor\Q';%修改输入图片的路径
I = imread( [file,'.jpg'] ); %修改输入图片的后缀


for ii = 1:numel(cs)
    %根据其他颜色空间 的 亮度分量 变暗
    J = im2double(I);
    name = cs{ii};
    ch = idx{ii};
    %name = 'HSV';
    %ch = 3;
    fprintf('\n   %d name = %s\n',ii, name);
    
    hsvJ = colorspace(['RGB->',name],J);
    %hsvJ = rgb2hsv(J);
    V = hsvJ(:,:,ch);
    V2 = TooDark(V,0.5);
    hsvJ(:,:,ch) = real(V2);
    J = colorspace([name,'->RGB'],hsvJ);
    %J = hsv2rgb(hsvJ);
    imwrite(J, [file,'_',name,'_Dark.jpg'] );

    %根据RGB中的RGB变亮%可以注释
    %K = TooLight(I,0.5);
    %imwrite(K, [file,'_out_Light.jpg'] );
    %J = (J+K)/2.0;

    %根据RGB中的RGB变亮
    [K,W] = TooLight(I,0.5);
    imwrite(K, [file,'_',name,'_Light.jpg'] );

    J = J.*W+K.*(1-W);
    subplot 321; imshow(J); title('J');
    subplot 322; imshow(K); title('K');
    subplot 323; imshow(W); title('W');
    subplot 324; imshow(J.*W); title('J.*W');
    subplot 325; imshow(1-W); title('1-W'); 
    subplot 326; imshow(K.*(1-W)); title('K.*(1-W)');
    imwrite(J, [file,'_',name,'_Light_Dark.jpg'] );
    fprintf('\n');
end


subplot 121; imshow(I); title('原始图');
subplot 122; imshow(J); title('处理后'); 