function [PC, SCORE, variances] = princomp(Y)
% 兼容老代码的 princomp，内部调用 pca

    % pca 默认行为与旧版 princomp 一致（每列为变量，每行为样本）
    [PC, SCORE, variances] = pca(Y);

end
