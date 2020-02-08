%
clear all; close all; clc;

SF          = 8;  % Spreading Factor
BW          = 125000; %125kHz
Fs          = 4*125000;
num_samples = Fs*(2^SF)/BW/2;
total_sym   = 1;
symbols     = [150,32,80,320,640,200,300,567,100,50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234,672,123,67,382,588,200,300,1000,100,...
           50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234,500,400,600,800,700,200,300,1000,100,50,400,222,666,444,777,555,111,999,...
           525,455,345,456,34,678,234,672,123,67,382,588,200,300,1000,100,50,400,222,666,444,777,555,111,999,525,455,345,456,34,678,234];

outp = packet(SF,BW,Fs,num_samples,symbols,total_sym);
[decoded_out,FFT_out,data_received] = packet2(SF,BW,Fs,num_samples,lora_total_sym,outp,preamble_len,sync_len);


samples = num_samples/4;
%spectrogram(decoded_out,samples,samples-1,samples,Fs,'yaxis');
title('LoRa Symble Decoding [8 preamble, 2 Sync, 15 Symbols]');
grid on;

