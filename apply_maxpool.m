function outarray = apply_maxpool(inarray)

% APPLY_MAXPOOL  2x2 max pooling with stride 2
%
% Input:
%   inarray  - Input feature map, size H x W x D
% Output:
%   outarray - Pooled output, size (H/2) x (W/2) x D

[inH, inW, inD] = size(inarray);
outH = inH / 2;
outW = inW / 2;
outarray = zeros(outH, outW, inD);

for d = 1:inD
    for i = 1:outH
        for j = 1:outW
            % Take 2x2 patch and keep the maximum
            patch = inarray(2*i-1:2*i, 2*j-1:2*j, d);
            outarray(i,j,d) = max(patch(:));
        end
    end
end
end
