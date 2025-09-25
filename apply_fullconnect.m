function outarray = apply_fullconnect(inarray, filterbank, biasvals)
[N, M, D1] = size(inarray);
[~, ~, ~, D2] = size(filterbank);

outarray = zeros(1, 1, D2);

for d2 = 1:D2
    filter = filterbank(:,:,:,d2);
    dotprod = sum(sum(sum(inarray .* filter)));
    outarray(1,1,d2) = dotprod + biasvals(d2);
end
end
