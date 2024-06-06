% For testing the whole one-pass alg with practical rangefinder
addpath DataGenerate/
addpath qtfm/
addpath Qtools/

m = 10000; n = 10000; R = 1000;
M = GenerateLowRankPlusNoise(m,n,R,'low');

[H,S,V] = ranQLoRMA(M,R);

fprintf('relative error of ranQLoRMA: %.4f\n', normQf(M-H*S*V')/normQf(M))