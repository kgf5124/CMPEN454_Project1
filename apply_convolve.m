function outarray = apply_convolve(inarray, filterbank, biasvals)
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
