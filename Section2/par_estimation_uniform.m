function [output] = par_estimation_uniform(input_class)
a = min(input_class);
b = max(input_class);
output = unifpdf(input_class,a,b);
end