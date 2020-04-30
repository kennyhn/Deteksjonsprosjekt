clc; close all; clear all;


%% Confirm that our data is iid and normal gaussian 
S_k_gauss         = load(['Dataset/'...
    'T1_data_Sk_Gaussian.mat']).T1_data_Sk_Gaussian;
S_k_bpsk          = load(['Dataset/'...
    'T1_data_Sk_BPSK.mat']).T1_data_Sk_BPSK';

[N, one]        = size(S_k_gauss);

% The formula given is basically a fourier transform
s_gauss             = fft(S_k_gauss);
s_bpsk              = fft(S_k_bpsk);

s_gauss_real        = real(s_gauss);
s_gauss_imag        = imag(s_gauss);

s_bpsk_real         = real(s_bpsk);
s_bpsk_imag         = imag(s_bpsk);


%% Estimate the expected values
sr_expected_gauss           = sum(s_gauss_real)/N;  
si_expected_gauss           = sum(s_gauss_imag)/N;
s_expected_gauss            = sr_expected_gauss +...
    1i*si_expected_gauss;


sr_expected_bpsk            = sum(s_bpsk_real)/N;  
si_expected_bpsk            = sum(s_bpsk_imag)/N;
s_expected_bpsk             = sr_expected_bpsk +...
    1i*si_expected_bpsk;

% When samples are taken uniformly from the same population with any
% distribution the expected value of the mean is always unbiased
product_s_expected_gauss    = ...
    sum(s_gauss_real.*s_gauss_imag)/N;
product_s_expected_bpsk     = ...
    sum(s_bpsk_real.*s_bpsk_imag)/N;

disp(['The expected value of s_n' ...
    ' with gaussian samples: '...
    num2str(s_expected_gauss)]);


disp(['The expected value of s_n'...
    ' with bpsk samples: '...
    num2str(s_expected_bpsk)]);

disp(['The expected value of product'...
    ' of real and imaginary part' ...
    ' with gaussian samples: '...
    num2str(product_s_expected_gauss)]);

disp(['The expected value of product'...
    ' of real and imaginary part' ...
    ' with bpsk samples: '...
    num2str(product_s_expected_bpsk)]);

%% Gaussian Create a generic complex point distribution
sigma_s_sq      = 980;

px_r            = makedist('Normal', 'mu',...
    0, 'sigma', sqrt(sigma_s_sq/2));
px_i            = makedist('Normal', 'mu',...
    0, 'sigma', sqrt(sigma_s_sq/2));

x = (-80:0.1:80)';


%% Plot histograms of the sampled data Gaussian
figure(1);
title('Real gaussian', 'fontsize', 22);
hold on
histogram(s_gauss_real, 'Normalization', 'pdf');
hold on
plot(x, px_r.pdf(x), '--', 'Linewidth', 1)
hold on
xlabel('x', 'Interpreter', 'latex', 'fontsize', 14);
hold on
ylabel('p(x)', 'Interpreter', 'latex', 'fontsize', 14);
hold on
grid on;
legend('histogram', 'true pdf, $\sigma^2 = 980$',...
    'Interpreter', 'latex', 'fontsize', 18);
hold off;

figure(2);
title('Imaginary gaussian', 'fontsize', 22);
hold on
histogram(s_gauss_imag, 'Normalization', 'pdf');
hold on
plot(x, px_i.pdf(x), '--', 'Linewidth', 1)
hold on
xlabel('x', 'Interpreter', 'latex', 'fontsize', 14);
hold on
ylabel('p(x)', 'Interpreter', 'latex', 'fontsize', 14);
hold on
grid on;
legend('histogram', 'true pdf, $\sigma^2 = 980$',...
    'Interpreter', 'latex', 'fontsize', 18);
hold off;

%% BPSK Create a generic complex point distribution

sigma_s_sq      = 800;

px_r            = makedist('Normal', 'mu', 0,...
    'sigma', sqrt(sigma_s_sq/2));
px_i            = makedist('Normal', 'mu', 0,...
    'sigma', sqrt(sigma_s_sq/2));

x = (-80:0.1:80)';

figure(3);
title('Real BPSK', 'fontsize', 22);
hold on
histogram(s_bpsk_real, 'Normalization', 'pdf');
hold on
plot(x, px_r.pdf(x), '--', 'Linewidth', 1)
hold on
xlabel('x', 'Interpreter', 'latex', 'fontsize', 14);
hold on
ylabel('p(x)', 'Interpreter', 'latex', 'fontsize', 14);
hold on
grid on;
legend('histogram', 'true pdf, $\sigma^2 = 800$',...
    'Interpreter', 'latex', 'fontsize', 18);
hold off;

figure(4);
title('Imaginary BPSK', 'fontsize', 22);
hold on
histogram(s_bpsk_real, 'Normalization', 'pdf');
hold on
plot(x, px_i.pdf(x), '--', 'Linewidth', 1)
hold on
xlabel('x', 'Interpreter', 'latex', 'fontsize', 14);
hold on
ylabel('p(x)', 'Interpreter', 'latex', 'fontsize', 14);
hold on
grid on;
legend('histogram', 'true pdf, $\sigma^2 = 800$',...
    'Interpreter', 'latex', 'fontsize', 18);
hold off;


