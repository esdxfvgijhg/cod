%%
addpath('lib');
clear all; close all; clc;

Total_iterations = 10;

SF               = 7:1:12;          										% Spreading Factor from 7 to 12
BW               = [125000,250000,500000];        		  % 10400,15600,20800,31250,41700,62500,
FS               = [1];    						    		        % Sampling Frequency
TXP              = [10,11,12,13,14];

preamble_len     = 8;             										  % Preamble length
sync_len         = 2;               										% Sync length
msg              = [10, 30, 50, 70, 90, 110];           % total bits to be transmitted in LoRa message

SNR_dB           = [-40, -30, -20, -10, 0]              %-40:1:00;        % SNR in DB
S                = 0;
link_budget      = 0;

NF  = 6;
crc = 0;
cr  = 0;
h   = 0;
de  = 1;


fileID = fopen('S.csv','w');
fprintf(fileID,'BW, SF, PS, SNR, BER, RSSI, ToA\n');

%for txp = 1:1:length(TXP)
	for bw = 1:1:length(BW)
		for fs = 1:1:length(FS)
			for sf = 1:1:length(SF)
				for m = 1:1:length(msg)
					for snr = 1:1:length(SNR_dB)
						ber                                      = 0;
						BER                                      = zeros(Total_iterations,length(SNR_dB));
						fsn                                      = FS(fs)*BW(bw);

						total_bits                               = SF(sf)*msg(m);           % total bits to be transmitted in LoRa message
						num_samples                              = fsn*(2^SF(sf))/BW(bw);                                                                   % Number of samples           
						[Input_sample_Bi, input_len]             = random(total_bits,SF(sf));                                                           % Random Number Generation    
						lora_total_sym                           = preamble_len + sync_len + input_len;                                                    % Total transmitted symbols   

						rand_num_matrix                          = reshape(Input_sample_Bi, SF(sf), input_len);                                           %                            
						Input_sample_gray                        = binary_gray(rand_num_matrix);                                                           % Binary to Gray Conversion   
						symbols                                  = bi2de(Input_sample_gray','left-msb')';                                                  % Binary to Decimal conversion

						outp                                     = packet_tx(SF(sf),BW(bw),fsn,num_samples,symbols,input_len);                             %                            
						for ite = 1:1:length(Total_iterations)
							[fading_channel_out]                   = channel_rayleigh_fading(outp); % Rayleigh Fading Channel
							out_channel                            = awgn(fading_channel_out,SNR_dB(snr),'measured');                                                      % AWGN Channel                

							[decoded_out,FFT_out,data_received_De] = packet_rx(SF(sf),BW(bw),fsn,num_samples,lora_total_sym,out_channel,preamble_len,sync_len); %                            
							data_received_bin                      = de2bi(data_received_De,SF(sf),'left-msb')';                                             % Decimal to Binary Conversion
							data_received_gray                     = gray_binary(data_received_bin);                                                         % Gray to Binary Conversion   
	%					data_received                          = reshape(de2bi(data_received_De,SF),total_bits,1);
							data_received                          = reshape(data_received_gray,total_bits,1);                                           % Matrix to array conversion  

							ber                                    = ber+sum(abs(data_received - Input_sample_Bi))/total_bits;                                   % BER Calculation             
%							BER(ite, snr)                          = sum(abs(data_received - Input_sample_Bi))/message;                              % BER Calculation
							clear FFT_out;
							clear outp;
							clear decoded_out;
%							clear data_received_De;
%							clear data_received_gray;
						end
%						avg_BER = mean(BER);	 % Average BER over all the iterations
						ber=ber/Total_iterations;
						rssi=-174+10*log10(BW(bw))+NF+SNR_dB(snr); % https://smartmakers.io/en/lorawan-range-part-1-the-most-important-factors-for-a-good-lorawan-signal-range/
	%					link_budget=max(S)-max(TXP(txp));
						
						t_sym  = 2^SF(sf)/BW(bw);
						sym_nb = (msg(m)-4*SF(sf)+28+16*crc-20*h)/(4*(SF(sf)-2*de));
						t_pre  = t_sym*(preamble_len+4.2);
						t_pay  = t_sym*(8+max(ceil(sym_nb)*(cr+4),0));
						toa    = t_pre+t_pay;
						
						fprintf(fileID, '%d,%d,%d,%d,%f2,%f2,%f2\n', BW(bw), SF(sf), msg(m), SNR_dB(snr), ber, rssi, toa);
					end
				end
			end
		end
	end
%end
fclose(fileID);















%outp = packet_tx(SF,BW,Fs,num_samples,symbols,total_sym);
%out_channel = awgn(outp,SNR_dB(snr),'measured'); % AWGN Channel
%[decoded_out,FFT_out,data_received] = packet_rx(SF,BW,Fs,num_samples,lora_total_sym,out_channel,preamble_len,sync_len);





%samp_fft  = Fs*(-num_samples/2 : num_samples/2-1)/num_samples;
%samp_time = 1:1:num_samples*10;

% -------------------------- PLot ---------------------------

%% Plotting the Spectrogram of Transmitted signal
%figure(1);
%samples = num_samples/8;
%title('Transmitted LoRa symbols');
%spectrogram(outp,samples,samples-1,samples*2,Fs,'yaxis');


%disp(data_received);
%samples = num_samples/4;
%%spectrogram(decoded_out,samples,samples-1,samples,Fs,'yaxis');
%title('LoRa Symble Decoding [8 preamble, 2 Sync, 15 Symbols]');
%grid on;

%samples = num_samples/4;
%%spectrogram(decoded_out,samples,samples-1,samples,Fs,'yaxis');
%title('LoRa Symble Decoding [8 preamble, 2 Sync, 100 Symbols]');
%plot(samp_time,decoded_out);
%grid on;

%% Plotting the Spectrogram of Transmitted signal
%figure(1);
%samples = num_samples/4;
%title('Decoded LoRa symbols');
%spectrogram(decoded_out,samples,samples-1,samples,Fs,'yaxis');

%% Plotting the received frequencies
%figure(2);
%samp_time = 0:1:num_samples-1;
%title('FFT of received LoRa symbols');
%for m = 1:1:lora_total_sym
%		plot(samp_time,FFT_out(m,:)); hold on;
%end
%grid on;



% Plotting the BER vs SNR curve
%semilogy(SNR_dB,Avg_BER,'-*b');
%title('BER vs SNR');
%xlabel('SNR (Signal to Noise ratio in dB)');
%ylabel('BER (Bit Error Rate)');
%grid on;
