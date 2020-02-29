%%
addpath('lib');
clear all; close all; clc;

Total_iterations = 10;

SF               = 7:1:12;          % Spreading Factor from 7 to 12
BW               = [125000,250000,500000];          % 10400,15600,20800,31250,41700,62500,
Fs               = [125000,250000,500000];          % Sampling Frequency
TXP              = [10,11,12,13,14];

preamble_len     = 8;               % Preamble length
sync_len         = 2;               % Sync length
msg              = [10, 30, 50, 70, 90, 110];           % total bits to be transmitted in LoRa message

SNR_dB           = [-40, -30, -20, -10, 0]  %-40:1:00;        % SNR in DB
%SNR              = 10.^(SNR_dB/10); % SNR
NF=6;
S = 0;
link_budget = 0;

crc = 0;
cr  = 0;
h   = 0;
de  = 1;

%fileID = fopen('exp.csv','w');
%fprintf('BW, SF, SNR, PS, BER\n');
%for txp = 1:1:length(TXP)
	for bw = 1:1:length(BW)
		for sf = 1:1:length(SF)
			for snr = 1:1:length(SNR_dB)
				for m = 1:1:length(msg)
					hu=0;
					BER                                      = zeros(Total_iterations,length(SNR_dB));
					total_bits                               = SF(sf)*msg(m);           % total bits to be transmitted in LoRa message
					num_samples                              = Fs(bw)*(2^SF(sf))/BW(bw);                                                                   % Number of samples           
					[Input_sample_Bi, input_len]             = random(total_bits,SF(sf));                                                           % Random Number Generation    
					rand_num_matrix                          = reshape(Input_sample_Bi, SF(sf), input_len);                                           %                            
					Input_sample_gray                        = binary_gray(rand_num_matrix);                                                           % Binary to Gray Conversion   
					symbols                                  = bi2de(Input_sample_gray','left-msb')';                                                  % Binary to Decimal conversion
					lora_total_sym                           = preamble_len + sync_len + input_len;                                                    % Total transmitted symbols   
					outp                                     = packet_tx(SF(sf),BW(bw),Fs(bw),num_samples,symbols,input_len);                             %                            
					for ite = 1:1:length(Total_iterations)
						out_channel                            = awgn(outp,SNR_dB(snr),'measured');                                                      % AWGN Channel                
						[decoded_out,FFT_out,data_received_De] = packet_rx(SF(sf),BW(bw),Fs(bw),num_samples,lora_total_sym,out_channel,preamble_len,sync_len); %                            
						data_received_bin                      = de2bi(data_received_De,SF(sf),'left-msb')';                                             % Decimal to Binary Conversion
						data_received_gray                     = gray_binary(data_received_bin);                                                         % Gray to Binary Conversion   
						data_received                          = reshape(data_received_gray,total_bits,1);                                           % Matrix to array conversion  
						hu                                     = hu+sum(abs(data_received - Input_sample_Bi))/total_bits;                                   % BER Calculation             
						clear FFT_out;
						clear outp;
						clear decoded_out;
					end
					hu=hu/Total_iterations;
					S=-174+10*log10(BW(bw))+NF+SNR_dB(snr); % https://smartmakers.io/en/lorawan-range-part-1-the-most-important-factors-for-a-good-lorawan-signal-range/
%					link_budget=max(S)-max(TXP(txp));
					
					t_sym  = 2^SF(sf)/BW(bw);
					sym_nb = (msg(m)-4*SF(sf)+28+16*crc-20*h)/(4*(SF(sf)-2*de));
					t_pre  = t_sym*(preamble_len+4.2);
					t_pay  = t_sym*(8+max(ceil(sym_nb)*(cr+4),0));
					toa    = t_pre+t_pay;
					
					fprintf('%d,%d,%d,%d,%f4,%f4,%f4\n', BW(bw), SF(sf), SNR_dB(snr), total_bits, hu, S, toa);
				end
			end
		end
	end
%end
%fclose(fileID);







%	Avg_BER = mean(BER);	 % Average BER over all the iterations

% Plotting the BER vs SNR curve
%semilogy(SNR_dB,Avg_BER,'-*b');
%title('BER vs SNR');
%xlabel('SNR (Signal to Noise ratio in dB)');
%ylabel('BER (Bit Error Rate)');
%grid on;
