function feature = text_feature(image)

image1 = uint8(squeeze(image));
com = graycomatrix(image1);
com = com / max(max(com));

%% Energy
Energy = sumsqr(com);

%% Contrast
Contrast = 0;

for i=1:length(com(1,:))
    for j=1:length(com(:,1))       
        Contrast = Contrast + (i-j)^2*com(i,j);     
    end
end

%% Correlation
mu_x = 0;
mu_y = 0;
sigma_x = 0;
sigma_y = 0;
Correlation = 0;

for i = 1:length(com(1,:))
    for j = 1:length(com(:,1))
        mu_x = mu_x + i*com(i,j);
        mu_y = mu_y + j*com(i,j);
    end
end

for i = 1:length(com(1,:))
    for j = 1:length(com(:,1))
        sigma_x = sigma_x + (i-mu_x)^2 * com(i,j);
        sigma_y = sigma_y + (j-mu_y)^2 * com(i,j);
    end
end

for i = 1:length(com(1,:))
    for j = 1:length(com(:,1))
        Correlation = Correlation + (i*j*com(i,j)-mu_x*mu_y)/(sqrt(sigma_x*sigma_y) + 10^-10);
    end
end

%% Entropy
Entropy = 0;

for i = 1:length(com(1,:))
    for j = 1:length(com(:,1))
        Entropy = Entropy - com(i,j)*log2(com(i,j)+10^-10);
    end
end

%% Ni Cha Fen Ju
NF = 0;

for i = 1:length(com(1,:))
    for j = 1:length(com(:,1))
        NF = NF + com(i,j)/(1+(i-j)^2);
    end
end

%% Homogeneity
Homogeneity = 0;

for i = 1:length(com(1,:))
    for j = 1:length(com(:,1))
        Homogeneity = Homogeneity + com(i,j)/(1+abs(i-j));
    end
end

%% Sum Average
SA = 0;

%% Assembly

feature = [Energy Contrast Correlation Entropy NF Homogeneity];

end