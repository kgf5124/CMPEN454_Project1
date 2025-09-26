% Load network parameters & data
load('CNNparameters.mat');
load('cifar10testdata.mat');

% Pick one sample image (32x32x3 RGB)
imrgb = imageset(:,:,:,1);
input = imrgb; % A 32x32x3 image

% Forward pass on single image
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



% ================================
% Run on full CIFAR-10 test set
% ================================
numClasses = numel(classlabels);
A = zeros(numClasses, numClasses); % confusion matrix

for n = 1:size(imageset,4)
    input = imageset(:,:,:,n);

    % Forward pass through CNN
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
    end

    % Prediction vs truth
    [~, predClass] = max(squeeze(input));
    trueClass = testlabels(n);
    A(trueClass, predClass) = A(trueClass, predClass) + 1;
end

% Compute accuracy
accuracy = sum(diag(A)) / sum(A(:));
fprintf('Overall test accuracy = %.2f%%\n', accuracy*100);

% Show confusion matrix
figure; imagesc(A); colorbar;
title('Confusion Matrix for CIFAR-10 Test Set');
xlabel('Predicted Class'); ylabel('True Class');
set(gca, 'XTick', 1:numClasses, 'XTickLabel', classlabels, ...
         'YTick', 1:numClasses, 'YTickLabel', classlabels, ...
         'XTickLabelRotation', 45);
