close all; clc


%% Load data
x_h0        = load('Dataset/T3_data_x_H0.mat').T3_data_x_H0; % x=w
x_h1        = load('Dataset/T3_data_x_H1.mat').T3_data_x_H1; % x=w+s

sigma_w_sq  = load('Dataset/T3_data_sigma_w.mat').w;
sigma_s_sq  = load('Dataset/T3_data_sigma_s.mat').s_t;

[N, ones]   = size(x_h0); 

%% Estimate the variances sigma_w_sq and sigma_s_sq
sigma_w_sq_hat  = sum(abs(sigma_w_sq))/N;
sigma_s_sq_hat  = sum(abs(sigma_s_sq))/N;


%% Calculate the histogram for our data
chi_sq_h0   = zeros(N, 1);
chi_sq_h1   = zeros(N, 1);

for i = 1:N
    chi_sq_h0(i) = 2*abs(x_h0(i))^2/sigma_w_sq_hat;
    chi_sq_h1(i) = 2*abs(x_h1(i))^2/(sigma_s_sq_hat+sigma_w_sq_hat);
end



%% Generate an arbitrary chi-square random variable with two DoF

x           = 0:0.1:15;
doF         = 2;
chi_sq      = pdf('Chisquare', x, doF)'; 


figure(1);
title('Comparing $H_0$ with $\chi^2$', 'Interpreter', 'latex');
hold on
histogram(chi_sq_h0, 'Normalization', 'pdf');
hold on
plot(x, chi_sq, '--', 'Linewidth', 1);
hold on
grid on;
hold on;
legend('Histogram of $H_0$','$pdf of \chi^2$', 'Interpreter', 'latex');
hold off

figure(2);
title('Comparing $H_1$ with $\chi^2$', 'Interpreter', 'latex');
hold on
histogram(chi_sq_h1, 'Normalization', 'pdf');
hold on
plot(x, chi_sq, '--', 'Linewidth', 1);
hold on
grid on;
hold on;
legend('Histogram of $H_1$', 'pdf of $\chi^2$', 'Interpreter', 'latex');
hold off