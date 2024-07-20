function im=qm2im(A,N)
% function im=qm2im(A)
% transform  a quaternion matrix A=[A0 A2 A1 A3] to image im(:,:,:) of cell

% by Zhigang Jia On March 6,2018

if nargin<=1
    N=size(A,2)/4;
end
im(:,:,1)=A(:,2*N+1:3*N);
im(:,:,2)=A(:,N+1:2*N);
im(:,:,3)=A(:,3*N+1:4*N);
