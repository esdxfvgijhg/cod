clear all; close all; clc;

data = [1 0 0 1; 0 0 1 0; 1 1 1 1; 0 1 0 0];

gr = binary2gray(data);
bi = gray2binary(gr);

result = bi-data;