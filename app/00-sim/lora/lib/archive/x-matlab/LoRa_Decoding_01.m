%
clear all; close all; clc;

% Cockpit of the simulator
SF           = 8;  % Spreading Factor
BW           = 125000; %125kHz
Fs           = 2*125000;
num_samples  = Fs*(2^SF)/BW;
total_sym    = 1;
preamble_len = 8;
sync_len     = 1;

symbols = [70,80,600,800,700,200,300,1000,100,50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234,672,123,67,382,588,200,300,1000,100,...
           50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234,500,400,600,800,700,200,300,1000,100,50,400,222,666,444,777,555,111,999,...
           525,455,345,456,34,678,234,672,123,67,382,588,200,300,1000,100,50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234];


outp = packet(SF,BW,Fs,num_samples,symbols,total_sym);
[decoded_out,FFT_out,data_received] = packet2(SF,BW,Fs,num_samples,lora_total_sym,outp,preamble_len,sync_len);

samp_fft = Fs*(-num_samples/2 : num_samples/2-1)/num_samples;
samp_time = 1:1:num_samples*10;

samples = num_samples/4;
%spectrogram(decoded_out,samples,samples-1,samples,Fs,'yaxis');
title('LoRa Symble Decoding [8 preamble, 2 Sync, 100 Symbols]');
plot(samp_time,decoded_out);
grid on;

