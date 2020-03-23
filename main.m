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
%4.1 and 4.2
grid_min = min(min(min(classA_part4, classB_part4)));
grid_max = max(max(max(classA_part4, classB_part4)));
global_min_AB = floor(grid_min)-1;
global_max_AB = ceil(grid_max)+1;
x = global_min_AB:1:global_max_AB;
[X, Y] = ndgrid(x); 
[Z1, err1] = sequential_classifier(X, Y, 0);
[Z2, err2] = sequential_classifier(X, Y, 0);
[Z3, err3] = sequential_classifier(X, Y, 0);
figure(11);
scatter(classA_part4(:,1), classA_part4(:,2));
hold on;
scatter(classB_part4(:,1),classB_part4(:,2));
hold on;
for i=1:size(Z1,3)
    contour(X,Y,Z1(:,:,i),1, 'k');
end
title('Sequential Classifier 1');
legend('Class A','Class B');
xlabel('x1');
ylabel('x2');
figure(12);
scatter(classA_part4(:,1), classA_part4(:,2));
hold on;
scatter(classB_part4(:,1),classB_part4(:,2));
hold on;
for i=1:size(Z2,3)
    contour(X,Y,Z2(:,:,i),1, 'k');
end
title('Sequential Classifier 2');
legend('Class A','Class B');
xlabel('x1');
ylabel('x2');
figure(13);
scatter(classA_part4(:,1), classA_part4(:,2));
hold on;
scatter(classB_part4(:,1),classB_part4(:,2));
hold on;
for i=1:size(Z3,3)
    contour(X,Y,Z3(:,:,i),1, 'k');
end
title('Sequential Classifier 3');
legend('Class A','Class B');
xlabel('x1');
ylabel('x2');
%4.3
figure(14)
[min, max, avg, std] = sequential_error_analysis(X, Y);
scatter(min(:,1), min(:,2), 'r');
hold on;
scatter(max(:,1), max(:,2), 'b');
hold on;
scatter(avg(:,1), avg(:,2), 'g');
hold on;
scatter(std(:,1), std(:,2), 'm');
hold on;
p1 = polyfit(min(:,1), min(:,2),3);
p2 = polyfit(max(:,1), max(:,2),3);
p3 = polyfit(avg(:,1), avg(:,2),3);
p4 = polyfit(std(:,1), std(:,2),3);
x_axis = linspace(1,5);

y1 = polyval(p1, x_axis);
y2 = polyval(p2, x_axis);
y3 = polyval(p3, x_axis);
y4 = polyval(p4, x_axis);
plot(x_axis, y1, 'r');
hold on;
plot(x_axis, y2, 'b');
hold on;
plot(x_axis, y3, 'g');
hold on;
plot(x_axis, y4, 'm');
hold on;
title('Error rates as a function of J');
legend('min','max','avg', 'stdev');
xlabel('j');
ylabel('error rate');
