clear all;
close all;
clc;

% load data (2 column matrix)
data = load('lab2_2');
setA = data.al;
setB = data.bl;
setC = data.cl;

% calculate known parameters for each set
muA = mean(setA);
covA = cov(setA); % check for unbiased est
nA = length(setA);
muB = mean(setB);
covB = cov(setB);
nB = length(setB);
muC = mean(setC);
covC = cov(setC);
nC = length(setC);

% mesh grid set-up
x_min = min([setA(:,1); setB(:,1); setC(:,1)]); %adjust param later
y_min = min([setA(:,2); setB(:,2); setC(:,2)]);
x_max = max([setA(:,2); setB(:,2); setC(:,2)]);
y_max = max([setA(:,2); setB(:,2); setC(:,2)]);

x_range = x_min:1:x_max;
y_range = y_min:1:y_max;

[x, y] = meshgrid(x_range, y_range);

% parametric estimation w/ ML
classAB_estimate = MLestimate(muA, covA, muB, covB, x, y);
classBC_estimate = MLestimate(muB, covB, muC, covC, x, y);
classAC_estimate = MLestimate(muA, covA, muC, covC, x, y);

result_grid = MLclassifier(x, y, classAB_estimate, classBC_estimate, classAC_estimate);

% non parametric estimation 
