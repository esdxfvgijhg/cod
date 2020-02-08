%
clear all; close all; clc;

SF          = 8;  % Spreading Factor
BW          = 125000; %125kHz
Fs          = (10^6);
num_samples = Fs*(2^SF)/BW;
symbols     = [1,11,123,13,55];
total_sym   = 5;

outp = packet(SF,BW,Fs,num_samples,symbols,total_sym);

samp_fft = Fs*(-num_samples/2 : num_samples/2-1)/num_samples;
samp_time = 1:1:num_samples*15;

for m = 1:15 
    FFT_out((m-1)*num_samples + 1 : m*num_samples) = abs(fftshift(fft(outp((m-1)*num_samples + 1 : m*num_samples))));
end
samples = num_samples/8;
%spectrogram(outp,samples,samples-1,samples*2,Fs,'yaxis');
title('LoRa Symbles [8 preamble, 2 Sync, 5 Symbols]');
plot(samp_time,FFT_out);
grid on;

