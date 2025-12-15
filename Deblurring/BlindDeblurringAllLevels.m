function [H, img1_rec] = BlindDeblurringAllLevels(img1, KernelSize)
    KernelSize = floor(KernelSize / 2) * 2 + 1;
    PatchSize = 5;
    sf = 0.75;
    NoiseSTD = 0.01 * 255;
    NumLevels = ceil(log(PatchSize / KernelSize) / log(sf));
    % limit
    MaxLevels = 2;
    NumLevels = min(NumLevels, MaxLevels);
    img1_pyr_i = imOrtResampSinc(img1, (1 / sf) ^ NumLevels, true);
    KernelSize_i = ceil(ceil(KernelSize * sf ^ NumLevels) / 2) * 2 + 1;
    NoiseSTD_i = NoiseSTD * sf ^ NumLevels;
    [H, img1_rec] = BlindDeblurringOneLevel(img1_pyr_i, KernelSize_i, [], [NoiseSTD_i, NoiseSTD_i], 3, ['level ', num2str(NumLevels)]);
    close all

    for i = NumLevels - 1: - 1:0
        img1_pyr_i = imOrtResampSinc(img1, (1 / sf) ^ i, true);
        KernelSize_i = floor(floor(KernelSize * sf ^ i) / 2) * 2 + 1;
        InitialGuess_i = imOrtResampSinc(img1_rec, sf, true);
        [img1_pyr_i, InitialGuess_i] = adjustSize(img1_pyr_i, InitialGuess_i);
        NoiseSTD_i = NoiseSTD * sf ^ i;
        [H, img1_rec] = BlindDeblurringOneLevel(img1_pyr_i, KernelSize_i, InitialGuess_i, [NoiseSTD_i, NoiseSTD_i], 3, ['level ', num2str(i)]);
        close all
    end