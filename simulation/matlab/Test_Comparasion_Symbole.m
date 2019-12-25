%%
%   Symbol Comparation for LoRa
%%   

clear all; close all; clc;

BW = 125000; % 125kHz
Fs = 20*125000;
inverse = 0;
SF = 7;
num_samples = Fs*(2^SF)/BW;  % Number of samples

% Case 1
symbol = 0;
[out_preamble1] = modulation(SF,BW,Fs,num_samples,symbol,inverse);

% Case 2
symbol = 2;
[out_preamble2] = modulation(SF,BW,Fs,num_samples,symbol,inverse);

% Case 3
symbol = 8;
[out_preamble3] = modulation(SF,BW,Fs,num_samples,symbol,inverse);

% Case 4
symbol = 16;
[out_preamble4] = modulation(SF,BW,Fs,num_samples,symbol,inverse);

% Case 5
symbol = 32;
[out_preamble5] = modulation(SF,BW,Fs,num_samples,symbol,inverse);

% Case 6
symbol = 64;
[out_preamble6] = modulation(SF,BW,Fs,num_samples,symbol,inverse);

outp = [out_preamble1 out_preamble2 out_preamble3 out_preamble4 out_preamble5];
samples = length(out_preamble1)/4;
spectrogram(outp,samples,samples-1,samples*8,Fs,'yaxis');
title('Comparasion of LoRa symbols');
grid on;
axis tight;