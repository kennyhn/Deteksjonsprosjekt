
function problem5_f
    %% Data handling
    sigma_w  = load(['Dataset/' ...
        'T3_data_sigma_w.mat']).w;
    sigma_s  = load(['Dataset/'...
        'T3_data_sigma_s.mat']).s_t;

    [K, ~]    = size(sigma_w);

    %% Estimate
    sigma_w_sq_hat  = sum(abs(sigma_w).^2)/K;
    sigma_s_sq_hat  = sum(abs(sigma_s).^2)/K;


    %% Figures
    x           = 0:0.01:300;

    figure(1);
    title('$\chi^2 distribution$',...
        'Interpreter', 'latex', 'fontsize', 22);
    hold on
    for k = (0:2)
        doF         = 2*10^k;
        chi_sq      = pdf('Chisquare', x, doF)';
        plot(x, chi_sq, 'Linewidth', 1,...
            'DisplayName', ['doF: '...
            num2str(doF)]);
        hold on
    end
    legend('show', 'fontsize', 18);
    hold on
    xlabel('x', 'fontsize', 14);
    hold on
    ylabel('p(x)', 'fontsize', 14);
    hold on
    grid on;
    hold off


    %% Calculate and plot ROC
    figure(2);
    title('ROC for different values of doF', 'fontsize', 22);
    hold on

    for i = (0:3)
        doF     = 2*10^i;
        x       = 0:0.1:2500;
        p_FA    = 1-gamcdf(x, doF, sigma_w_sq_hat);
        p_D     = 1-gamcdf(x, doF, ...
            (sigma_w_sq_hat+sigma_s_sq_hat));
        plot(p_FA, p_D, 'Linewidth', 1,...
            'DisplayName', ['doF: ' num2str(2*10^i)]);
        hold on

    end
    legend('show', 'fontsize', 18);
    hold on
    grid on;
    hold on
    xlabel('$p_{FA}$', 'Interpreter', 'latex',...
        'fontsize', 14);
    hold on
    ylabel('$p_{D}$', 'Interpreter', 'latex',...
        'fontsize', 14);
    hold off;
end
