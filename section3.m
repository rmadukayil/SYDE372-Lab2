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

%% FOR PARAMETRIC ESTIMATION
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
figure(1);
hold on;
scatter(Atest(:,1), Atest(:,2));
scatter(Btest(:,1), Btest(:,2));
scatter(Ctest(:,1), Ctest(:,2));
contour(x1,y1,parametric_grid,'color', 'r');
hold off;

%% FOR NON-PARAMETRIC ESTIMATION
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
figure(2);
hold on;
contour(X, Y, nonparam_grid, 'color', 'r');
scatter(Atest(:, 1), Atest(:, 2));
scatter(Btest(:, 1), Btest(:, 2));
scatter(Ctest(:, 1), Ctest(:, 2));
hold off;