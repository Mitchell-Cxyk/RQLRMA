function Qa=Qc2Qa(Qc)
% convert the compact complex representation Qc to Qa = J\overline{Qc}

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783

Qa=zeros(size(Qc));
Qa(1:end/2,:)=-conj(Qc(end/2+1:end,:));
Qa(end/2+1:end,:)=conj(Qc(1:end/2,:));