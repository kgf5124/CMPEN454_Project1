function outarray = apply_maxpool(inarray)
[inH, inW, inD] = size(inarray);
outH = inH / 2;
outW = inW / 2;
outarray = zeros(outH, outW, inD);

for d = 1:inD
    for i = 1:outH
        for j = 1:outW
            patch = inarray(2*i-1:2*i, 2*j-1:2*j, d);
            outarray(i,j,d) = max(patch(:));
        end
    end
end
end