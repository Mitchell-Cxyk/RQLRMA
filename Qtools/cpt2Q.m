function Q = cpt2Q(cptQ)
% convert cpt representation of cptQ to quaternion class:
% cptQ = [Q0 Q1];
% Q = quaternion(real(Q0),imag(Q0),real(Q1),imag(Q1);

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

Q0 = cptQ(:,1:end/2); Q1 = cptQ(:,end/2+1:end);
Q = quaternion(real(Q0),imag(Q0),real(Q1),imag(Q1));

end