function [output] = par_estimation_expo(input_class)
lambda = numel(input_class)/sum(input_class,'all');
mu = 1/lambda;
output = exppdf(input_class, mu);
end
