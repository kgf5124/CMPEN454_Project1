function outarray = apply_softmax(inarray)
alpha = max(inarray(:));
exps = exp(inarray - alpha);
sum_exps = sum(exps(:));
outarray = exps / sum_exps;
end
