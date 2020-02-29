%
clear all; close all; clc;

BW = 125000; % 125kHz Bandwidth
Fs = 10^6;        % Sampling Frequency
inverse = 0;      % inverse = 1 for inverse chirps, inverse = 0 for normal chirps

% Case 1
SF = 7;
num_samples = Fs*(2^SF)/BW;  % Number of samples
[out_preamble1] = modulation(SF,BW,Fs,num_samples,0,inverse);

% Case 2
SF = 8;
num_samples = Fs*(2^SF)/BW;  % Number of samples
[out_preamble2] = modulation(SF,BW,Fs,num_samples,0,inverse);

% Case 3
SF = 9;
num_samples = Fs*(2^SF)/BW;  % Number of samples
[out_preamble3] = modulation(SF,BW,Fs,num_samples,0,inverse);

% Case 4
SF = 10;
num_samples = Fs*(2^SF)/BW;  % Number of samples
[out_preamble4] = modulation(SF,BW,Fs,num_samples,0,inverse);

% Case 5
SF = 11;
num_samples = Fs*(2^SF)/BW;  % Number of samples
[out_preamble5] = modulation(SF,BW,Fs,num_samples,0,inverse);

% Case 6
SF = 12;
num_samples = Fs*(2^SF)/BW;  % Number of samples
[out_preamble6] = modulation(SF,BW,Fs,num_samples,0,inverse);

outp = [out_preamble1 out_preamble2 out_preamble3 out_preamble4 out_preamble5 out_preamble6];
samples = length(out_preamble1)/4;
spectrogram(outp,samples,samples-1,samples*2,Fs,'yaxis');
title('Comparasion of LoRa Spreading Factors: SF 7 to SF 12');
grid on;
axis tight;
