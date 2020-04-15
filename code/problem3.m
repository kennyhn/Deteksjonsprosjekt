close all; clc


%% Load data
x_h0        = load('Dataset/T3_data_x_H0.mat').T3_data_x_H0;
x_h1        = load('Dataset/T3_data_x_H1.mat').T3_data_x_H1;

sigma_w     = load('Dataset/T3_data_sigma_w.mat').w;
sigma_s     = load('Dataset/T3_data_sigma_s.mat').s_t;

