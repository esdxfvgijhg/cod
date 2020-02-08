%%
clear all; close all; clc;

%% Cockpit of the simulator
SF               = 8;              %Spreading Factor from 7 to 12
BW               = 125000;         %125kHz
Fs               = 125000;         %Sampling Frequency
preamble_len     = 8;              %Preamble length
sync_len         = 2;              %Sync length
total_bits       = SF*10;          %total bits to be transmitted in LoRa message
SNR_dB           = 0:1:10;         %SNR in DB
SNR              = 10.^(SNR_dB/10);%SNR
Total_iterations = 10;
BER              = zeros(Total_iterations,length(SNR_dB));
num_samples      = Fs*(2^SF)/BW;  % Number of samples

%% Random Number Generation
[Input_sample_Bi, input_len] = random(total_bits,SF); 

% Binary to Decimal conversion
rand_num_matrix = reshape(Input_sample_Bi, input_len, SF);
symbols = (bi2de(rand_num_matrix))';
lora_total_sym = preamble_len + sync_len + input_len;  % Total transmitted symbols


outp = packet(SF,BW,Fs,num_samples,symbols,input_len);

for ite = 1:1:Total_iterations
  for snr = 1:1:length(SNR_dB)
      %% Rayleigh Fading Channel
      [fading_channel_out] = rayleigh_Fading_Channel(outp);
      out_channel = awgn(fading_channel_out,SNR_dB(snr),'measured');

			[decoded_out,FFT_out,data_received_De] = packet2(SF,BW,Fs,num_samples,lora_total_sym,out_channel,preamble_len,sync_len);
      data_received = reshape(de2bi(data_received_De,SF),total_bits,1);

      %% BER Calculation
      BER(ite,snr) = sum(abs(data_received - Input_sample_Bi))/total_bits;
  end
end

Avg_BER = mean(BER);   % Average BER over all the iterations

% Plotting 
% Plotting the BER vs SNR curve
semilogy(SNR_dB,Avg_BER,'-*b');
title('BER vs SNR');
xlabel('SNR (Signal to Noise ratio in dB)');
ylabel('BER (Bit Error Rate)');
grid on;
