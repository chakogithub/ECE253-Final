function [H, img_deblurred] = BlindDeblurring_MichaeliIrani_v1(img, KernelSize)

KernelSize = floor(KernelSize/2)*2+1;
if max(img(:))<=1
    img = double(img) * 255;
end

if size(img,3) == 3
    img = rgb2gray(uint8(img));
end
img = double(img);

% Perform blind deblurring
 [H, img_deblurred] = BlindDeblurringAllLevels(img, KernelSize);