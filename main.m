clear all;
close all;

global classA classB 
global classA_part2 classB_part2 classA_part2_mean classA_part2_sd classB_part2_mean
classA = load('lab2_3','a');
classB = load('lab2_3', 'b');
classA_part2 = load('lab2_1','a');
classB_part2 = load('lab2_1', 'b');
classA_part2_mean = 5;
classA_part2_sd = 1;
classB_part2_mean = 1;

% PART 2 - Model Estimation in 1D Case
classA_part2 = sort(classA_part2.a);
classB_part2 = sort(classB_part2.b);
Real_PDF_classA = normpdf(classA_part2,classA_part2_mean,classA_part2_sd);
Real_PDF_classB = exppdf(classB_part2,classB_part2_mean);

%PART 2: Plot parametric estimation - gaussian
Gaussian_Est_classA = par_estimation_gaussian(classA_part2);
Gaussian_Est_classB = par_estimation_gaussian(classB_part2);

figure(1);
plot(classA_part2,Real_PDF_classA, 'r');
hold on;
plot(classA_part2,Gaussian_Est_classA, 'b');
title('Class A - Gaussian Parametric Estimation');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Gaussian');
hold off;

figure(2);
plot(classB_part2,Real_PDF_classB, 'r');
hold on;
plot(classB_part2,Gaussian_Est_classB, 'b');
title('Class B - Gaussian Parametric Estimation');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Gaussian');
%
%PART 2: Plot parametric estimation - exponential
Exponential_Est_classA = par_estimation_expo(classA_part2);
Exponential_Est_classB = par_estimation_expo(classB_part2);

figure(3);
plot(classA_part2,Real_PDF_classA, 'r');
hold on;
plot(classA_part2,Exponential_Est_classA, 'b');
title('Class A - Exponential Parametric Estimation');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Exponential');
hold off;

figure(4);
plot(classB_part2,Real_PDF_classB, 'r');
hold on;
plot(classB_part2,Exponential_Est_classB, 'b');
title('Class B - Exponential Parametric Estimation');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Exponential');

%
%PART 2: Plot parametric estimation - uniform
Uniform_Est_classA = par_estimation_uniform(classA_part2);
Uniform_Est_classB = par_estimation_uniform(classB_part2);

figure(5);
plot(classA_part2,Real_PDF_classA, 'r');
hold on;
plot(classA_part2,Uniform_Est_classA, 'b');
title('Class A - Uniform Parametric Estimation');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Uniform');
hold off;

figure(6);
plot(classB_part2,Real_PDF_classB, 'r');
hold on;
plot(classB_part2,Uniform_Est_classB, 'b');
title('Class B - Uniform Parametric Estimation');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Uniform');

% PART 2: Non parametric Estimation Using Parzen Windows
[Non_Parametric_Est_classA_sd1,Non_Parametric_Est_classA_sd2] = non_par_estimation_parzen(classA_part2);
[Non_Parametric_Est_classB_sd1,Non_Parametric_Est_classB_sd2] = non_par_estimation_parzen(classB_part2);

figure(7);
plot(classA_part2,Real_PDF_classA, 'r');
hold on;
plot(classA_part2,Non_Parametric_Est_classA_sd1, 'b');
title('Class A - Non-Parametric Estimation with sd = 0.1');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Non-Parametric');
hold off;

figure(8);
plot(classA_part2,Real_PDF_classA, 'r');
hold on;
plot(classA_part2,Non_Parametric_Est_classA_sd2, 'b');
title('Class A - Non-Parametric Estimation with sd = 0.4');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Non-Parametric');
hold off;

figure(9);
plot(classB_part2,Real_PDF_classB, 'r');
hold on;
plot(classB_part2,Non_Parametric_Est_classB_sd1, 'b');
title('Class B - Non-Parametric Estimation with sd = 0.1');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Non-Parametric');
hold off;

figure(10);
plot(classB_part2,Real_PDF_classB, 'r');
hold on;
plot(classB_part2,Non_Parametric_Est_classB_sd2, 'b');
title('Class B - Non-Parametric Estimation with sd = 0.4');
xlabel('x');
ylabel('p(x)');
legend('True p(x)','Estimated p(x) - Non-Parametric');
hold off;
%%
% PART 4
global_min_AB = floor(min(min(arr_x_AB,arr_y_AB)))-1;
global_max_AB = ceil(max(max(arr_x_AB,arr_y_AB)))+1;
x = global_min_AB:0.1:global_max_AB;
[X1, Y1] = ndgrid(x); 