%%
clear all; close all; clc;

%% Cockpit of the simulator
SF               = 7:1:12;         %Spreading Factor from 7 to 12
BW               = 125000;         %125kHz
Fs               = 125000;         %Sampling Frequency
preamble_len     = 8;              %Preamble length
sync_len         = 2;              %Sync length
total_bits       = 27720;          %total bits to be transmitted in LoRa message
SNR_dB           = -10:1:-5;       %SNR in DB
SNR              = 10.^(SNR_dB/10);%SNR
Total_iterations = 10;
BER              = zeros(Total_iterations,length(SNR_dB));

for sf = 1:1:length(SF)
    num_samples = Fs*(2^SF(sf))/BW;  % Number of samples

    %% Random Number Generation
    [Input_sample_Bi, input_len] = random(total_bits,SF(sf)); 
    rand_num_matrix = reshape(Input_sample_Bi, SF(sf), input_len);

    % Binary to Gray Conversion
    Input_sample_gray = binary2gray(rand_num_matrix);

    % Binary to Decimal conversion
    symbols = bi2de(Input_sample_gray','left-msb')';
    lora_total_sym = preamble_len + sync_len + input_len;  % Total transmitted symbols

		outp = packet(SF(sf),BW,Fs,num_samples,symbols,input_len);

    for ite = 1:1:Total_iterations
        for snr = 1:1:length(SNR_dB)
            %% Rayleigh Fading Channel
            [fading_channel_out] = rayleigh_Fading_Channel(outp);
            out_channel = awgn(fading_channel_out,SNR_dB(snr),'measured');

						%Functions
						[decoded_out,FFT_out,data_received_De] = packet2(SF(sf),BW,Fs,num_samples,lora_total_sym,out_channel,preamble_len,sync_len);

            % Decimal to Binary Conversion
            data_received_bin = de2bi(data_received_De,SF(sf),'left-msb')';
            % Gray to Binary Conversion
            data_received_gray = gray2binary(data_received_bin);
            % Matrix to array conversion
            data_received = reshape(data_received_gray,total_bits,1);
            
            %% BER Calculation
            BER(ite,snr) = sum(abs(data_received - Input_sample_Bi))/total_bits;
        end
    end
    Avg_BER(sf,:) = mean(BER);   % Average BER over all the iterations
    clear FFT_out;
    clear outp;
    clear decoded_out;
    clear data_received_De;
    clear data_received_gray;
end

% Plotting the BER vs SNR curve
semilogy(SNR_dB,Avg_BER);
title('BER vs SNR');
xlabel('SNR (Signal to Noise ratio in dB)');
ylabel('BER (Bit Error Rate)');
legend('SF7','SF8','SF9','SF10','SF11','SF12');
grid on;
