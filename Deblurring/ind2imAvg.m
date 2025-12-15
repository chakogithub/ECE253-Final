function A = ind2imAvg(B, Ref, ind_X, ind_Y, weights, blockSize)
    M = blockSize(1);
    N = blockSize(2);
    K = size(B, 3);
    MM = size(B, 1);
    NN = size(B, 2);
    A = zeros(MM, NN, K);
    Count = zeros(MM, NN, K);

    for i = 1:length(Ref)

        for k = 1:K
            Ref_k = Ref{i}(:, :, k);

            for m = 1:M

                for n = 1:N
                    indRef = sub2ind([size(Ref{i}, 1), size(Ref{i}, 2)], max(min(ind_Y{i}(1:end - M, 1:end - N) + m - 1, size(Ref{i}, 1)), 1), max(min(ind_X{i}(1:end - M, 1:end - N) + n - 1, size(Ref{i}, 2)), 1));
                    A(m:m + MM - M - 1, n:n + NN - N - 1, k) = A(m:m + MM - M - 1, n:n + NN - N - 1, k) + Ref_k(indRef) .* weights{i};
                    Count(m:m + MM - M - 1, n:n + NN - N - 1, k) = Count(m:m + MM - M - 1, n:n + NN - N - 1, k) + weights{i};
                end

            end

        end

    end

    A = A ./ (Count + eps);