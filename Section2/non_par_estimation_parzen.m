function [output_sd1,output_sd2] = non_par_estimation_parzen(input_class)

sd1 = 0.1;
sd2 = 0.4;
output_sd1 = zeros(size(input_class));
output_sd2 = zeros(size(input_class));
for i=1:numel(input_class)
    output_sd1(i) = (1/numel(input_class))*(1/((2*pi).^0.5))*(1/sd1)*sum(exp((-0.5)*((input_class(i) - input_class)/sd1).^2),'all');
    output_sd2(i) = (1/numel(input_class))*(1/((2*pi).^0.5))*(1/sd2)*sum(exp((-0.5)*((input_class(i) - input_class)/sd2).^2),'all');
end

end

