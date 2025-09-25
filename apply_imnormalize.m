function outarray = apply_imnormalize(inarray)
% Normalize input image from uint8 [0,255] to double [-0.5,0.5]
outarray = double(inarray)/255.0 - 0.5;
end