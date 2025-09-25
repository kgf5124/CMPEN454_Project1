load('CNNparameters.mat');
load('cifar10testdata.mat');
imrgb = imageset(:,:,:,1);
input = imrgb; % A 32x32x3 image

for layer = 1:18
    type = layertypes{layer};
    switch type
        case 'imnormalize'
            input = apply_imnormalize(input);
        case 'convolve'
            input = apply_convolve(input, filterbanks{layer}, biasvectors{layer});
        case 'relu'
            input = apply_relu(input);
        case 'maxpool'
            input = apply_maxpool(input);
        case 'fullconnect'
            input = apply_fullconnect(input, filterbanks{layer}, biasvectors{layer});
        case 'softmax'
            input = apply_softmax(input);
    end
    layerOutputs{layer} = input; % store for debugging
end

% Show classification result
probs = squeeze(layerOutputs{18});
[maxprob, maxclass] = max(probs);
fprintf('Predicted class: %s with probability %.2f\n', classlabels{maxclass}, maxprob);
