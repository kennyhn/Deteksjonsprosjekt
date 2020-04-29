clc; clear all; close all;

%% Data handling
sigma_w  = load(['Dataset/' ...
    'T3_data_sigma_w.mat']).w;
sigma_s  = load(['Dataset/'...
    'T3_data_sigma_s.mat']).s_t;

[K, one]    = size(sigma_w);

%% Estimate the variances sigma_w_sq and sigma_s_sq
sigma_w_sq_hat  = sum(abs(sigma_w).^2)/K;
sigma_s_sq_hat  = sum(abs(sigma_s).^2)/K;

%% Calculating p_D and p_FA
lambda_prime    = (0:0.1:10000);

mu_h0           = K*sigma_w_sq_hat;
sigma_h0        = K*sigma_w_sq_hat^2;
p_fa            = 1 - normcdf(lambda_prime,...
    mu_h0, sigma_h0);

mu_h1           = K*(sigma_w_sq_hat+sigma_s_sq_hat);
sigma_h1        = K*(sigma_w_sq_hat+sigma_s_sq_hat)^2;
p_d             = 1 - normcdf(lambda_prime,...
    mu_h1, sigma_h1);


figure(1);
title('$p_{FA}$ and $p_D$ as function of $\lambda''$',...
    'Interpreter', 'latex', 'fontsize', 22);
hold on
plot(lambda_prime, p_fa, 'Linewidth', 1);
hold on
plot(lambda_prime, p_d, '--', 'Linewidth', 1);
hold on
grid on;
hold on
legend('$p_{FA}(\lambda'')$','$p_D(\lambda'')$',...
    'Interpreter', 'latex', 'fontsize', 18);
hold on
xlabel('$\lambda''$',...
    'Interpreter', 'latex', 'fontsize', 14);
ylabel('$p(\lambda'')$',...
    'Interpreter', 'latex', 'fontsize', 14);
hold off
