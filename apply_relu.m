function outarray = apply_relu(inarray)
% APPLY_RELU  Elementwise ReLU activation
% Input:
%   inarray  - Input array (any size)
% Output:
%   outarray - Same size as input, with negative values set to 0

outarray = max(inarray, 0);
end
