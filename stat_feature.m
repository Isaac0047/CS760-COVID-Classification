function [feature] = stat_feature(CVD)
mean_CVD=mean(CVD(:,:),'all') / 10;
var_CVD=std2(CVD(:,:));
med_CVD=median(CVD(:,:),'all');
max_CVD=max(max(CVD(:,:)));
min_CVD=min(min(CVD(:,:)));
range_CVD=max_CVD-min_CVD;
kur_CVD=kurtosis(CVD(:,:),1,'all');
ske_CVD=skewness(CVD(:,:),1,'all');
ent_CVD=entropy(CVD(:,:));
f = figure('visible','off'); %figure invisible
h = histogram(CVD(:,:),10);
counts = h.Values;
ene_CVD=sum((counts/255).^2)/1000;
RMS_CVD=sqrt(mean(CVD(:,:).^2,'all')); %Root Mean Square
feature=[mean_CVD var_CVD med_CVD min_CVD range_CVD ske_CVD kur_CVD ent_CVD ene_CVD RMS_CVD];
end