clear, clc, close all

% signal parameters
fs = 44100;
T = 30;
N = round(T*fs);

% generate random signal with Laplace distribution
x = randl(520, 1);

% plot the histogram
histfitlaplace(x)
grid on
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Amplitude')
ylabel('Number of samples')
title('Amplitude distribution of the random signal')
legend('Distribution of the signal', 'PDF of the Laplace distribution')