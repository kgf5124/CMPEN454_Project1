function outarray = apply_fullconnect(inarray, filterbank, biasvals)

% APPLY_FULLCONNECT  Fully connected (dense) layer operation
 
% Inputs:
%   inarray    - N x M x D1 input array (flattened feature maps)
%   filterbank - N x M x D1 x D2 weights (one filter per output neuron)
%   biasvals   - 1 x D2 vector of biases (one per output neuron)
%
% Output:
%   outarray   - 1 x 1 x D2 output vector (neuron activations)

% Get dimensions of input and number of output neurons

[N, M, D1] = size(inarray);
[~, ~, ~, D2] = size(filterbank);

% Initialize output vector
outarray = zeros(1, 1, D2);

% Compute weighted sum for each output neuron
for d2 = 1:D2
    
    % Extract weights for this neuron
    filter = filterbank(:,:,:,d2);

    % Compute dot product between input and weights
    dotprod = sum(sum(sum(inarray .* filter)));

    % Add bias term and store in output
    outarray(1,1,d2) = dotprod + biasvals(d2);
end
end
