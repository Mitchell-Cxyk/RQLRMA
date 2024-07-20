function myimshowQ(f)
% by Zhigang Jia On March 6,2018
[m,n] = size(f);
n=n/4;
im = zeros(m+2,n+2,3);
im(2:end-1,2:end-1,1)=f(:,2*n+1:3*n);
im(2:end-1,2:end-1,2)=f(:,n+1:2*n);
im(2:end-1,2:end-1,3)=f(:,3*n+1:4*n);
imshow(im);
