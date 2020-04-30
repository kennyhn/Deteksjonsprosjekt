clc; clear all; close all;

%% Load data
signal  = load(['Dataset/T8_numerical'...
    '_experiment.mat']).T8_numerical_experiment;

%% Statistics data
sigma_w_sq  = 1;
sigma_s_sq  = 5;

%alpha_0     = 0.1;  % Choose maxlimit p_FA = 0.1
alpha_0     = 0.01; % Choose maxlimit p_FA = 0.01

%beta_0      = 0.98; % choose minlimit p_D = 0.99
beta_0      = 0.99; % choose minlimit p_D = 0.98

K           = round(((norminv(alpha_0)*sigma_w_sq-...
    norminv(beta_0)*(sigma_w_sq+sigma_s_sq))/sigma_s_sq)^2);

signal      = signal(:,randi([1, 100], [K, 1]));

[N, K]      = size(signal);
T_x         = sum(abs(signal).^2, 2);

%% Detector
% Calculate the threshold
mu_h0           = K*sigma_w_sq;
sigma_h0        = sqrt(K)*sigma_w_sq;
lambda_prime    = norminv(1-alpha_0, mu_h0, sigma_h0);

disp(['The chosen threshold was lambda_prime: ' num2str(lambda_prime)]);
disp(['Here you get the test power beta: ' num2str(beta_0)]);
disp(['Here you get the false alarm rate alpha: ' num2str(alpha_0)]);
disp(['Number of samples used for test statistic: ' num2str(K)]);
% With this threshold, at which timesteps has PUs
results         = gt(T_x, lambda_prime);
disp(['Of ' num2str(N) ' timesteps, in '...
    num2str(nnz(results>0))... 
    ' of them, PU was detected']);