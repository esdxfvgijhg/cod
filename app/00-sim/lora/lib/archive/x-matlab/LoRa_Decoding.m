%
clear all; close all; clc;

% Cockpit of the simulator
SF           = 10;          %Spreading Factor from 7 to 12
BW           = 125000;      %125kHz
Fs           = 125000;      %Sampling Frequency

preamble_len = 8;           %Preamble length
sync_len     = 2;           %Sync length

num_samples  = Fs*(2^SF)/BW;%Number of samples

total_sym    = 100;         %total symbols excluding preamble and sync from 1:100
symbols = [5,100,500,555,1000,200,300,567,100,50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234,672,123,67,382,588,200,300,1000,100,...
           50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234,500,400,600,800,700,200,300,1000,100,50,400,222,666,444,777,555,111,999,...
           525,455,345,456,34,678,234,672,123,67,382,588,200,300,1000,100,50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234];
lora_total_sym = preamble_len + sync_len + total_sym; % Total transmitted symbols

outp = packet(SF,BW,Fs,num_samples,symbols,total_sym);
[decoded_out,FFT_out,data_received] = packet2(SF,BW,Fs,num_samples,lora_total_sym,outp,preamble_len,sync_len);


% Plotting the Spectrogram of Transmitted signal
figure(1);
samples = num_samples/4;
title('Decoded LoRa symbols');
spectrogram(decoded_out,samples,samples-1,samples,Fs,'yaxis');

% Plotting the received frequencies
figure(2);
samp_time = 0:1:num_samples-1;
title('FFT of received LoRa symbols');
for m = 1:1:lora_total_sym
    plot(samp_time,FFT_out(m,:)); hold on;
end
grid on;
