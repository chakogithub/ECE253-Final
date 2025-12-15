function [im1, im2] = adjustSize(im1, im2)
    sz1 = size(im1);
    sz2 = size(im2);

    if sz2(1) < sz1(1)
        im2 = padarray(im2, [floor((sz1(1) - sz2(1)) / 2), 0, 0], 'replicate', 'both');
        im2 = padarray(im2, [mod(sz1(1) - sz2(1), 2), 0, 0], 'replicate', 'post');
    else
        im2 = im2(floor((sz2(1) - sz1(1)) / 2) + 1:sz2(1) - floor((sz2(1) - sz1(1)) / 2), :, :);
        im2 = im2(1:end - mod(sz2(1) - sz1(1), 2), :, :);
    end

    if sz2(2) < sz1(2)
        im2 = padarray(im2, [0, floor((sz1(2) - sz2(2)) / 2), 0], 'replicate', 'both');
        im2 = padarray(im2, [0, mod(sz1(2) - sz2(2), 2), 0], 'replicate', 'post');
    else
        im2 = im2(:, floor((sz2(2) - sz1(2)) / 2) + 1:sz2(2) - floor((sz2(2) - sz1(2)) / 2), :);
        im2 = im2(:, 1:end - mod(sz2(2) - sz1(2), 2), :);
    end