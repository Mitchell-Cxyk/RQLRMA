function [H,X] = QBStage(Y,W,Psi,rangefinder)
% QB stage of the randomized one-pass algorithm for quaternion low rank approximation
% input: Sketch Y \in \mathbb Q^{m\times s}, Sketch W \in \mathbb Q^{l\times n}, test matrix Psi \in \mathbb
% Q^{l\times n},  
% input: function handle rangefinder, usage: H = rangefinder(Y); 
% rangefinder = @pseudoQR|@pseudoSVD2

 % Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783



%%%%%% QB approximation with (non-)orthonormal rangefinder H
H=rangefinder(Y);
clear Y;
X=QLEQ(Psi*H,W);
clear W;
clear Psi;

end

