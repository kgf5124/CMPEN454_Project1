function outarray = apply_convolve(inarray, filterbank, biasvals)
% APPLY_CONVOLVE  Perform convolution of input feature maps with a filter bank
%
% Inputs:
%   inarray    - N x M x D1 input array (image or previous layer feature maps)
%   filterbank - h x w x D1 x D2 filters (h,w kernel size, D1 input depth, D2 output depth)
%   biasvals   - 1 x D2 vector of bias values (one per output channel)
%
% Output:
%   outarray   - N x M x D2 output array (feature maps after convolution)

[N, M, D1] = size(inarray);
[~, ~, ~, D2] = size(filterbank);
outarray = zeros(N, M, D2);

for d2 = 1:D2
    out_channel = zeros(N, M);
    for d1 = 1:D1
        filter = filterbank(:,:,d1,d2);
        in_channel = inarray(:,:,d1);
        out_channel = out_channel + imfilter(in_channel, filter, 'conv', 'same', 'replicate');
    end
    outarray(:,:,d2) = out_channel + biasvals(d2);
end
end
