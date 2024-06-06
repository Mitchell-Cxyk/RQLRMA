% For testing the whole one-pass alg with practical rangefinder
addpath DataGenerate/
addpath qtfm/
addpath Qtools/

m = 5000; n = 4000; R = 500;
M = GenerateLowRankPlusNoise(m,n,R,'low');

tic,
[H,S,V] = ranQLoRMA(M,R);
t_pseudosvd = toc;
fprintf('relative error of ranQLoRMA with pseudoSVD: %.4f, time = %.4f\n', normQf(M-H*S*V')/normQf(M),t_pseudosvd)

tic,
[H,S,V] = ranQLoRMA(M,R,@pseudoQR);
t_pseudoqr = toc;
fprintf('relative error of ranQLoRMA with pseudoQR: %.4f, time = %.4f\n', normQf(M-H*S*V')/normQf(M),t_pseudoqr)
