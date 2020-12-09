function [Ratio] = Perimeter(image)

image1 = uint8(squeeze(image));
I_bw = imbinarize(image1);

% [B,L] = bwboundaries(I_bw);

stats = regionprops(I_bw,'Perimeter','Area','Centroid');
% stats2 = regionprops(I_bw,'Area');
% stats3 = regionprops(I_bw,'Centroid');

CC1 = stats.Perimeter;
CC2 = stats.Area;
CC3 = stats.Centroid;

Perimeter = CC1(1);
Area      = CC2(1);
% Centroid  = CC3(1);

Ratio = Perimeter^2 / (4*pi*Area);

end