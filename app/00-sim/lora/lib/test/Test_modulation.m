%
clear all; close all; clc;

SF					= 7;	% Spreading Factor
BW					= 100; %125kHz
Fs					= 2*BW;
num_samples = Fs*(2^SF)/BW;

%Preamble Generation
inverse = 0;
preamble_len = 1;
for i = 1:preamble_len
		[out_preamble] = modulation(SF,BW,Fs,num_samples,0,inverse);
		outp((i-1)*num_samples+1 : i*num_samples) = out_preamble;
end

% Plotting the Spectrogram of Transmitted signal
figure(1);
samples = num_samples/8;
title('Transmitted LoRa symbols');
spectrogram(outp,samples,samples-1,samples,Fs,'yaxis');
