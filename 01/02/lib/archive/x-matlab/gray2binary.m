%% Gray to Binary Conversion

function [data_received_bin] = gray2binary(data_received_gray)

[r,c] = size(data_received_gray);
data_received_bin = zeros(r,c);

data_received_bin(1,:) = data_received_gray(1,:);   % Copying First bit

for m = 1:1:c
    for g = 2:1:r     % Xor of input bit with last output bit
        data_received_bin(g,m) = xor(data_received_bin(g-1,m), data_received_gray(g,m));
    end
end