clc; clear all; close all

%% Data handling
sigma_w  = load('Dataset/T3_data_sigma_w.mat').w;
sigma_s  = load('Dataset/T3_data_sigma_s.mat').s_t;

[K, one]    = size(sigma_w);

%% Estimate
sigma_w_sq_hat  = sum(abs(sigma_w).^2)/K;
sigma_s_sq_hat  = sum(abs(sigma_s).^2)/K;

x           = 0:0.01:100;
num_samples = 20;
doF         = 2*num_samples;
chi_sq      = pdf('Chisquare', x, doF)';

chi_sq_h0   = (sigma_w_sq_hat/2)*chi_sq;
chi_sq_h1   = ((sigma_w_sq_hat+sigma_s_sq_hat)/2)*chi_sq;


%% Figures
figure(1);
title('$Something about \chi^2$', 'Interpreter', 'latex');
hold on
plot(x, chi_sq_h0, 'Linewidth', 1);
hold on
plot(x, chi_sq_h1, '--', 'Linewidth', 1);
hold on
grid on;
hold on;
legend('P(T(\textbf{x}$|H_0$)', 'P(T(\textbf{x}$|H_1$)', 'Interpreter', 'latex');
hold off
