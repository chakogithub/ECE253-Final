function H = sys_id(img_in, img_out, size_ker, dm, dn, Conf, threshold)

    if ~exist('threshold', 'var')
        threshold = true;
    end

    if dm > 0
        img_out = img_out(1 + dm:end, :);
        img_in = img_in(1:end - dm, :);
        Conf = Conf(1:end - dm, :);
    else
        img_in = img_in(1 - dm:end, :);
        Conf = Conf(1 - dm:end, :);
        img_out = img_out(1:end + dm, :);
    end

    if dn > 0
        img_out = img_out(:, 1 + dn:end);
        img_in = img_in(:, 1:end - dn);
        Conf = Conf(:, 1:end - dn);
    else
        img_in = img_in(:, 1 - dn:end);
        Conf = Conf(:, 1 - dn:end);
        img_out = img_out(:, 1:end + dn);
    end

    margin = floor(size_ker / 2);
    img_in = img_in - mean(img_in(:));
    img_out = img_out - mean(img_out(:));
    Conf = Conf(margin(1) + 1:end - margin(1), margin(2) + 1:end - margin(2));
    img_out_cropped = img_out(margin(1) + 1:end - margin(1), margin(2) + 1:end - margin(2));
    hb = waitbar(0, 'Updating Kernel');
    d = filter2(img_out_cropped, img_in, 'valid');
    d = d(:);
    [jj, ii] = meshgrid(1:size_ker(2), 1:size_ker(1));
    dii = repmat(ii(:), [1, prod(size_ker)]) - repmat(ii(:)', [prod(size_ker), 1]);
    djj = repmat(jj(:), [1, prod(size_ker)]) - repmat(jj(:)', [prod(size_ker), 1]);
    C = zeros(prod(size_ker));

    for dj = 0:size_ker(2) - 1
        waitbar(dj / (size_ker(2) - 1), hb)

        for di =- size_ker(1) + 1:size_ker(1) - 1

            if dj == 0 && di < 0
                continue
            end

            if di >= 0
                tmp = cumsum(cumsum(img_in(1 + di:end, 1 + dj:end) .* img_in(1:end - di, 1:end - dj), 1), 2);
            else
                tmp = cumsum(cumsum(img_in(1:end + di, 1 + dj:end) .* img_in(- di + 1:end, 1:end - dj), 1), 2);
            end

            tmp = padarray(tmp, [1, 1], 0, 'pre');
            kth_diag = tmp(1:size_ker(1) - abs(di), 1:size_ker(2) - abs(dj)) + tmp(end - size_ker(1) + abs(di) + 1:end, end - size_ker(2) + abs(dj) + 1:end) - tmp(end - size_ker(1) + abs(di) + 1:end, 1:size_ker(2) - abs(dj)) - tmp(1:size_ker(1) - abs(di), end - size_ker(2) + abs(dj) + 1:end);
            ind = find(dii == di & djj == dj);
            C(ind) = C(ind) + kth_diag(:);
        end

    end

    C = C + C' - diag(diag(C));
    C = C / numel(img_out_cropped);
    d = d / numel(img_out_cropped);
    C = C + 7.5 ^ 2 * eye(size(C));

    if ~threshold
        H = C \ d;
    else
        H = quadprog(C, - d, [], [], [], [], zeros(prod(size_ker), 1), []);
    end

    H = H / sum(H(:));
    H = reshape(full(H), size_ker);
    close(hb)