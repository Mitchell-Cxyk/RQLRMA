function H=pseudoQR(A)
% This is the pseudo-QR rangefinder implementation. 
% Input: sketch matrix A 
% Output: non-orthonormal H that range(H) = range(A); if cond(A) <1e8 then cond(H) < 10 
% first a complex QR step, followed by solving H'*HX = H' three times as the
% correction steps

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

H=complexQR(A);
for iter=1:3
    %disp('stablize');
Z=QLEQL(H,H'*H);
Pro=randq(size(Z,2),1);
for iterPower=1:2
Pro=Pro/norm(Pro);
Pro=Z*Pro;
Pro=Z'*Pro;
epsilon=sqrt(norm(Pro));
end
H=H+Z/epsilon;
end
end