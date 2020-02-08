%
clear all; close all; clc;
Fs = 8*125000;

% Case 01
		SF = 10;	% Spreading Factor
		BW = 125000; %125kHz
		num_samples = Fs*(2^SF)/BW;

		%Preamble Generation
		inverse = 0;
		[out_preamble] = modulation(SF,BW,Fs,num_samples,0,inverse);
		outp = out_preamble;

% Case 02
		SF = 11;	% Spreading Factor
		BW = 250000; %125kHz
		num_samples = Fs*(2^SF)/BW;

		%Preamble Generation
		inverse = 0;
		[out_preamble] = modulation(SF,BW,Fs,num_samples,0,inverse);
		outp = [outp out_preamble];
		
% Case 03
		SF = 12;	% Spreading Factor
		BW = 500000; %125kHz
		num_samples = Fs*(2^SF)/BW;

		%Preamble Generation
		inverse = 0;
		[out_preamble] = modulation(SF,BW,Fs,num_samples,0,inverse);
		outp = [outp out_preamble];

samples = num_samples/32;
spectrogram(outp,samples,samples-1,samples,Fs,'yaxis');
title('LoRa Orthogonal Symbols]');
grid on;

