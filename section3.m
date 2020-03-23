clear all;
close all;
clc;

% load data (2 column matrix)
data = load('lab2_2');
Alearn = data.al;
Blearn = data.bl;
Clearn = data.cl;
Atest = data.at;
Btest = data.bt;
Ctest = data.ct;

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

x_range = x_min-2:1:x_max+2;
y_range = y_min-2:1:y_max+2;

[x, y] = meshgrid(x_range, y_range);

% parametric estimation w/ ML
classAB = MLestimate(muA, covA, muB, covB, x, y);
classBC = MLestimate(muB, covB, muC, covC, x, y);
classAC = MLestimate(muA, covA, muC, covC, x, y);

parametric_grid = MLclassifier(x, y, classAB, classBC, classAC);

% plotting parametric estimate
figure(1);
hold on;
scatter(Atest(:,1), Atest(:,2));
scatter(Btest(:,1), Btest(:,2));
scatter(Ctest(:,1), Ctest(:,2));
contour(x,y,parametric_grid,'color', 'r');
hold off;

% set up for non parametric estimation 
val = 400;
mean = [val/2, val/2];
sigma = [val, 0; 0, val];
stepsize = 0.5; % adjust as needed
resolution = [stepsize, x_min, y_min, x_max, y_max]; % same for all classes

% gaussian window set-up
[X1,X2] = meshgrid(1:stepsize:val);
window = mvnpdf([X1(:) X2(:)], mean, sigma);
window = reshape(window,length(X2),length(X1));

% using given Parzen window function
[p_a, x_a, y_a] = parzen(Alearn, resolution, window);
[p_b, x_b, y_b] = parzen(Blearn, resolution, window);
[p_c, x_c, y_c] = parzen(Clearn, resolution, window);

% applying ML classification
classAB_nonparam = MLparzen(p_a, p_b, x, y);
classBC_nonparam = MLparzen(p_b, p_c, x, y);
classAC_nonparam = MLparzen(p_a, p_c, x, y);

nonparam_grid = MLclassifier(x, y, classAB_nonparam, classBC_nonparam, classAC_nonparam);

% plotting non-parametric estimate
figure(2);
hold on;
scatter(Atest(:,1), Atest(:,2));
scatter(Btest(:,1), Btest(:,2));
scatter(Ctest(:,1), Ctest(:,2));
contour(x,y,nonparam_grid,'color', 'r');
hold off;

