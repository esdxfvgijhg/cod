% Matlab function to Modulate LoRa symbols

function outp = packet_tx(SF,BW,Fs,num_samples,symbols,total_sym)
	%Preamble Generation
	inverse = 0;
	preamble_len = 8;
	for i = 1:preamble_len
			[out_preamble] = modulation(SF,BW,Fs,num_samples,0,inverse);
			outp((i-1)*num_samples+1 : i*num_samples) = out_preamble;
	end

	%Sync Symble Generation
	inverse = 1;
	sync_len = 2;
	for i = 1:sync_len
			[out_sync] = modulation(SF,BW,Fs,num_samples,32,inverse);
			outp = [outp out_sync];
	end

	%Symble Generation
	inverse = 0;
	% symbols = [1,11,123,13,55];
	for i = 1:total_sym
			[out_sym] = modulation(SF,BW,Fs,num_samples,symbols(i),inverse);
			outp = [outp out_sym];
	end
end


