function [img_new] = denoiseExtTreeCANN(img1, DB_images, PatchSize)

    if (size(img1, 3) == 1)
        GrayFlag = true;
    else
        GrayFlag = false;
    end

    if GrayFlag
        img1 = repmat(img1, [1, 1, 3]);
        img1(:, :, 2:3) = 0;
    end

    if (size(DB_images{1}, 3) == 1)
        DB_images{1} = repmat(DB_images{1}, [1, 1, 3]);
        DB_images{1}(:, :, 2:3) = 0;
    end

    DB_images_concat = DB_images{1};

    for i = 1:1
        DB_images{i} = imOrtResampSinc(DB_images{1}, 1/0.75 ^ (i - 1), true);
        [nnf_dist, nnf_X{i}, nnf_Y{i}, runtime] = run_TreeCANN(uint8(img1), uint8(DB_images{i}), PatchSize(1), 1, 1);
        weights{i} = exp(- double(nnf_dist(1:end - PatchSize(1), 1:end - PatchSize(1))) / (2 * PatchSize(1) ^ 2 * 20 ^ 2));
    end

    img_new = ind2imAvg(img1, DB_images, nnf_X, nnf_Y, weights, PatchSize);

    if GrayFlag
        img_new = img_new(:, :, 1);
    end