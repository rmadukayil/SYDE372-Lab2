clear all;
close all;
clc;

% load data (2 column matrix)
data = load('lab2_2');
al = data.al;
bl = data.bl;
cl = data.cl;
at = data.at;
bt = data.bt;
ct = data.ct;

% calculate known parameters for each set
muA = mean(al);
covA = cov(al); % check for unbiased est
muB = mean(bl);
covB = cov(bl);
muC = mean(cl);
covC = cov(cl);

% mesh grid set-up
x_min = min([al(:,1); bl(:,1); cl(:,1)]); %adjust param later
y_min = min([al(:,2); bl(:,2); cl(:,2)]);
x_max = max([al(:,1); bl(:,1); cl(:,1)]);
y_max = max([al(:,2); bl(:,2); cl(:,2)]);

x_range = x_min-2:1:x_max+2;
y_range = y_min-2:1:y_max+2;

[x, y] = meshgrid(x_range, y_range);

% parametric estimation w/ ML
classAB_estimate = MLestimate(muA, covA, muB, covB, x, y);
classBC_estimate = MLestimate(muB, covB, muC, covC, x, y);
classAC_estimate = MLestimate(muA, covA, muC, covC, x, y);

result_grid = MLclassifier(x, y, classAB_estimate, classBC_estimate, classAC_estimate);

% plotting parametric est
figure;
hold on;
scatter(al(:,1), al(:,2));
scatter(bl(:,1), bl(:,2));
scatter(cl(:,1), cl(:,2));
contour(x,y,result_grid,'color', 'r');
hold off;

% non parametric estimation 
