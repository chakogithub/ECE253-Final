function [HH, img1_rec] = BlindDeblurringOneLevel(img1, KernelSize, img1_rec_initialGuess, NoiseSTD, NumIter, TextForTitles)
    sf = 0.75;
    ShowResults = true;
    options. PatchSize = 5;
    options. NumNN = 1;
    options. VarThreshPercentDB = 1;
    options. sf = 1;
    options. NoiseSTD = 1;
    options. AddDegradedImgToDB = false;
    options. AddScaledDegradedImgToDB = false;
    options. sfDegradedImgInDB = 1 / sf;

    if size(img1, 3) == 3
        img1 = rgb2gray(uint8(img1));
    end

    img1 = double(img1);

    if ShowResults
        hf_img = figure;
    end

    if ~exist('NumIter', 'var')
        NumIter = floor(log(KernelSize) / log(1 / sf));
    end

    if length(NoiseSTD) == 1
        NoiseSTD = [NoiseSTD, NoiseSTD];
    end

    NoiseSTD = linspace(NoiseSTD(1), NoiseSTD(2), NumIter);
    KernelSize_i = KernelSize;

    if exist('img1_rec_initialGuess', 'var') && ~isempty(img1_rec_initialGuess)
        img1_rec = img1_rec_initialGuess;
    else
        img1_rec = img1;
    end

    HH = sys_id(double(img1_rec), double(img1), [KernelSize_i, KernelSize_i], 0, 0, ones(size(img1)), false);
    HH = HH / sum(HH(:));

    if ShowResults
        figure(hf_img)
        subplot(1, 2, 1)
        imshow(imresize(HH, 10, 'nearest'), [])
        subplot(1, 2, 2)
        imshow(img1_rec, [0, 255])
    end

    for i = 1:NumIter

        if i >= NumIter * 0.5
            threshold = true;
        else
            threshold = false;
        end

        img1_rec_small = imOrtResampSinc(img1_rec, (1 / sf), true);

        switch i
            case 1
                NumIterInternal = 2;
            case 2
                NumIterInternal = 1;
            otherwise
                NumIterInternal = 1;
        end

        for j = 1:NumIterInternal
            img1_rec = debluringPatchRec(img1, HH, {img1_rec_small}, NoiseSTD(i), img1_rec);
            HH = sys_id(double(img1_rec), double(img1), [KernelSize_i, KernelSize_i], 0, 0, ones(size(img1)), threshold);
            HH = HH / sum(HH(:));

            if ShowResults
                figure(hf_img)
                subplot(1, 2, 1)
                imshow(HH, []), title(['Recovered Kernel, iteration ', num2str(i), ', ', TextForTitles]), drawnow
                subplot(1, 2, 2)
                imshow(img1_rec, [0, 255]), title(['Recovered Image, iteration ', num2str(i), ', ', TextForTitles]), drawnow
            end

        end

    end