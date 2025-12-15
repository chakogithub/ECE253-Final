function x_hat = debluringPatchRec(y, PSF, DB, NoiseSTD, InitialGuess)
    options. PatchSize = 5;
    options. NumNN = 5;
    options. VarThreshPercentImg = 1;
    options. VarThreshPercentDB = 1;
    options. AddDegradedImgToDB = false;
    options. AddScaledDegradedImgToDB = false;
    options. NoiseSTD = 10;
    options. RegularizationFilter = {0};
    margin = size(PSF, 1) * 5;
    y = PadImg(y, margin);
    [M, N] = size(y);
    h = zeros(M, N);
    h(floor(M / 2) + 1 - floor(size(PSF, 1) / 2):floor(M / 2) + 1 + floor(size(PSF, 1) / 2), floor(N / 2) + 1 - floor(size(PSF, 2) / 2):floor(N / 2) + 1 + floor(size(PSF, 2) / 2)) = rot90(PSF, 2);
    H = fft2(ifftshift(h));
    Y = fft2(y);
    beta = 0.4;
    hf = figure('doublebuffer', 'on', 'position', [106, 182, 560, 420]);
    x_hat_cur = PadImg(InitialGuess, margin);
    hb = waitbar(0, 'Updating Image');

    for i = 1:15
        waitbar(i / 15, hb)
        X_hat_cur = fft2(x_hat_cur);
        X_hat_cur = (Y .* conj(H) + beta * X_hat_cur) ./ (abs(H) .^ 2 + beta);
        x_hat_cur = ifft2(X_hat_cur);
        figure(hf), subplot(1, 2, 1), imshow(x_hat_cur(margin + 1:end - margin, margin + 1:end - margin), [0, 255]), title(['Deblurring (x-phase), step ', num2str(i)])
        drawnow
        [x_hat_cur] = denoiseExtTreeCANN(x_hat_cur, DB, [options. PatchSize, options. PatchSize]);
        figure(hf), subplot(1, 2, 2), imshow(x_hat_cur(margin + 1:end - margin, margin + 1:end - margin), [0, 255]), title(['Deblurring (z-phase), step ', num2str(i)])
        drawnow
    end

    close(hf)
    close(hb)
    X_hat_cur = fft2(x_hat_cur);
    X_hat_cur = (Y .* conj(H) + beta * X_hat_cur) ./ (abs(H) .^ 2 + beta);
    x_hat_cur = ifft2(X_hat_cur);
    x_hat = x_hat_cur(margin + 1:end - margin, margin + 1:end - margin);