function [output] = par_estimation_expo(input_class)
lambda = sum(input_class,'all')/numel(input_class);
output = exppdf(input_class, lambda);
end