function psnrQ=psnrQ(approxA,A)
m=size(A,1);
n=size(A,2);
psnrQ=20*log10(maxQ(A)*sqrt(m*n)/norm(approxA-A,'fro'))