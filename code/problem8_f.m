
function problem8_f
    %% Load data
    signal  = load(['Dataset/T8_numerical'...
        '_experiment.mat']).T8_numerical_experiment;

    %% Statistics data

    [N, K]      = size(signal);
    sigma_w_sq  = 1;
    sigma_s_sq  = 5;

    alpha_0     = 0.1;  % Choose maxlimit p_FA = 0.1
    alpha_1     = 0.01; % Choose maxlimit p_FA = 0.01

    results     = zeros(N, 1);
    T_x         = sum(abs(signal).^2, 2);

    %% Detector    

    mu_h0           = K*sigma_w_sq;
    sigma_h0        = sqrt(K)*sigma_w_sq;
    lambda_prime    = norminv(1 - alpha_0, mu_h0, sigma_h0);

    results         = gt(T_x, lambda_prime);


    mu_h0           = K*sigma_w_sq;
    sigma_h0        = sqrt(K)*sigma_w_sq;
    p_fa            = 1 - normcdf(lambda_prime,...
        mu_h0, sigma_h0);

    mu_h1           = K*(sigma_w_sq+sigma_s_sq);
    sigma_h1        = sqrt(K)*(sigma_w_sq+sigma_s_sq);
    p_d             = 1 - normcdf(lambda_prime,...
        mu_h1, sigma_h1);
end