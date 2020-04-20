clc; close all;


%% Confirm that our data is iid and normal gaussian 
S_k_gauss         = load('Dataset/T1_data_Sk_Gaussian.mat').T1_data_Sk_Gaussian;
S_k_bpsk          = load('Dataset/T1_data_Sk_BPSK.mat').T1_data_Sk_BPSK';

[N, one]        = size(S_k_gauss);

%{
s_gauss         = zeros(N, 1);
s_bpsk          = zeros(N, 1);

%% Generate the signal s(n) using DFT
for n = 0:N-1
    for k = 0:N-1
        % Remember that matlab is 1-indexed
        sum_S_gauss = S_k_gauss(k+1)*exp(1i*2*pi*n*k/N);
        sum_S_bpsk  = S_k_bpsk(k+1)*exp(1i*2*pi*n*k/N);
    end
    
    %s(n) in time domain as given in project description
    s_gauss(n+1)    = sum_S_gauss/sqrt(N);
    s_bpsk(n+1)     = sum_S_bpsk/sqrt(N);
end
%}
s_gauss             = fft(S_k_gauss);
s_bpsk              = fft(S_k_bpsk);

s_gauss_real        = real(s_gauss);
s_gauss_imag        = imag(s_gauss);

s_bpsk_real         = real(s_bpsk);
s_bpsk_imag         = imag(s_bpsk);


%% Estimate the expected values
sr_expected_gauss           = sum(s_gauss_real)/N;  
si_expected_gauss           = sum(s_gauss_imag)/N;
s_expected_gauss            = sr_expected_gauss + 1i*si_expected_gauss;


sr_expected_bpsk            = sum(s_bpsk_real)/N;  
si_expected_bpsk            = sum(s_bpsk_imag)/N;
s_expected_bpsk             = sr_expected_bpsk + 1i*sr_expected_bpsk;

% When samples are taken uniformly from the same population with any
% distribution the expected value of the mean is always unbiased
product_s_expected_gauss    = sum(s_gauss_real.*s_gauss_imag)/N;
product_s_expected_bpsk     = sum(s_bpsk_real.*s_bpsk_imag)/N;

disp(['The expected value of s_n with gaussian samples: ' ...
    num2str(s_expected_gauss)]);


disp(['The expected value of s_n with bpsk samples: ' ...
    num2str(s_expected_bpsk)]);

disp(['The expected value of product of real and imaginary part' ...
    ' with gaussian samples: ' num2str(product_s_expected_gauss)]);

disp(['The expected value of product of real and imaginary part' ...
    ' with bpsk samples: ' num2str(product_s_expected_bpsk)]);

%% Gaussian Create a generic complex point distribution
sigma_s_sq      = 900; %10^(-5);

px_r            = makedist('Normal', 'mu', 0, 'sigma', sqrt(sigma_s_sq/2));
px_i            = makedist('Normal', 'mu', 0, 'sigma', sqrt(sigma_s_sq/2));

x = (-80:0.1:80)';%(-6*10^(-3):10^(-4):6*10^(-3))';

%figure(5);
%px              = px_r.pdf(x).*px_i.pdf(x);


%% Plot histograms of the sampled data Gaussian
figure(1);
title('Real gaussian');
hold on
histogram(s_gauss_real, 'Normalization', 'pdf');
hold on
plot(x, px_r.pdf(x), '--', 'Linewidth', 1)
hold on
grid on;
legend('histogram', 'true pdf');
hold off;

figure(2);
title('Imaginary gaussian');
hold on
histogram(s_gauss_imag, 'Normalization', 'pdf');
hold on
plot(x, px_i.pdf(x), '--', 'Linewidth', 1)
hold on
grid on;
legend('histogram', 'true pdf');
hold off;

%% BPSK Create a generic complex point distribution

sigma_s_sq      = 800; %5*10^(-4);

px_r            = makedist('Normal', 'mu', 0, 'sigma', sqrt(sigma_s_sq/2));
px_i            = makedist('Normal', 'mu', 0, 'sigma', sqrt(sigma_s_sq/2));

x = (-80:0.1:80)'; %(-0.05:0.001:0.05)';
%px              = px_r.pdf(x).*px_i.pdf(x);

figure(3);
title('Real BPSK');
hold on
histogram(s_bpsk_real, 'Normalization', 'pdf');
hold on
plot(x, px_r.pdf(x), '--', 'Linewidth', 1)
hold on
grid on;
legend('histogram', 'true pdf');
hold off;

figure(4);
title('Imaginary BPSK');
hold on
histogram(s_bpsk_real, 'Normalization', 'pdf');
hold on
plot(x, px_i.pdf(x), '--', 'Linewidth', 1)
hold on
grid on;
legend('histogram', 'true pdf');
hold off;


