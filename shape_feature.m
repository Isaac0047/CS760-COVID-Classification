function feature = shape_feature(image)

image1 = uint8(squeeze(image));
I_bw = imbinarize(image1);

[B,L] = bwboundaries(I_bw);

% figure
% imshow(I_bw);

% hold on
% for k =1:length(B)
%     boundary = B{k};
%     plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
% end

ratio = sum(sum(I_bw==1)) / 200 / 200;

feature = [ratio];

close all

end
