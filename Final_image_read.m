clear all
close all
clc

%% Load Image Files
path_non_CVD = 'C:\Users\Haoti\.spyder-py3\CS760_Final_Project\non-COVID-new-1';
path_CVD     = 'C:\Users\Haoti\.spyder-py3\CS760_Final_Project\COVID-new-1';

a  = dir([path_non_CVD '/*.png']);
out = size(a,1);
non_CVD = zeros(out, 200, 200);

b  = dir([path_CVD '/*.png']);
out1 = size(b,1);
CVD  = zeros(out1, 200, 200);

%% Change Image Files to Matrix
for i = 1:out    
    idx = num2str(i);
    non_CVD_image = strcat(path_non_CVD, '\Non-Covid (', idx, ').png');
    temp = imread(non_CVD_image);
    I = rgb2gray(temp);
    non_CVD(i,:,:) = I;
end

for j = 1:out1    
    idx = num2str(j);
    CVD_image = strcat(path_CVD, '\Covid (', idx, ').png');
    temp = imread(CVD_image);
    I = rgb2gray(temp);
    CVD(j,:,:) = I;
end


%% Assembly Dataset
X_CVD = squeeze(CVD);
X_non_CVD = squeeze(non_CVD);
X = cat(1, CVD, non_CVD);
Y = zeros(out+out1, 1);
Y(1:out1) = 1;

%% Assign Features

for i = 1:out+out1
    
    feature4(i,1) = Perimeter(X(i,:,:));
    
end

for i = 1:out+out1
    
    feature1 = stat_feature(X(i,:,:));
    feature2 = text_feature(X(i,:,:));
    feature3 = shape_feature(X(i,:,:));
    feature4 = Perimeter(X(i,:,:));
    Feature(i,:) = [feature1 feature2 feature3 feature4];

end

%% Calculate FFT Feature

fft   = fft2(X);
X_fft = abs(fftshift(fft));

for i = 1:out+out1
    
    feature1 = stat_feature(X_fft(i,:,:));
    Feature_stat(i,:) = [feature1];

end

%% Calculate wavelet feature
N = 1;

for i = 1:1
    
    X_target = squeeze(X(i,:,:));
    [c,s] = wavedec2(X_target,2,'haar');

%     Extract level 1 approximation and detailed coefficients
    [H1,V1,D1] = detcoef2('all',c,s,1);
    A1         = appcoef2(c,s,'haar',1);

%     Use wcodemat to resacle the coefficents based on absolute value
    V1img = wcodemat(V1,255,'mat',1);
    H1img = wcodemat(H1,255,'mat',1);
    D1img = wcodemat(D1,255,'mat',1);
    A1img = wcodemat(A1,255,'mat',1);

%     Extract level 2 approximation and detailed coefficients
    [H2,V2,D2] = detcoef2('all',c,s,2);
    A2         = appcoef2(c,s,'haar',2);

    V2img = wcodemat(V2,255,'mat',1);
    H2img = wcodemat(H2,255,'mat',1);
    D2img = wcodemat(D2,255,'mat',1);
    A2img = wcodemat(A2,255,'mat',1);
    
    feature11 = stat_feature(V1img);
    feature12 = stat_feature(H1img);
    feature13 = stat_feature(D1img);
    feature14 = stat_feature(A1img);
    
    feature21 = stat_feature(V2img);
    feature22 = stat_feature(H2img);
    feature23 = stat_feature(D2img);
    feature24 = stat_feature(A2img);
    
    Feature_wave1(i,:) = [feature11 feature12 feature13 feature14];
    Feature_wave22(N,:) = [feature21 feature22 feature23 feature24];
    N = N+1;

end

%% Temp code for fft
% 
% fft = fft2(X);
% X_fft = abs(fftshift(fft));
% image = X_fft(1,:,:);
% image = squeeze(image);
% image = uint8(image);
% imshow(image)