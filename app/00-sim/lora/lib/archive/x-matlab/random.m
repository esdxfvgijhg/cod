%% Random sequence generation block
% Inputs:
% total_sym: Total no. of random bits to be generated
% SF: Spreading Factor
% Output:
% Input_sample: Random number in decimals

function [random_number_input, columns] = random(total_sym, SF)

rows = SF;
columns = ceil(total_sym/SF);
random_number_input = round(0.75*rand(1,rows*columns))';


