clear
clc


addpath BASICOPS\


A = randq(500,750);

%% QR decomposition

tic
[Q1,R1] = qr(A);
t_qr = toc;

tic
[Q2,R2] = qrQ(A);
t_qr_real = toc;

norm(Q1-Q2,'fro');
norm(R1-R2,'fro');

%% SVD

tic
[U1,S1,V1] = svdQ(A);
t_svd_complex = toc;

tic
[U2,S2,V2] = R_svdQ(A);
t_svd_real = toc;


%%

time_qr_quat_and_real = [t_qr t_qr_real]

time_svd_complex_and_real = [t_svd_complex t_svd_real]



