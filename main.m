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

%% PART 3
data = load('lab2_2');
Alearn = data.al;
Blearn = data.bl;
Clearn = data.cl;
Atest = data.at;
Btest = data.bt;
Ctest = data.ct;

% FOR PARAMETRIC ESTIMATION
% calculate known parameters for each set
muA = mean(Alearn);
covA = cov(Alearn); % check for unbiased est
muB = mean(Blearn);
covB = cov(Blearn);
muC = mean(Clearn);
covC = cov(Clearn);

% mesh grid set-up
x_min = min([Alearn(:,1); Blearn(:,1); Clearn(:,1)]); %adjust param later
y_min = min([Alearn(:,2); Blearn(:,2); Clearn(:,2)]);
x_max = max([Alearn(:,1); Blearn(:,1); Clearn(:,1)]);
y_max = max([Alearn(:,2); Blearn(:,2); Clearn(:,2)]);

x_range1 = x_min-2:1:x_max+2;
y_range1 = y_min-2:1:y_max+2;

[x1, y1] = meshgrid(x_range1, y_range1);

% parametric estimation w/ ML
classAB = MLestimate(muA, covA, muB, covB, x1, y1);
classBC = MLestimate(muB, covB, muC, covC, x1, y1);
classAC = MLestimate(muA, covA, muC, covC, x1, y1);

parametric_grid = MLclassifier(x1, y1, classAB, classBC, classAC);

% plotting parametric estimate
figure(11);
hold on;
title('Parametric Estimation for 2D Case');
xlabel('x1');
ylabel('x2');
sz = 20;
scatter(Atest(:, 1), Atest(:, 2), sz, 'filled');
scatter(Btest(:, 1), Btest(:, 2), sz, 'filled');
scatter(Ctest(:, 1), Ctest(:, 2), sz, 'filled');
contour(x1,y1,parametric_grid,'color', 'black');
legend('Class A', 'Class B', 'Class C', 'ML Decision Boundary');
hold off;

% FOR NON-PARAMETRIC ESTIMATION
% given parameters 
mean = [200 200];
covariance = [400 0; 0 400];
stepsize = 1; %adjust

% setting up meshgrid, window
[x2, y2] = meshgrid(0:1:400);
pzn_win = mvnpdf([x2(:) y2(:)], mean, covariance);
pzn_win = reshape(pzn_win,length(y2),length(x2));
resolution = [stepsize x_min y_min x_max  y_max];

% non-parametric estimate using given Parzen window code
[p_a, x_a, y_a] = parzen(Alearn, resolution, pzn_win);
[p_b, x_b, y_b] = parzen(Blearn, resolution, pzn_win);
[p_c, x_c, y_c] = parzen(Clearn, resolution, pzn_win);

% adjusting meshgrid size
[X, Y] = meshgrid(x_a, y_a);

nonparam_grid = MLparzen(p_a, p_b, p_c, X, Y);

% plotting non-parametric estimate
figure(12);
hold on;
title('Non-Parametric Estimation with ML Classification Boundaries');
legend('Class A','Class B','Class C');
xlabel('x1');
ylabel('x2');
title('Non-Parametric Estimation for 2D Case');
sz = 20;
scatter(Atest(:, 1), Atest(:, 2), sz, 'filled');
scatter(Btest(:, 1), Btest(:, 2), sz, 'filled');
scatter(Ctest(:, 1), Ctest(:, 2), sz, 'filled');
contour(X, Y, nonparam_grid, 'color', 'black');
legend('Class A', 'Class B', 'Class C', 'ML Decision Boundary');
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
figure(13);
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
figure(14);
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
figure(15);
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
figure(16)
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
