function [output] = par_estimation_gaussian(input_class)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
mu = sum(input_class,'all')/numel(input_class);
x = (input_class - mu).^2;
sigma = sum(x,'all')/numel(input_class);
output = normpdf(input_class,mu,sigma);
end

