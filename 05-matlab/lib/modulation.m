% Matlab function to Modulate LoRa symbols

function out_preamble = modulation(SF,BW,Fs,num_samples,symbol,inverse)
		%initialization
		phase = 0;
		Frequency_Offset = (Fs/2) - (BW/2);

		shift = symbol;
		out_preamble = zeros(1,num_samples);

		for k=1:num_samples
				%output the complex signal
				out_preamble(k) = cos(phase) + 1i*sin(phase);
		
				% Frequency from cyclic shift
				f = BW*shift/(2^SF);
				if(inverse == 1)
							 f = BW - f;
				end
		
				%apply Frequency offset away from DC
				f = f + Frequency_Offset;
		
				% Increase the phase according to frequency
				phase = phase + 2*pi*f/Fs;
				if phase > pi
						phase = phase - 2*pi;
				end
		
				%update cyclic shift
				shift = shift + BW/Fs;
				if shift >= (2^SF)
						shift = shift - 2^SF;
				end
		end
end
