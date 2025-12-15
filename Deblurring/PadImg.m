function PaddedImg = PadImg(img, PadMargin)

    if length(PadMargin) == 1
        PadMargin = [PadMargin, PadMargin];
    end

    cl = class(img);
    PaddedImg = [img(1, 1) * ones(PadMargin, cl), repmat(img(1, :), [PadMargin(1), 1]), img(1, end) * ones(PadMargin, cl);
                                                           repmat(img(:, 1), [1, PadMargin(2)]), img, repmat(img(:, end), [1, PadMargin(2)]);
                                                           img(end, 1) * ones(PadMargin, cl), repmat(img(end, :), [PadMargin(1), 1]), img(end, end) * ones(PadMargin, cl)];

