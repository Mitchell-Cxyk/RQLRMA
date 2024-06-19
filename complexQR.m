function Q=complexQR(A)
% for a quaternion sketch A, compute the QR decomposition of its compact
% complex representation A_c

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783


Y=[A.w+i*A.x;-conj(A.y+i*A.z)];
[Q1,~]=qr(Y,0);
Q.w=real(Q1(1:end/2,:));
Q.x=imag(Q1(1:end/2,:));
Q.y=real(-conj(Q1(end/2+1:end,:)));
Q.z=imag(-conj(Q1(end/2+1:end,:)));
Q=quaternion(Q.w,Q.x,Q.y,Q.z);
end

