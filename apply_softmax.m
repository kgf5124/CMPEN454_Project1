function outarray = apply_softmax(inarray)
% APPLY_SOFTMAX  Compute softmax over input array
% Input:
%   inarray  - Vector or array of scores
% Output:
%   outarray - Same shape as input, values in [0,1] that sum to 1

% Note: Uses max-subtraction (alpha) for numerical stability.

alpha = max(inarray(:));
exps = exp(inarray - alpha);
sum_exps = sum(exps(:));
outarray = exps / sum_exps;
end
