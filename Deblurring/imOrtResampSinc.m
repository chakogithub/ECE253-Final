function [c_2, m_new, n_new] = imOrtResampSinc(c_1, R, pad)
    [M, N, K] = size(c_1);

    if nargin <= 2
        pad = false;
    end

    if pad
        PadMargin = 30;

        for i = 1:K
            c_1_pad(:, :, i) = PadImg(c_1(:, :, i), PadMargin);
        end

    else
        PadMargin = 0;
    end

    c_1 = double(c_1_pad);
    [m, m_new] = meshgrid(1 - PadMargin:M + PadMargin, 1 - PadMargin:R:M + PadMargin);
    [n, n_new] = meshgrid(1 - PadMargin:N + PadMargin, 1 - PadMargin:R:N + PadMargin);
    RR = max(R, 1 / R);
    H_n = (1 / RR) * sinc((n_new - n) / RR);
    H_m = (1 / RR) * sinc((m_new - m) / RR);

    for i = 1:K
        c_2(:, :, i) = H_m * c_1(:, :, i) * H_n';
    end

    if pad
        margin = round(PadMargin / R);
        c_2 = c_2(margin + 1:end - margin, margin + 1:end - margin, :);
        n_new = n_new(margin + 1:end - margin, 1);
        m_new = m_new(margin + 1:end - margin, 1);
    end