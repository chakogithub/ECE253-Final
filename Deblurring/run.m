img = imread('1_in.jpg');
KernelSize = 19;

[H, latent] = BlindDeblurring_MichaeliIrani_v1(img, KernelSize);

imwrite(uint8(latent), '1_michael.jpg');

imwrite(mat2gray(H), '1_kernel.jpg');

disp("save latent_output.jpg and estimated_kernel.jpg");
