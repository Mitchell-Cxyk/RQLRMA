function [H,S,V] = ranQLoRMA(A,varargin)
% This is the main calling function
% randomized one-pass algorithm for quaternion low rank approximation
% A: data matrix
% varargin{1}: target rank r, optional; if calling [H,S,V] = ranQLoRMA(A) without specifing r, 
%              then directly compute the compact QSVD of A by ModifiedcsvdQ77.
% varargin{2}: rangefinder, a function handel, optional = pseudoSVD2|pseudoQR, default = @pseudoSVD2
% varargin{3}: left sketch size s, optional, default = r+5
% varargin{4}: right sketch size l, optional, default = 2s
% varargin{5}: distribution of the test matrices, optional = 'Gaussian'|'Rademacher'|'SparseGaussian'|'subGaussian', 
%              default = 'Gaussian'
% varargin{6}: independence of the entries of the test matrices, 
%               optional = 'entry'|'row'|'column', default = entry (entry-wise independent)
% varargin{7}: power iteration, optional, default = 0; (>0) means running
%               power iteration

% for example, 
%%           [H,S,V] = ranQLoRMA(A,r,@pseudoQR,r+5,2*r+10,'Gaussian','entry',0);
% output the randomized rank-r approximation to A with H*S*V', where H is an orthonormal or
% non-orthonormal quaternion matrix, V is an orthonormal quaternion matrix,
% and S is a diagonal real matrix. This calling is equivalent to
%%           [H,S,V] = ranQLoRMA(A,r,@pseudoQR);

% Authors: Chao Chang, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Chao Chang, Yuning Yang, Randomized Large-Scale Quaternion Matrix Approximation:
%             Practical Rangefinders and One-Pass Algorithm, https://arxiv.org/pdf/2404.14783


if isempty(varargin)
    [H,S,V] = ModifiedcsvdQ77(A);
    return;
end

r = varargin{1};
rangefinder = @pseudoSVD2;  % optional choise = @pseudoQR if you want faster (m>10000)
distr = 'Gaussian';
independence = 'entry';
power=0;
size_input = length(varargin);

switch size_input
    case 1
        s = r+5;
        l = 2*s;
    case 2
        rangefinder = varargin{2};
        s = r+5;
        l = 2*s;
    case 3
        rangefinder = varargin{2};
        s = varargin{3};
        l = 2*s;
    case 4
        rangefinder = varargin{2};
        s = varargin{3};
        l = varargin{4};
    case 5
        rangefinder = varargin{2};
        s = varargin{3};
        l = varargin{4};
        distr = varargin{5};
    case 6
        rangefinder = varargin{2};
        s = varargin{3};
        l = varargin{4};
        distr = varargin{5};
        independence = varargin{6};

 case 7
        rangefinder = varargin{2};
        s = varargin{3};
        l = varargin{4};
        distr = varargin{5};
        independence = varargin{6};
        power=varargin{7};
end

%%%%%% constructing sketches
[m,n] = size(A);
Omega=ConstructTestMatrix(n,s,distr,independence);
Y = A*Omega;
clear Omega;

% default power = 0; if power>0 then run power method to improve the accuracy; of course lost efficiency.
% defaultly we do not do this
for iter=1:power     
    Y=A'*Y;
    Y=A*Y;
end

Psi=ConstructTestMatrix(l,m,distr,independence);
W=Psi*A;
%%%%%% end of constructing sketches


%%%%%% QB approximation with (non-)orthonormal rangefinder H

[H,X] = QBStage(Y,W,Psi,rangefinder);
clearvars Y W Psi;

%%%%% truncation stage using ModifiedcsvdQ77
[H,S,V] = TruncationStage(H,X,r);

end

