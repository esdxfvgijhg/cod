% Matlab function to Modulate LoRa symbols

function [decoded_out,FFT_out,data_received] = packet_rx(SF,BW,Fs,num_samples,lora_total_sym,outp,preamble_len,sync_len)
	
	%% Reverse chirp generation for receiver
	inverse = 1;
	[out_reverse] = modulation(SF,BW,Fs,num_samples,0,inverse);
	
	% Multiplying with the reverse chirp 
	for n = 1:1:lora_total_sym
			decoded_out((n-1)*num_samples + 1 : n*num_samples) = (outp((n-1)*num_samples + 1 : n*num_samples).*out_reverse);
	end
	
	%% Calculating FFT
	for m = 1:1:lora_total_sym
			FFT_out(m,:) = abs((fft(decoded_out((m-1)*num_samples + 1 : m*num_samples))));
	end

	%% Decoding the received data
	k=1;
	for m = preamble_len+sync_len+1:1:lora_total_sym
		[r,c] = max(FFT_out(m,:));
		data_received(k) = c-1;
		k = k+1;
	end
end


