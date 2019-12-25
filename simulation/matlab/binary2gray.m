%% Binary to Gray Conversion

function [Input_sample_gray] =  binary2gray(Input_sample_Bi)

[r,c] = size(Input_sample_Bi);
Input_sample_gray = zeros(r,c);

Input_sample_gray(1,:) = Input_sample_Bi(1,:);   % Copying First bit

for m = 1:1:c
    for g = 2:1:r      % Xor of input bit with last input bit
        Input_sample_gray(g,m) = xor(Input_sample_Bi(g,m), Input_sample_Bi(g-1,m));
    end
end